import 'package:flutter/material.dart';
import 'package:pawsome_client/services/food.service.dart';

class FoodProvider extends ChangeNotifier{
  List<dynamic> _foods = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  List<dynamic> get foods => _foods;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> getFoods(petId) async {
    _isLoading = true;
    final res = await FoodService.getRecommendFoods(petId);
    if (res != null) {
      _foods = res.toList().cast<dynamic>();
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get foods';
    }
    _hasError = false;
    _isLoading = false;
    notifyListeners();
  }
}