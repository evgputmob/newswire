import 'dart:async';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/=models=/section.dart';
import 'package:newswire/data/i_newswire_service.dart';
import 'package:newswire/data/implementations/hive_adapters/multimedia_item_adapter.dart';
import 'package:newswire/data/implementations/hive_adapters/news_item_adapter.dart';
import 'package:newswire/data/implementations/hive_adapters/related_url_adapter.dart';
import 'package:newswire/data/implementations/hive_adapters/section_adapter.dart';
//import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'constants.dart';

class NewswireService implements INewswireService {
  late final String _apiKey;
  late final Dio _dio;
  late final Connectivity _connectivity;

  List<NewsItem> _news = [];

  @override
  UnmodifiableListView<NewsItem> get news => UnmodifiableListView(_news);

  @override
  final eventsStreamController = StreamController<String>.broadcast();

  void _initHiveAdapters() {
    Hive.registerAdapter(SectionAdapter());
    Hive.registerAdapter(RelatedUrlAdapter());
    Hive.registerAdapter(MultimediaItemAdapter());
    Hive.registerAdapter(NewsItemAdapter());
  }

  NewswireService() {
    _apiKey = dotenv.env['NewswireApiKey'] ?? '';
    _dio = Dio(kDioOptions);
    _connectivity = Connectivity();
    _initHiveAdapters();

    Timer.periodic(const Duration(seconds: kReReadNewsIntervalInSeconds),
        (timer) async {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        try {
          await getLatestNews();
        } catch (e) {
          //print(e);
        }
      }
    });

    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     //error: true,
    //     //compact: true,
    //     //maxWidth: 90,
    //   ),
    // );
  }

  final Function _deepEq = const DeepCollectionEquality().equals;

  @override
  Future<void> getLatestNews() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // There is no Internet connection
      try {
        final box = await Hive.openBox<NewsItem>(kNewsBoxName);
        final List<NewsItem> localNews = box.values.toList();
        if (localNews.isEmpty) return Future.error(kNoInternetConnection);
        if (!_deepEq(localNews, _news)) {
          _news = localNews;
          eventsStreamController.add(kNewsHasBeenChangedEvent);
        }
      } catch (e) {
        return Future.error(kNoInternetConnection);
      }
    } else {
      // We have Internet connection
      try {
        final response = await _dio.get('/all/all.json?api-key=$_apiKey');
        final newsJsonArr = response.data['results'] as List<dynamic>;
        final latestNews =
            newsJsonArr.map((item) => NewsItem.fromJson(item)).toList();
        if (!_deepEq(latestNews, _news)) {
          _news = latestNews;
          eventsStreamController.add(kNewsHasBeenChangedEvent);
          await _putNewsIntoLocalStorage();
        } else {
          //print('Nothing new');
        }
      } on DioError catch (e) {
        return Future.error(e.message);
      } catch (e) {
        return Future.error('Network error');
      }
    }
  }

  Future<void> _putNewsIntoLocalStorage() async {
    final box = await Hive.openBox<NewsItem>(kNewsBoxName);
    final List<NewsItem> localNews = box.values.toList();
    List<NewsItem> newsToSave = [];
    for (var newsItem in _news) {
      newsToSave.add(newsItem);
      localNews.remove(newsItem);
    }
    for (var newsItem in localNews) {
      newsToSave.add(newsItem);
    }
    if (newsToSave.length > kMaxLocalNewsCount) {
      newsToSave = newsToSave.sublist(0, kMaxLocalNewsCount);
    }
    box.clear();
    for (var newsItem in newsToSave) {
      box.put('${newsItem.slugName}-${newsItem.uri}', newsItem);
    }
  }

  @override
  Future<List<Section>> getSections() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // There is no Internet connection
      try {
        final box = await Hive.openBox<Section>(kSectionsBoxName);
        final List<Section> sections = box.values.toList();
        if (sections.isEmpty) return Future.error(kNoInternetConnection);
        return sections;
      } catch (e) {
        return Future.error(kNoInternetConnection);
      }
    } else {
      // We have Internet connection
      try {
        final response = await _dio.get('/section-list.json?api-key=$_apiKey');
        final sectionsJsonArr = response.data['results'] as List<dynamic>;
        final sections =
            sectionsJsonArr.map((item) => Section.fromJson(item)).toList();
        // put sections into local storage
        final box = await Hive.openBox<Section>(kSectionsBoxName);
        for (var i = 0; i < sections.length; i++) {
          await box.put('section$i', sections[i]);
        }
        return sections;
      } on DioError catch (e) {
        return Future.error(e.message);
      } catch (e) {
        return Future.error('Network error');
      }
    }
  }
}
