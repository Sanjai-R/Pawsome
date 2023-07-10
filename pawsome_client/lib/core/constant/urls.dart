
class AppUrl {
  final String key = '680584f42c6748d8838ff4dceeef312d';
  static String baseUrl = 'https://pawsome-api.azurewebsites.net/api';
  static String newsUrl = 'https://newsapi.org/v2/everything?q=pet&apiKey=${AppUrl().key}';
}