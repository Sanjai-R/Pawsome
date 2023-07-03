import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/model/pet_model.dart';
import 'package:pawsome_client/services/pet.service.dart';

class PetProvider extends ChangeNotifier {
  bool isSearchPressed = false;
  List<Category> _categories = [];
  bool _isLoading = false;
  bool _hasError = false;
  List<PetModel> _pets = [];
  String _errorMessage = '';

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  List<Category> get categories => _categories;

  List<PetModel> get pets => _pets;

  void toggleSearch() {
    isSearchPressed = !isSearchPressed;
    notifyListeners();
  }

  Future<void> fetchAllPets() async {
    _isLoading = true;
    notifyListeners();

    final res = await PetService.getAllPets();

    if (res != null) {
      res.map((e) => print(e));

      _pets = res.map((e) => PetModel.fromJson(e)).toList().cast<PetModel>();
      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get pets';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    final res = await PetService.getCategories();

    if (res != null) {
      res.map((e) => print(e));
      _categories =
          res.map((e) => Category.fromJson(e)).toList().cast<Category>();

      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get categories';
    }

    _isLoading = false;
    notifyListeners();
  }
}
