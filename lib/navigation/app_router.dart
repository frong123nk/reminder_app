import 'package:flutter/material.dart';
import '../screens/reminder_list/reminder_list.dart';
import '../screens/reminder_form/reminder_form.dart';
import 'route_constants.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.reminderList:
        return MaterialPageRoute(builder: (_) => ReminderList());
      case RouteConstants.reminderForm:
        return MaterialPageRoute(builder: (_) => ReminderForm());
      default:
        return null;
    }
  }
}
