import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/data/i_newswire_service.dart';
import 'package:newswire/data/implementations/constants.dart';
import 'x_status.dart';

//------
// State

class NewsState extends Equatable {
  final XStatus status;
  final List<NewsItem> news;
  final String? errorMessage;

  const NewsState({
    this.status = XStatus.initial,
    this.news = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, news, errorMessage];
}

//------
// Cubit

class NewsCubit extends Cubit<NewsState> {
  late final INewswireService _newsService;
  //late final StreamSubscription _newsSubscription;

  NewsCubit({required INewswireService newsService})
      : super(const NewsState()) {
    _newsService = newsService;

    _newsService.eventsStreamController.stream.listen((String event) {
      if (event == kNewsHasBeenChangedEvent) {
        print('Something new has happend...');
        emit(NewsState(status: XStatus.success, news: _newsService.news));
      }
    });
  }

  Future<void> getNews() async {
    emit(const NewsState(status: XStatus.inProgress));
    try {
      await _newsService.getLatestNews();
      emit(NewsState(status: XStatus.success, news: _newsService.news));
    } catch (e) {
      emit(NewsState(status: XStatus.failure, errorMessage: e.toString()));
    }
  }

  void toInitial() {
    emit(const NewsState(status: XStatus.initial));
  }
}
