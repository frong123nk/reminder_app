import 'package:equatable/equatable.dart';
import '../../models/reminder.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

class LoadReminders extends ReminderEvent {}

class AddReminder extends ReminderEvent {
  final Reminder reminder;

  const AddReminder(this.reminder);

  @override
  List<Object> get props => [reminder];
}

class UpdateReminder extends ReminderEvent {
  final Reminder reminder;

  const UpdateReminder(this.reminder);

  @override
  List<Object> get props => [reminder];
}


class DeleteReminder extends ReminderEvent {
  final int id;

  const DeleteReminder(this.id);

  @override
  List<Object> get props => [id];
}