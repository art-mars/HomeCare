// Creates a task object
// Done
class MaintenanceTask {
  final String id;
  final String name;
  final String frequency; // 'weekly', 'monthly', 'quarterly', 'annually'
  DateTime dueDate;
  bool isCompleted;

  MaintenanceTask({
    required this.id,
    required this.name,
    required this.frequency,
    required this.dueDate,
    this.isCompleted = false,
  });

  // convert maintenance task to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'frequency': frequency,
    'dueDate': dueDate.toIso8601String(),
  };

  //create maintenance task from JSON
  factory MaintenanceTask.fromJson(Map<String, dynamic> json) =>
      MaintenanceTask(
        id: json['id'],
        name: json['name'],
        frequency: json['frequency'],
        dueDate: DateTime.parse(json['dueDate']),
      );

  // calculateS next due date based on frequency
  DateTime calculateNextDueDate() {
    DateTime now = DateTime.now();
    DateTime nextDate = dueDate;

    // Ff the due date is in the past, increment until it's in the future
    while (nextDate.isBefore(now)) {
      switch (frequency) {
        case 'daily':
          nextDate = nextDate.add(const Duration(days: 1));
          break;
        case 'weekly':
          nextDate = nextDate.add(const Duration(days: 7));
          break;
        case 'bi-weekly':
          nextDate = nextDate.add(const Duration(days: 14));
          break;
        case 'monthly':
          nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
          break;
        case 'quarterly':
          nextDate = DateTime(nextDate.year, nextDate.month + 3, nextDate.day);
          break;
        case 'bi-annually':
          nextDate = DateTime(nextDate.year, nextDate.month + 6, nextDate.day);
          break;
        case 'annually':
          nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
          break;
        case 'every_3_5_years': // Custom frequency for hoses
          nextDate = DateTime(nextDate.year + 3, nextDate.month, nextDate.day); // Default to 3 years
          break;
        case 'every_5_7_years': // Custom frequency for detectors
          nextDate = DateTime(nextDate.year + 5, nextDate.month, nextDate.day); // Default to 5 years
          break;
        case 'every_10_12_years': // Custom frequency for fire extinguisher
          nextDate = DateTime(nextDate.year + 10, nextDate.month, nextDate.day); // Default to 10 years
          break;
        case 'every_2_3_years': // Custom frequency for driveway/fence
          nextDate = DateTime(nextDate.year + 2, nextDate.month, nextDate.day); // Default to 2 years
          break;
        case 'every_2_5_years': // Custom frequency for sewer line
          nextDate = DateTime(nextDate.year + 2, nextDate.month, nextDate.day); // Default to 2 years
          break;
        case 'every_5_10_years': // Custom frequency for insulation
          nextDate = DateTime(nextDate.year + 5, nextDate.month, nextDate.day); // Default to 5 years
          break;
        default:
        // For unknown frequencies, just set to a week from now as a fallback
          nextDate = now.add(const Duration(days: 7));
          break;
      }
    }
    return nextDate;
  }
}