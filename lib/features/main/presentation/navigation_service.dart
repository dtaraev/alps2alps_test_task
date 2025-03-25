import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<DateTime?> showDate({
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    final context = navigatorKey.currentContext!;
    return showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  Future<TimeOfDay?> showTime({
    required TimeOfDay initialTime,
  }) {
    final context = navigatorKey.currentContext!;
    return showTimePicker(
      context: context,
      initialTime: initialTime,
    );
  }

  Future<bool?> showAlert({
    required WidgetBuilder builder,
  }) {
    final context = navigatorKey.currentContext!;
    return showDialog(
      context: context,
      builder: builder,
    );
  }
}
