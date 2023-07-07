import 'package:dio/dio.dart';

class NewsService {
  static const String _apiKey = '680584f42c6748d8838ff4dceeef312d';
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  static Future<dynamic> getNews(int page) async {
    final Map<String, dynamic> queryParameters = {
      'q': 'pet',
      'apiKey': _apiKey,
      'language': 'en',
      'page': page.toString(),
      'pageSize': '10',
    };

    final res = await Dio().get(_baseUrl, queryParameters: queryParameters);

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data;
    }
    return null;
  }
}
