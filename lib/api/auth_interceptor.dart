import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String _apiKey = const String.fromEnvironment('NEWS_API_KEY');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = _apiKey;
    super.onRequest(options, handler);
  }
}
