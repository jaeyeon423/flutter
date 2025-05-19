import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

enum DDayType { oneTime }

class DDayEvent {
  final String id;
  final String title;
  final DateTime targetDate;
  final DDayType type;
  final bool showInNotification;
  final bool countAsDayOne;
  final DateTime createdAt;
  final Color color;

  DDayEvent({
    String? id,
    required this.title,
    required this.targetDate,
    this.type = DDayType.oneTime,
    this.showInNotification = false,
    this.countAsDayOne = false,
    DateTime? createdAt,
    Color? color,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       color = color ?? Colors.blue;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'targetDate': targetDate.toIso8601String(),
      'type': type.toString(),
      'showInNotification': showInNotification ? 1 : 0,
      'countAsDayOne': countAsDayOne ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'color': color.value,
    };
  }

  factory DDayEvent.fromMap(Map<String, dynamic> map) {
    return DDayEvent(
      id: map['id'],
      title: map['title'],
      targetDate: DateTime.parse(map['targetDate']),
      type: DDayType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => DDayType.oneTime,
      ),
      showInNotification: map['showInNotification'] == 1,
      countAsDayOne: map['countAsDayOne'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
      color: Color(map['color'] ?? Colors.blue.value),
    );
  }

  DDayEvent copyWith({
    String? title,
    DateTime? targetDate,
    DDayType? type,
    bool? showInNotification,
    bool? countAsDayOne,
    Color? color,
  }) {
    return DDayEvent(
      id: id,
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
      type: type ?? this.type,
      showInNotification: showInNotification ?? this.showInNotification,
      countAsDayOne: countAsDayOne ?? this.countAsDayOne,
      createdAt: createdAt,
      color: color ?? this.color,
    );
  }
}
