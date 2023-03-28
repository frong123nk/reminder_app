import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/reminder_bloc/reminder_bloc.dart';
import '../../blocs/reminder_bloc/reminder_event.dart';
import '../../blocs/reminder_bloc/reminder_state.dart';
import '../../models/reminder.dart';
import '../../widgets/common/reminder_tile.dart';
import '../../navigation/route_constants.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  bool _loaded = false;

  void _loadReminders() {
    if (!_loaded) {
      BlocProvider.of<ReminderBloc>(context).add(LoadReminders());
      _loaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  @override
  void didUpdateWidget(ReminderList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadReminders();
  }
  @override
  Widget build(BuildContext context) {
    _loadReminders();
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: BlocBuilder<ReminderBloc, ReminderState>(
  builder: (context, state) {
    print('Current state: $state'); // Add this line to log the state changes

    if (state is ReminderLoadInProgress) {
      return Center(child: CircularProgressIndicator());
    } else if (state is ReminderLoadSuccess) {
      return ListView.builder(
        itemCount: state.reminders.length,
        itemBuilder: (context, index) {
          final Reminder reminder = state.reminders[index];
          return ReminderTile(
            key: ValueKey(reminder.id),
            reminder: reminder,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteConstants.reminderForm,
                arguments: reminder,
              );
            },
          );
        },
      );
    } else {
      return Center(child: Text('Failed to load reminders'));
    }
  },
),

      
      floatingActionButton: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FloatingActionButton(
      heroTag: 'addReminder', // Add a unique hero tag
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.reminderForm);
      },
      child: Icon(Icons.add),
    ),
    SizedBox(height: 16), // Add space between buttons
    FloatingActionButton(
      heroTag: 'refreshReminders', // Add a unique hero tag
      onPressed: () {
        BlocProvider.of<ReminderBloc>(context).add(LoadReminders());
      },
      child: Icon(Icons.refresh),
    ),
  ],
),

    );
  }
}
