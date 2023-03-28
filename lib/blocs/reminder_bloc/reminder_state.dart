import 'package:equatable/equatable.dart';
import '../../models/reminder.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class ReminderInitial extends ReminderState {}

class ReminderLoadInProgress extends ReminderState {}

class ReminderLoadSuccess extends ReminderState {
  final List<Reminder> reminders;

  const ReminderLoadSuccess(this.reminders);

  @override
  List<Object> get props => [reminders];
}

class ReminderLoadFailure extends ReminderState {}
