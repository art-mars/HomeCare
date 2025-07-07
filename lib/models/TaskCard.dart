// Displays a tasks and its attributes with edit buttons on the screen
// Done
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TaskDisplayData.dart';

class TaskCard extends StatelessWidget {
  final TaskDisplayData taskDisplayData;
  final Function(TaskDisplayData) onMarkCompleted;
  final Function(TaskDisplayData) onEditDate;

  const TaskCard({
    super.key,
    required this.taskDisplayData,
    required this.onMarkCompleted,
    required this.onEditDate,
  });

  @override
  Widget build(BuildContext context) {
    final task = taskDisplayData.task;
    final itemName = taskDisplayData.itemName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$itemName: ${task.name}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 3), // Reduced height
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due: ${DateFormat.yMMMd().format(task.dueDate)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: task.dueDate.isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))
                          ? Colors.red.shade800
                          : Colors.black54,
                      fontWeight: task.dueDate.isBefore(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  Text(
                    task.frequency.replaceAll('_', ' '),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_calendar, color: Colors.blueGrey, size: 25),
                    onPressed: () => onEditDate(taskDisplayData),
                    tooltip: 'Edit Due Date',
                  ),
                  ElevatedButton(
                    onPressed: () => onMarkCompleted(taskDisplayData),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Done', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
