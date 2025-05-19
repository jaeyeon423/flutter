import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dday.dart';
import '../providers/dday_provider.dart';
import '../widgets/dday_card.dart';
import '../widgets/dday_timeline.dart';
import 'add_edit_dday_screen.dart';

class DDayListScreen extends ConsumerWidget {
  const DDayListScreen({super.key});

  void _showDDayDetails(BuildContext context, DDay dday) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(dday.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (dday.description != null) ...[
                  Text(dday.description!),
                  const SizedBox(height: 16),
                ],
                Text(
                  'Target Date: ${_formatDate(dday.targetDate)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  dday.isPast
                      ? 'D+${_calculateDaysPast(dday)}'
                      : 'D-${_calculateDaysRemaining(dday)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dday.isPast ? Colors.red : Colors.blue,
                  ),
                ),
                if (dday.hasReminder && dday.reminderTime != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reminder: ${_formatDateTime(dday.reminderTime!)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  int _calculateDaysRemaining(DDay dday) {
    return dday.targetDate.difference(DateTime.now()).inDays.abs();
  }

  int _calculateDaysPast(DDay dday) {
    return DateTime.now().difference(dday.targetDate).inDays;
  }

  List<DDay> _sortDDaysByProximity(List<DDay> ddays) {
    final now = DateTime.now();
    return List<DDay>.from(ddays)..sort((a, b) {
      final aDiff = a.targetDate.difference(now).abs();
      final bDiff = b.targetDate.difference(now).abs();
      return aDiff.compareTo(bDiff);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ddaysAsync = ref.watch(dDayNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('D-Day Countdown'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Delete All D-Days'),
                      content: const Text(
                        'Are you sure you want to delete all D-Day events?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(dDayNotifierProvider.notifier)
                                .deleteAllDDays();
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: ddaysAsync.when(
        data: (ddays) {
          if (ddays.isEmpty) {
            return const Center(
              child: Text(
                'No D-Day events yet.\nTap the + button to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final sortedDDays = _sortDDaysByProximity(ddays);

          return Column(
            children: [
              DDayTimeline(
                ddays: ddays,
                onDDayTap: (dday) => _showDDayDetails(context, dday),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sortedDDays.length,
                  itemBuilder: (context, index) {
                    final dday = sortedDDays[index];
                    return DDayCard(
                      dday: dday,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditDDayScreen(dday: dday),
                          ),
                        );
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Delete D-Day'),
                                content: Text(
                                  'Are you sure you want to delete "${dday.title}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(dDayNotifierProvider.notifier)
                                          .deleteDDay(dday.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditDDayScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
