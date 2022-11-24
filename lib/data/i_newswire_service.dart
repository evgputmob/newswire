import 'dart:async';
import 'package:newswire/=models=/news_item.dart';
import 'package:newswire/=models=/section.dart';

abstract class INewswireService {
  List<NewsItem> get news;
  Future<void> getLatestNews();
  Future<List<Section>> getSections();
  StreamController<String> get eventsStreamController;
}
