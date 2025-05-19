import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/dday.dart';

class DDayCard extends StatelessWidget {
  final DDay dday;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DDayCard({
    super.key,
    required this.dday,
    required this.onEdit,
    required this.onDelete,
  });

  Color _getDDayColor() {
    // Generate a consistent color based on the D-Day title
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];

    final index = dday.title.hashCode.abs() % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = dday.remainingTime;
    final isPast = dday.isPast;
    final ddayColor = _getDDayColor();

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: ddayColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      dday.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: ddayColor),
                    ),
                  ),
                  if (dday.hasReminder)
                    Icon(Icons.notifications_active, color: ddayColor),
                ],
              ),
              if (dday.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  dday.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: _calculateProgress(dday),
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isPast ? ddayColor.withOpacity(0.5) : ddayColor,
                              ),
                              strokeWidth: 8,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isPast
                                      ? ddayColor.withOpacity(0.1)
                                      : ddayColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isPast
                                  ? 'D+${_calculateDaysPast(dday)}'
                                  : 'D-${_calculateDaysRemaining(dday)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    isPast
                                        ? ddayColor.withOpacity(0.7)
                                        : ddayColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Date: ${_formatDate(dday.targetDate)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isPast
                                    ? ddayColor.withOpacity(0.1)
                                    : ddayColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isPast
                                ? '${timeago.format(dday.targetDate)} ago'
                                : 'in ${timeago.format(DateTime.now().add(remainingTime))}',
                            style: TextStyle(
                              color:
                                  isPast
                                      ? ddayColor.withOpacity(0.7)
                                      : ddayColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  int _calculateDaysRemaining(DDay dday) {
    return dday.targetDate.difference(DateTime.now()).inDays.abs();
  }

  int _calculateDaysPast(DDay dday) {
    return DateTime.now().difference(dday.targetDate).inDays;
  }

  double _calculateProgress(DDay dday) {
    final now = DateTime.now();
    final startDate = dday.targetDate.subtract(const Duration(days: 365));
    final totalDuration = dday.targetDate.difference(startDate);
    final elapsedDuration = now.difference(startDate);

    if (now.isAfter(dday.targetDate)) return 1.0;
    if (now.isBefore(startDate)) return 0.0;

    return elapsedDuration.inMilliseconds / totalDuration.inMilliseconds;
  }
}
