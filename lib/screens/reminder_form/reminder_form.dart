import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/reminder_bloc/reminder_bloc.dart';
import '../../blocs/reminder_bloc/reminder_event.dart';
import '../../models/reminder.dart';

class ReminderForm extends StatefulWidget {
  final Reminder? reminder;

  ReminderForm({Key? key, this.reminder}) : super(key: key);

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title ?? '');
    _descriptionController = TextEditingController(text: widget.reminder?.description ?? '');
    _dueDate = widget.reminder?.dueDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: Text(widget.reminder == null ? 'Add Reminder' : 'Edit Reminder'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              minLines: 3,
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Due Date'),
              subtitle: Text('${_dueDate.toLocal()}'),
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null && pickedDate != _dueDate) {
                  setState(() {
                    _dueDate = pickedDate;
                  });
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final Reminder reminder = Reminder(
              id: widget.reminder?.id ?? DateTime.now().millisecondsSinceEpoch,
              title: _titleController.text,
              description: _descriptionController.text,
              dueDate: _dueDate,
            );

            if (widget.reminder == null) {
              context.read<ReminderBloc>().add(AddReminder(reminder));
            } else {
              context.read<ReminderBloc>().add(UpdateReminder(reminder));
            }
            context.read<ReminderBloc>().add(LoadReminders());
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

