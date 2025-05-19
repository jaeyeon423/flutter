import 'package:flutter/material.dart';
import '../models/dday.dart';

class DDayTimeline extends StatelessWidget {
  final List<DDay> ddays;
  final Function(DDay) onDDayTap;

  const DDayTimeline({super.key, required this.ddays, required this.onDDayTap});

  Color _getDDayColor(DDay dday) {
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
    if (ddays.isEmpty) return const SizedBox.shrink();

    // Sort D-Days by date
    final sortedDDays = List<DDay>.from(ddays)
      ..sort((a, b) => a.targetDate.compareTo(b.targetDate));

    // Find the date range
    final earliestDate = sortedDDays.first.targetDate;
    final latestDate = sortedDDays.last.targetDate;
    final totalDays = latestDate.difference(earliestDate).inDays;

    // If all events are on the same day, show them in the middle
    if (totalDays == 0) {
      return Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Stack(
          children: [
            Center(child: Container(height: 2, color: Colors.grey[300])),
            ...sortedDDays.map((dday) {
              final isPast = dday.isPast;
              final ddayColor = _getDDayColor(dday);
              return Positioned(
                left: MediaQuery.of(context).size.width / 2 - 6,
                child: GestureDetector(
                  onTap: () => onDDayTap(dday),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color:
                              isPast ? ddayColor.withOpacity(0.5) : ddayColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          '${dday.targetDate.month}/${dday.targetDate.day}',
                          style: TextStyle(
                            fontSize: 10,
                            color:
                                isPast ? ddayColor.withOpacity(0.7) : ddayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 1,
              top: 20, // Move Today marker down
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 2, height: 20, color: Colors.green),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Calculate relative positions
    final now = DateTime.now();
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 40.0; // Padding from edges
    final availableWidth = screenWidth - (padding * 2);

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          // Timeline line
          Center(child: Container(height: 2, color: Colors.grey[300])),
          // D-Day markers
          ...sortedDDays.map((dday) {
            final isPast = dday.isPast;
            final ddayColor = _getDDayColor(dday);
            final daysFromStart =
                dday.targetDate.difference(earliestDate).inDays;
            final position = daysFromStart / totalDays;
            final left = padding + (position * availableWidth);

            return Positioned(
              left: left,
              child: GestureDetector(
                onTap: () => onDDayTap(dday),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isPast ? ddayColor.withOpacity(0.5) : ddayColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        '${dday.targetDate.month}/${dday.targetDate.day}',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              isPast ? ddayColor.withOpacity(0.7) : ddayColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          // Current date marker
          Builder(
            builder: (context) {
              if (now.isBefore(earliestDate)) {
                return Positioned(
                  left: padding,
                  top: 20, // Move Today marker down
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 2, height: 20, color: Colors.green),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (now.isAfter(latestDate)) {
                return Positioned(
                  right: padding,
                  top: 20, // Move Today marker down
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 2, height: 20, color: Colors.green),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              final daysFromStart = now.difference(earliestDate).inDays;
              final position = daysFromStart / totalDays;
              final left = padding + (position * availableWidth);

              return Positioned(
                left: left,
                top: 20, // Move Today marker down
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 2, height: 20, color: Colors.green),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
