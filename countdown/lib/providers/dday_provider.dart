import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/dday.dart';
import '../services/dday_service.dart';
import '../services/notification_service.dart';

part 'dday_provider.g.dart';

@riverpod
class DDayNotifier extends _$DDayNotifier {
  late final DDayService _ddayService;
  late final NotificationService _notificationService;

  @override
  Future<List<DDay>> build() async {
    _ddayService = DDayService();
    _notificationService = NotificationService();
    await _ddayService.init();
    await _notificationService.init();
    return _ddayService.getAllDDays();
  }

  Future<void> addDDay(DDay dday) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _ddayService.addDDay(dday);
      if (dday.hasReminder) {
        await _notificationService.scheduleDDayReminder(dday);
      }
      return _ddayService.getAllDDays();
    });
  }

  Future<void> updateDDay(DDay dday) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _ddayService.updateDDay(dday);
      if (dday.hasReminder) {
        await _notificationService.scheduleDDayReminder(dday);
      } else {
        await _notificationService.cancelDDayReminder(dday);
      }
      return _ddayService.getAllDDays();
    });
  }

  Future<void> deleteDDay(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dday = _ddayService.getAllDDays().firstWhere((d) => d.id == id);
      await _ddayService.deleteDDay(id);
      if (dday.hasReminder) {
        await _notificationService.cancelDDayReminder(dday);
      }
      return _ddayService.getAllDDays();
    });
  }

  Future<void> deleteAllDDays() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _ddayService.deleteAllDDays();
      await _notificationService.cancelAllReminders();
      return _ddayService.getAllDDays();
    });
  }
}
