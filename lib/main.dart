import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/reminder_bloc/reminder_bloc.dart';
import '/repositories/reminder_repository.dart';
import 'blocs/reminder_bloc/reminder_event.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(ReminderApp());
}

class ReminderApp extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<ReminderApp> {
  final AppRouter _appRouter = AppRouter();
  final ReminderRepository _reminderRepository = LocalReminderRepository();
  late ReminderBloc _reminderBloc;

  @override
  void initState() {
    super.initState();
    _reminderBloc = ReminderBloc(reminderRepository: _reminderRepository);
    _reminderBloc.add(LoadReminders());
  }

  @override
  void dispose() {
    _reminderBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reminderBloc,
      child: MaterialApp(
        title: 'Reminder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
