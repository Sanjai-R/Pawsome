import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/services/news.service.dart';

class NewsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  List<Map<String, dynamic>> _news = [];
  int _currentPage = 1;
  int _totalPages = 1;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get news => _news;
  bool get isLastPage => _currentPage >= _totalPages;

  Future<void> getNews() async {
    _isLoading = true;
    _currentPage = 1;
    _totalPages = 1;

    final res = await NewsService.getNews(_currentPage);

    if (res != null) {
      _news = res['articles'].toList().cast<Map<String, dynamic>>();
      _totalPages = (res['totalResults'] / 10).ceil();
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get news';
    }

    _hasError = false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getMoreNews() async {
    if (_isLoading || isLastPage) return;

    _isLoading = true;
    _currentPage++;

    final res = await NewsService.getNews(_currentPage);

    if (res != null) {
      final List<Map<String, dynamic>> additionalNews =
      res['articles'].toList().cast<Map<String, dynamic>>();
      _news.addAll(additionalNews);
    }

    _isLoading = false;
    notifyListeners();
  }
}
