import 'dart:async';
import 'package:newswire/=models=/news_item.dart';

abstract class INewswireService {
  List<NewsItem> get news;
  Future<void> getLatestNews();
  StreamController<String> get eventsStreamController;
}
