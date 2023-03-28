import 'package:flutter/material.dart';
import '../../../models/reminder.dart';

class ReminderItem extends StatelessWidget {
  final Reminder reminder;

  const ReminderItem({Key? key, required this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminder.title),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Delete the reminder
          // You can add this functionality later
        },
      ),
    );
  }
}
