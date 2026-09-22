import 'package:flutter/foundation.dart';

/// Calendar screen state.
class CalendarNotifier extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;

  void onDaySelected(DateTime selected, DateTime focused) {
    _selectedDay = selected;
    _focusedDay = focused;
    notifyListeners();
  }

  void onPageChanged(DateTime focused) {
    _focusedDay = focused;
    notifyListeners();
  }
}
