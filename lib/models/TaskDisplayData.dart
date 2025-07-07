// Combines MaintenanceTask with its parent item's name for display
// Done
import 'MaintenanceTask.dart';

class TaskDisplayData {
  final MaintenanceTask task;
  final String itemName;

  TaskDisplayData({required this.task, required this.itemName});
}