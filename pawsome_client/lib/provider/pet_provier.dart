import 'package:flutter/cupertino.dart';

class PetProvider extends ChangeNotifier {
  bool isSearchPressed = false;
  List<Map<String, dynamic>> categories = [
    {
      'name': 'Dog',
      'image':
          'https://img.freepik.com/free-photo/isolated-happy-smiling-dog-white-background-portrait-4_1562-693.jpg?w=900&t=st=1688374933~exp=1688375533~hmac=8f39a2630faf793747c2ce1f9351de641f5adde108337bfffc5b2456760c7d16',
    },
    {
      'name': 'Cat',
      'image':
          'https://img.freepik.com/free-photo/cute-domestic-kitten-sits-window-staring-outside-generative-ai_188544-12519.jpg?w=996&t=st=1688374962~exp=1688375562~hmac=2bb34109aea584ea3b743ec713e7e357b18a5d08d81779ee447ae2d3fb20c75e',
    },
    {
      'name': 'Bird',
      'image':
          'https://img.freepik.com/premium-photo/flamingo-swamp_743855-22826.jpg?w=1060',
    },
    {
      'name': 'Fish',
      'image':
          'https://img.freepik.com/premium-photo/deliciously-3d-cake-slice-with-cream-topping_787273-67.jpg?w=740',
    }
  ];
  List<Map<String, dynamic>> pets = [
    {
      "petId": 4,
      "name": "Brwao",
      "gender": "Female",
      "breed": "Labrador",
      "description":
          "any animal kept by human beings as a source of companionship and pleasure.",
      "price": 310.00,
      "birthDate": "2023-05-28T09:59:56.641",
      "image":
          "https://images.unsplash.com/photo-1553736026-ff14d158d222?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
      "ownerId": 9,
      "categoryId": 1,
      "category": {
        "categoryId": 1,
        "categoryName": "Dogs",
        "categoryDescription": "a list of dogs"
      },
      "user": null
    },
    {
      "petId": 4,
      "name": "Brwao",
      "gender": "Female",
      "breed": "Labrador",
      "description":
          "any animal kept by human beings as a source of companionship and pleasure.",
      "price": 310.00,
      "birthDate": "2023-05-28T09:59:56.641",
      "image":
          "https://images.unsplash.com/photo-1553736026-ff14d158d222?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
      "ownerId": 9,
      "categoryId": 1,
      "category": {
        "categoryId": 1,
        "categoryName": "Dogs",
        "categoryDescription": "a list of dogs"
      },
      "user": null
    }
  ];

  void toggleSearch() {
    isSearchPressed = !isSearchPressed;
    notifyListeners();
  }
}
