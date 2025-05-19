import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/dday.dart';

class DDayService {
  static const String _boxName = 'dday_box';
  late Box<DDay> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DDayAdapter());
    _box = await Hive.openBox<DDay>(_boxName);
  }

  List<DDay> getAllDDays() {
    return _box.values.toList();
  }

  Future<void> addDDay(DDay dday) async {
    await _box.put(dday.id, dday);
  }

  Future<void> updateDDay(DDay dday) async {
    await _box.put(dday.id, dday);
  }

  Future<void> deleteDDay(String id) async {
    await _box.delete(id);
  }

  Future<void> deleteAllDDays() async {
    await _box.clear();
  }

  String generateId() {
    return const Uuid().v4();
  }
}
