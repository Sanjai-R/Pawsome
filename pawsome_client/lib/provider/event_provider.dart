import 'package:flutter/cupertino.dart';
import 'package:pawsome_client/services/event.service.dart';

class EventProvider extends ChangeNotifier {
  Future<dynamic> getAllEvents() async {
    final res = await EventService.getEvents();
    notifyListeners();
    if (res != null) {
      return {'status': true, 'data': res};
    } else {
      return {'status': false, 'message': 'Failed to get Events'};
    }
  }
}
