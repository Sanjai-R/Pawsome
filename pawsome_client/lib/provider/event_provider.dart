import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/model/event_model.dart';
import 'package:pawsome_client/services/event.service.dart';

class EventProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  List<Event> _events = [];
  Map<String, dynamic> data = {
    "petId": "",
    "eventDateTime": "",
    "eventTitle": "",
    "eventDesc": "",
    "hasReminder": false
  };

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  String get errorMessage => _errorMessage;
  DateTime selectedDate = DateTime.now();

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  List<Event> get events => _events;

  Future<dynamic> postEvent(data) async {
    final res = await EventService.postEvents(data);
    if (res != null) {
      return {'status': true, 'message': 'Event Posted Successfully'};
    } else {
      return {'status': false, 'message': 'Event Posting Failed'};
    }
  }

  Future<void> fetchAllEvents(petId) async {
    _isLoading = true;
    notifyListeners();

    final res = await EventService.getEventData(petId);

    if (res != null) {
      res.map((e) => print(e));

      _events = res.map((e) => Event.fromJson(e)).toList().cast<Event>();
      _hasError = false;
      _errorMessage = '';
    } else {
      _hasError = true;
      _errorMessage = 'Failed to get events';
    }

    _isLoading = false;
    notifyListeners();
  }
  void clear() {
    _isLoading = false;
    _hasError = false;
    _errorMessage = '';
    _events = [];
    data = {
      "petId": "",
      "eventDateTime": "",
      "eventTitle": "",
      "eventDesc": "",
      "hasReminder": false
    };
    selectedDate = DateTime.now();
    notifyListeners();
  }
}
