import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dday.dart';
import '../providers/dday_provider.dart';
import '../services/dday_service.dart';

class AddEditDDayScreen extends ConsumerStatefulWidget {
  final DDay? dday;

  const AddEditDDayScreen({super.key, this.dday});

  @override
  ConsumerState<AddEditDDayScreen> createState() => _AddEditDDayScreenState();
}

class _AddEditDDayScreenState extends ConsumerState<AddEditDDayScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _targetDate;
  late TimeOfDay _targetTime;
  bool _hasReminder = false;
  DateTime? _reminderTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.dday?.title);
    _descriptionController = TextEditingController(
      text: widget.dday?.description,
    );
    _targetDate = widget.dday?.targetDate ?? DateTime.now();
    _targetTime = TimeOfDay.fromDateTime(
      widget.dday?.targetDate ?? DateTime.now(),
    );
    _hasReminder = widget.dday?.hasReminder ?? false;
    _reminderTime = widget.dday?.reminderTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _targetDate) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _targetTime,
    );
    if (picked != null && picked != _targetTime) {
      setState(() {
        _targetTime = picked;
      });
    }
  }

  Future<void> _selectReminderTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _reminderTime ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: _targetDate,
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        setState(() {
          _reminderTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveDDay() {
    if (_formKey.currentState!.validate()) {
      final targetDateTime = DateTime(
        _targetDate.year,
        _targetDate.month,
        _targetDate.day,
        _targetTime.hour,
        _targetTime.minute,
      );

      final dday = DDay(
        id: widget.dday?.id ?? DDayService().generateId(),
        title: _titleController.text,
        targetDate: targetDateTime,
        description:
            _descriptionController.text.isEmpty
                ? null
                : _descriptionController.text,
        hasReminder: _hasReminder,
        reminderTime: _hasReminder ? _reminderTime : null,
      );

      if (widget.dday == null) {
        ref.read(dDayNotifierProvider.notifier).addDDay(dday);
      } else {
        ref.read(dDayNotifierProvider.notifier).updateDDay(dday);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dday == null ? 'Add D-Day' : 'Edit D-Day'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Target Date'),
              subtitle: Text(
                '${_targetDate.year}-${_targetDate.month.toString().padLeft(2, '0')}-${_targetDate.day.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: const Text('Target Time'),
              subtitle: Text(_targetTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Set Reminder'),
              value: _hasReminder,
              onChanged: (value) {
                setState(() {
                  _hasReminder = value;
                  if (!value) {
                    _reminderTime = null;
                  }
                });
              },
            ),
            if (_hasReminder) ...[
              ListTile(
                title: const Text('Reminder Time'),
                subtitle: Text(
                  _reminderTime != null
                      ? '${_reminderTime!.year}-${_reminderTime!.month.toString().padLeft(2, '0')}-${_reminderTime!.day.toString().padLeft(2, '0')} ${_reminderTime!.hour.toString().padLeft(2, '0')}:${_reminderTime!.minute.toString().padLeft(2, '0')}'
                      : 'Not set',
                ),
                trailing: const Icon(Icons.notifications),
                onTap: () => _selectReminderTime(context),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveDDay,
              child: Text(widget.dday == null ? 'Add D-Day' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
