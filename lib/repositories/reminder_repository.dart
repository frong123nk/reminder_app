import '../models/reminder.dart';

abstract class ReminderRepository {
  Future<List<Reminder>> getReminders();
  Future<Reminder> addReminder(Reminder reminder);
  Future<void> updateReminder(Reminder reminder);
  Future<void> deleteReminder(int id);
}

class LocalReminderRepository implements ReminderRepository {
  List<Reminder> _reminders = [];

  @override
  Future<List<Reminder>> getReminders() async {
    return _reminders;
  }

  @override
  Future<Reminder> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    return reminder;
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    int index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
    }
  }

  @override
  Future<void> deleteReminder(int id) async {
    _reminders.removeWhere((r) => r.id == id);
  }
}
