import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/data/i_newswire_service.dart';
import 'package:newswire/data/implementations/constants.dart';
//import 'x_status.dart';

enum XStatus { initial, inProgress, failure, success, filterSuccess }

//------
// State

class NewsState extends Equatable {
  final XStatus status;
  final List<NewsItem> news;
  final List<NewsItem> filteredNews;
  final String? errorMessage;

  const NewsState({
    this.status = XStatus.initial,
    this.news = const [],
    this.filteredNews = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, news, filteredNews, errorMessage];
}

//------
// Cubit

class NewsCubit extends Cubit<NewsState> {
  late final INewswireService _newsService;

  String _filterString = '';

  NewsCubit({required INewswireService newsService})
      : super(const NewsState()) {
    _newsService = newsService;

    _newsService.eventsStreamController.stream.listen((String event) {
      if (event == kNewsHasBeenChangedEvent) {
        //print('Something new has happend...');
        emit(NewsState(
            status: XStatus.success,
            news: _newsService.news,
            filteredNews: _filterNews()));
      }
    });
  }

  Future<void> getNews() async {
    emit(const NewsState(status: XStatus.inProgress));
    try {
      await _newsService.getLatestNews();
      emit(NewsState(
          status: XStatus.success,
          news: _newsService.news,
          filteredNews: _filterNews()));
    } catch (e) {
      emit(NewsState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  List<NewsItem> _filterNews() {
    if (_filterString.isEmpty) {
      return _newsService.news;
    } else {
      List<NewsItem> filteredNews = [];
      for (var newsItem in _newsService.news) {
        if ((newsItem.title
                .toLowerCase()
                .contains(_filterString.toLowerCase())) ||
            (newsItem.section
                .toLowerCase()
                .contains(_filterString.toLowerCase())) ||
            (newsItem.subsection
                .toLowerCase()
                .contains(_filterString.toLowerCase()))) {
          filteredNews.add(newsItem);
        }
      }
      return filteredNews;
    }
  }

  void getFilteredNews({required String filterString}) {
    _filterString = filterString;
    emit(NewsState(
      status: XStatus.filterSuccess,
      news: _newsService.news,
      filteredNews: _filterNews(),
    ));
  }

  void toInitial() {
    emit(const NewsState(status: XStatus.initial));
  }
}
