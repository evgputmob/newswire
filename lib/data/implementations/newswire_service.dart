import 'dart:async';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/=models=/section.dart';
import 'package:newswire/data/i_newswire_service.dart';
//import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'constants.dart';

class NewswireService implements INewswireService {
  late final Dio _dio;
  late final String _apiKey;

  List<NewsItem> _news = [];

  @override
  UnmodifiableListView<NewsItem> get news => UnmodifiableListView(_news);

  @override
  final eventsStreamController = StreamController<String>.broadcast();

  NewswireService() {
    _apiKey = dotenv.env['NewswireApiKey'] ?? '';
    _dio = Dio(kDioOptions);

    Timer.periodic(const Duration(seconds: kReReadNewsIntervalInSeconds),
        (timer) async {
      try {
        await getLatestNews();
      } catch (e) {
        print(e);
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
    try {
      final response = await _dio.get('/all/all.json?api-key=$_apiKey');
      final newsJsonArr = response.data['results'] as List<dynamic>;
      final latestNews =
          newsJsonArr.map((item) => NewsItem.fromJson(item)).toList();
      if (!_deepEq(latestNews, _news)) {
        _news = latestNews;
        //print('Add event to stream');
        eventsStreamController.add(kNewsHasBeenChangedEvent);
      } else {
        //print('Nothing new');
      }
    } on DioError catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error('Network error');
    }
  }

  @override
  Future<List<Section>> getSections() async {
    try {
      final response = await _dio.get('/section-list.json?api-key=$_apiKey');
      final sectionsJsonArr = response.data['results'] as List<dynamic>;
      final sections =
          sectionsJsonArr.map((item) => Section.fromJson(item)).toList();
      return sections;
    } on DioError catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error('Network error');
    }
  }
}
