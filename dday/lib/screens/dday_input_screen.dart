import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/dday_event.dart';
import '../providers/dday_provider.dart';

class DDayInputScreen extends ConsumerStatefulWidget {
  final DDayEvent? event;

  const DDayInputScreen({super.key, this.event});

  @override
  ConsumerState<DDayInputScreen> createState() => _DDayInputScreenState();
}

class _DDayInputScreenState extends ConsumerState<DDayInputScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  bool _showInNotification = false;
  bool _countAsDayOne = false;
  late Color _selectedColor;

  final List<Color> _colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event?.title ?? '');
    _selectedDate = widget.event?.targetDate ?? DateTime.now();
    _showInNotification = widget.event?.showInNotification ?? false;
    _countAsDayOne = widget.event?.countAsDayOne ?? false;
    _selectedColor = widget.event?.color ?? Colors.blue;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('디데이 정보 입력'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '결혼 기념일',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '제목을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildDatePicker(),
            const SizedBox(height: 24),
            _buildColorPicker(),
            const SizedBox(height: 24),
            _buildSettingsOptions(),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _saveDDayEvent, child: const Text('저장')),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '날짜',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showDatePicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy년 MM월 dd일').format(_selectedDate),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '색상',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _colorOptions.map((color) {
                final isSelected = color == _selectedColor;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child:
                        isSelected
                            ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                            : null,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildSettingsOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '설정옵션',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('상단바&잠금화면 노출'),
          value: _showInNotification,
          onChanged: (value) {
            setState(() {
              _showInNotification = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('설정일부터 1일로 세기'),
          value: _countAsDayOne,
          onChanged: (value) {
            setState(() {
              _countAsDayOne = value;
            });
          },
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveDDayEvent() {
    if (_formKey.currentState?.validate() ?? false) {
      final event = DDayEvent(
        id: widget.event?.id,
        title: _titleController.text,
        targetDate: _selectedDate,
        showInNotification: _showInNotification,
        countAsDayOne: _countAsDayOne,
        createdAt: widget.event?.createdAt,
        color: _selectedColor,
      );

      if (widget.event == null) {
        ref.read(dDayEventsProvider.notifier).addDDayEvent(event);
      } else {
        ref.read(dDayEventsProvider.notifier).updateDDayEvent(event);
      }

      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
