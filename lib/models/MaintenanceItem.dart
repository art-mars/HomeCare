// creates a item that required maintenance
// Done
import 'MaintenanceTask.dart';

class MaintenanceItem {
  final String id;
  final String name;
  final String areaId;
  bool isSelected;
  final List<MaintenanceTask> tasks;

  MaintenanceItem({
    required this.id,
    required this.name,
    required this.areaId,
    this.isSelected = false,
    required this.tasks,
  });

  // convert maintenance item to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'areaId': areaId,
    'isSelected': isSelected,
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };

  // create maintenance item from JSON
  factory MaintenanceItem.fromJson(Map<String, dynamic> json) =>
      MaintenanceItem(
        id: json['id'],
        name: json['name'],
        areaId: json['areaId'],
        isSelected: json['isSelected'],
        tasks: (json['tasks'] as List)
            .map((t) => MaintenanceTask.fromJson(t))
            .toList(),
      );
}