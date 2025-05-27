import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/dday_event.dart';
import '../services/database_helper.dart';

part 'dday_provider.g.dart';

@riverpod
class DDayEvents extends _$DDayEvents {
  final _dbHelper = DatabaseHelper();

  @override
  Future<List<DDayEvent>> build() async {
    return _dbHelper.getAllDDayEvents();
  }

  Future<void> addDDayEvent(DDayEvent event) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _dbHelper.insertDDayEvent(event);
      return _dbHelper.getAllDDayEvents();
    });
  }

  Future<void> updateDDayEvent(DDayEvent event) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _dbHelper.updateDDayEvent(event);
      return _dbHelper.getAllDDayEvents();
    });
  }

  Future<void> deleteDDayEvent(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _dbHelper.deleteDDayEvent(id);
      return _dbHelper.getAllDDayEvents();
    });
  }
}

@riverpod
class DDayCalculation extends _$DDayCalculation {
  @override
  String build(DDayEvent event) {
    final now = DateTime.now();
    final targetDate = event.targetDate;
    final difference = targetDate.difference(now).inDays;

    if (difference == 0) return 'D-Day';
    if (difference > 0) return 'D-$difference';
    return 'D+${difference.abs()}';
  }
}
