import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../models/reminder.dart';
import '../../repositories/reminder_repository.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository reminderRepository;

  ReminderBloc({required this.reminderRepository}) : super(ReminderInitial()) {
    print('ReminderBloc initialized');
    on<LoadReminders>(_onLoadReminders);
    on<AddReminder>(_onAddReminder);
    on<UpdateReminder>(_onUpdateReminder);
    on<DeleteReminder>(_onDeleteReminder);
  }

  Future<void> _onLoadReminders(LoadReminders event, Emitter<ReminderState> emit) async {
    emit(ReminderLoadInProgress());
    try {
      final reminders = await reminderRepository.getReminders();
      print('Loaded reminders: $reminders');
      emit(ReminderLoadSuccess(reminders));
    } catch (_) {
      emit(ReminderLoadFailure());
    }
  }

  Future<void> _onAddReminder(AddReminder event, Emitter<ReminderState> emit) async {
    if (state is ReminderLoadSuccess) {
      final updatedReminders = List<Reminder>.from((state as ReminderLoadSuccess).reminders)
        ..add(await reminderRepository.addReminder(event.reminder));
        print('Added reminder: ${event.reminder}, Updated reminders: $updatedReminders'); 
      emit(ReminderLoadSuccess(updatedReminders));
    }
  }

  Future<void> _onUpdateReminder(UpdateReminder event, Emitter<ReminderState> emit) async {
    if (state is ReminderLoadSuccess) {
      final updatedReminders = (state as ReminderLoadSuccess).reminders.map((reminder) {
        return reminder.id == event.reminder.id ? event.reminder : reminder;
      }).toList();
      await reminderRepository.updateReminder(event.reminder);
      emit(ReminderLoadSuccess(updatedReminders));
    }
  }

  Future<void> _onDeleteReminder(DeleteReminder event, Emitter<ReminderState> emit) async {
    if (state is ReminderLoadSuccess) {
      final updatedReminders = (state as ReminderLoadSuccess)
          .reminders
          .where((reminder) => reminder.id != event.id)
          .toList();
      await reminderRepository.deleteReminder(event.id);
      emit(ReminderLoadSuccess(updatedReminders));
    }
  }
}
