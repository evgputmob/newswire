import 'package:dio/dio.dart';

final kDioOptions = BaseOptions(
  baseUrl: 'https://api.nytimes.com/svc/news/v3/content',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

const kReReadNewsIntervalInSeconds = 300;

const kNewsHasBeenChangedEvent = 'NEWS_HAS_BEEN_CHANGED_EVENT';
