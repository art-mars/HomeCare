import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/MaintenanceItem.dart';
import '../models/MaintenanceTask.dart';
import '../models/TaskCard.dart';
import '../models/TaskDisplayData.dart';
import 'InitialSetUpAreaSelectionScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, List<TaskDisplayData>> _categorizedTasks = {
    'Overdue': [],
    'Today': [],
    'This Week': [],
    'This Month': [],
    'This Year': [],
    'Later': [],
  };
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
      _categorizedTasks = { // Reset categories
        'Overdue': [],
        'Today': [],
        'This Week': [],
        'This Month': [],
        'This Year': [],
        'Later': [],
      };
    });

    final prefs = await SharedPreferences.getInstance();
    final String? itemsJson = prefs.getString('selectedMaintenanceItems');

    List<TaskDisplayData> loadedTasks = [];
    if (itemsJson != null) {
      final List<dynamic> decodedItems = json.decode(itemsJson);
      for (var itemMap in decodedItems) {
        MaintenanceItem item = MaintenanceItem.fromJson(itemMap);
        // Only add tasks if the item itself is selected
        if (item.isSelected) {
          for (var task in item.tasks) {
            loadedTasks.add(TaskDisplayData(task: task, itemName: item.name));
          }
        }
      }
    }

    loadedTasks.sort((a, b) => a.task.dueDate.compareTo(b.task.dueDate));

    final DateTime now = DateTime.now();
    final DateTime todayStart = DateTime(now.year, now.month, now.day);
    final DateTime tomorrowStart = todayStart.add(const Duration(days: 1));
    final DateTime endOfNext7Days = todayStart.add(const Duration(days: 7));
    final DateTime endOfNext30Days = todayStart.add(const Duration(days: 30));
    final DateTime endOfCurrentYear = DateTime(now.year, 12, 31, 23, 59, 59);

    for (var taskDisplayData in loadedTasks) {
      final task = taskDisplayData.task;
      final dueDate = task.dueDate;

      if (dueDate.isBefore(todayStart)) {
        _categorizedTasks['Overdue']!.add(taskDisplayData);
      } else if (dueDate.isBefore(tomorrowStart)) {
        _categorizedTasks['Today']!.add(taskDisplayData);
      } else if (dueDate.isBefore(endOfNext7Days.add(const Duration(days: 1)))) {
        _categorizedTasks['This Week']!.add(taskDisplayData);
      } else if (dueDate.isBefore(endOfNext30Days.add(const Duration(days: 1)))) {
        _categorizedTasks['This Month']!.add(taskDisplayData);
      } else if (dueDate.isBefore(endOfCurrentYear.add(const Duration(microseconds: 1)))) {
        _categorizedTasks['This Year']!.add(taskDisplayData);
      } else {
        _categorizedTasks['Later']!.add(taskDisplayData);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  // save all tasks back to SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<MaintenanceItem> itemsToSave = [];

    // get the current state of selected items from SharedPreferences first
    final String? existingItemsJson = prefs.getString('selectedMaintenanceItems');
    List<MaintenanceItem> existingSelectedItems = [];
    if (existingItemsJson != null) {
      existingSelectedItems = (json.decode(existingItemsJson) as List)
          .map((e) => MaintenanceItem.fromJson(e))
          .toList();
    }

    // create a map for quick lookup of tasks by their ID
    Map<String, MaintenanceTask> updatedTasksMap = {};
    _categorizedTasks.values.expand((list) => list).forEach((td) {
      updatedTasksMap[td.task.id] = td.task;
    });

    // iterate through existing selected items and update their tasks
    for (var existingItem in existingSelectedItems) {
      List<MaintenanceTask> updatedTasksForThisItem = [];
      for (var taskInItem in existingItem.tasks) {
        // if the task exists in our updated map, use that version
        if (updatedTasksMap.containsKey(taskInItem.id)) {
          updatedTasksForThisItem.add(updatedTasksMap[taskInItem.id]!);
        } else {
          // otherwise, keep the original task (it wasn't completed/edited on dashboard)
          updatedTasksForThisItem.add(taskInItem);
        }
      }
      // add the updated item to the list to save
      itemsToSave.add(MaintenanceItem(
        id: existingItem.id,
        name: existingItem.name,
        areaId: existingItem.areaId,
        isSelected: existingItem.isSelected,
        tasks: updatedTasksForThisItem,
      ));
    }

    final String encoded = json.encode(itemsToSave.map((e) => e.toJson()).toList());
    await prefs.setString('selectedMaintenanceItems', encoded);
  }


  // mark a task as completed and update its due date
  void _markTaskCompleted(TaskDisplayData taskDisplayData) {
    setState(() {
      taskDisplayData.task.dueDate = taskDisplayData.task.calculateNextDueDate();
      taskDisplayData.task.isCompleted = true;
    });
    _saveTasks().then((_) {
      _loadTasks();
      _showSnackbar('Task "${taskDisplayData.itemName}: ${taskDisplayData.task.name}" '
          'completed! Next due: ${DateFormat.yMMMd().format(taskDisplayData.task.dueDate)}');
      _triggerPushNotification(taskDisplayData.itemName, taskDisplayData.task.name, taskDisplayData.task.dueDate);
    });
  }

  // allow user to edit the due date of a task
  Future<void> _editTaskDate(TaskDisplayData taskDisplayData) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskDisplayData.task.dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null && picked != taskDisplayData.task.dueDate) {
      setState(() {
        taskDisplayData.task.dueDate = picked;
      });
      _saveTasks().then((_) {
        _loadTasks();
        _showSnackbar('Task "${taskDisplayData.itemName}: ${taskDisplayData.task.name}" '
            'due date updated to ${DateFormat.yMMMd().format(taskDisplayData.task.dueDate)}');
      });
    }
  }

  // simulate push notification trigger
  void _triggerPushNotification(String itemName, String taskName, DateTime dueDate) {
    print('Simulating push notification for "$itemName: $taskName" due on ${DateFormat.yMMMd().format(dueDate)}');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('To-Do List', style: TextStyle(fontSize: 30)),
            Text(
              DateFormat.yMMMd().format(DateTime.now()),
              style: const TextStyle(fontSize: 30, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categorizedTasks.values.every((list) => list.isEmpty)
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'No active maintenance tasks!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Start by selecting areas and items in your home from the settings icon below.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => InitialSetupAreaSelectionScreen()),
                  );
                },
                child: const Text('Start Setup / Update Setup'),
              ),
            ],
          ),
        ),
      )
          : ListView(
        children: [
          // conditional display for "Nothing due today"
          if (_categorizedTasks['Today']!.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  Icon(Icons.done_all, size: 75, color: Colors.green),
                  SizedBox(height: 10),
                  Text(
                    'Nothing due today!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ..._categorizedTasks.keys.map((category) {
            final tasks = _categorizedTasks[category]!;
            if (tasks.isEmpty) {
              return const SizedBox.shrink();
            }
            return Card(
              margin: Theme.of(context).cardTheme.margin,
              shape: Theme.of(context).cardTheme.shape,
              elevation: Theme.of(context).cardTheme.elevation,
              child: ExpansionTile(
                title: Text(
                  '$category (${tasks.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: category == 'Overdue' ? Colors.red.shade800 : null,
                  ),
                ),
                initiallyExpanded: category == 'Overdue' || category == 'Today',
                children: tasks.map((taskDisplayData) {
                  return TaskCard(
                    taskDisplayData: taskDisplayData,
                    onMarkCompleted: _markTaskCompleted,
                    onEditDate: _editTaskDate,
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
