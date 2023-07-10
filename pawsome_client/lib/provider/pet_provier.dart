import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/model/adopt_model.dart';
import 'package:pawsome_client/model/bookmark_model.dart';
import 'package:pawsome_client/model/pet_model.dart';
import 'package:pawsome_client/services/pet.service.dart';

class PetProvider extends ChangeNotifier {
  bool isSearchPressed = false;
  List<Category> _categories = [];
  bool _isLoading = false;
  bool _hasError = false;
  List<PetModel> _pets = [];
  List<AdoptModel> _adopts = [];
  List<dynamic> _bookmarks = [];
  Map<String, dynamic> _selectedPet = {};

  String _errorMessage = '';

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  List<Category> get categories => _categories;

  List<PetModel> get pets => _pets;

  List<AdoptModel> get adopts => _adopts;

  List<dynamic> get bookmarks => _bookmarks;

  Map<String, dynamic> get selectedPet => _selectedPet;

  void toggleSearch() {
    isSearchPressed = !isSearchPressed;
    notifyListeners();
  }

  void setSelectedPet(data) {
    notifyListeners();
    _selectedPet = data;
  }

  Future<void> fetchAllPets(userId) async {
    _isLoading = true;

    final res = await PetService.getAllPets();

    final filteredResults =
        res.where((c) => c['user']['userId'] != userId).toList();

    if (res != null) {
      _pets = filteredResults
          .map((e) => PetModel.fromJson(e))
          .toList()
          .cast<PetModel>();
      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get pets';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<dynamic> postPet(data) async {
    final res = await PetService.postPet(data);
    if (res ) {
      return {'status': true, 'message': 'Pet Posted Successfully'};
    } else {
      return {'status': false, 'message': 'Pet Posting Failed'};
    }
  }

  Future<void> fetchAllPetsByUser(userId) async {
    _isLoading = true;

    final res = await PetService.getAllPets();

    final filteredResults =
        res.where((c) => c['user']['userId'] == userId).toList();

    if (res != null) {
      _pets = filteredResults
          .map((e) => PetModel.fromJson(e))
          .toList()
          .cast<PetModel>();
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

    final res = await PetService.getCategories();

    if (res != null) {
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

  Future<Map<String, dynamic>?> fetchPetById(id) async {
    _isLoading = true;

    final res = await PetService.getPetById(id);

    notifyListeners();
    if (res != null) {
      _hasError = false;
      _errorMessage = '';
      _isLoading = false;
      return res;
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get Pet';
    }

    _isLoading = false;
    return null;
  }

  Future<dynamic> adoptPet(data) async {
    final res = await PetService.postAdopt(data);

    if (res != null) {
      return {'status': true, 'message': 'Adoption Posted Successfully'};
    } else {
      return {'status': false, 'message': 'Adoption Posting Failed'};
    }
  }

  Future<void> fetchAdoptData() async {
    _isLoading = true;

    final res = await PetService.getAdoptedData();

    if (res != null) {
      _adopts =
          res.map((e) => AdoptModel.fromJson(e)).toList().cast<AdoptModel>();

      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get categories';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<dynamic> updateStatus(data) async {
    final res = await PetService.updateAdoptStatus(data['id'], data);

    if (res) {
      return {
        'status': true,
        'message': 'Adoption Status Updated Successfully'
      };
    } else {
      return {'status': false, 'message': 'Adoption Status Updation Failed'};
    }
  }

  Future<void> getBookmarks(userId) async {
    final res = await PetService.getBookMarks(userId);
    if (res != null) {
      _bookmarks = res
          .map((e) => BookmarkModel.fromJson(e))
          .toList();

      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get categories';
    }
  }

  Future<dynamic> postBookmarks(data) async {
    final res = await PetService.postBookMark(data);
    if (res != null) {
      return {'status': true, 'message': 'Bookmarked Successfully'};
    } else {
      return {'status': false, 'message': 'Bookmarking Failed'};
    }
  }
  Future<dynamic> deleteBookmarks(bookMarkId) async {
    final res = await PetService.deleteBookMark(bookMarkId);
    if (res != null) {
      return {'status': true, 'message': 'Bookmarked Deleted Successfully'};
    } else {
      return {'status': false, 'message': 'Bookmarking Deletion Failed'};
    }
  }

  void clear() {
    isSearchPressed = false;
    _categories = [];
    _isLoading = false;
    _hasError = false;
    _pets = [];
    _adopts = [];
    _selectedPet = {};
    _errorMessage = '';
  }




}
