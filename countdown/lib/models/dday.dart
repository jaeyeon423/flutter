import 'package:hive/hive.dart';

part 'dday.g.dart';

@HiveType(typeId: 0)
class DDay extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime targetDate;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final bool hasReminder;

  @HiveField(5)
  final DateTime? reminderTime;

  DDay({
    required this.id,
    required this.title,
    required this.targetDate,
    this.description,
    this.hasReminder = false,
    this.reminderTime,
  });

  Duration get remainingTime => targetDate.difference(DateTime.now());

  bool get isPast => targetDate.isBefore(DateTime.now());

  DDay copyWith({
    String? id,
    String? title,
    DateTime? targetDate,
    String? description,
    bool? hasReminder,
    DateTime? reminderTime,
  }) {
    return DDay(
      id: id ?? this.id,
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
      description: description ?? this.description,
      hasReminder: hasReminder ?? this.hasReminder,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}
