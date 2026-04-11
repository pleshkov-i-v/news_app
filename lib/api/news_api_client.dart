import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'news_api_models.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2')
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio, {String baseUrl}) = _NewsApiClient;

  @GET('/top-headlines')
  Future<TopHeadlinesResponse> getTopHeadlines({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('sources') String? sources,
    @Query('q') String? query,
    @Query('pageSize') int? pageSize,
    @Query('page') int? page,
  });
}
