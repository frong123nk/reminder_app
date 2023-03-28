import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/reminder_bloc/reminder_bloc.dart';
import '../../blocs/reminder_bloc/reminder_event.dart';
import '../../models/reminder.dart';

class ReminderTile extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onTap;

  const ReminderTile({Key? key, required this.reminder, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminder.title),
      subtitle: Text(reminder.description),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete Reminder'),
                content: Text('Are you sure you want to delete this reminder?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ReminderBloc>().add(DeleteReminder(reminder.id));
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
      ),
      onTap: onTap,
    );
  }
}
