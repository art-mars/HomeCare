
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/MaintenanceItem.dart';
import '../models/MaintenanceTask.dart';
import '../models/TaskCard.dart';
import '../models/TaskDisplayData.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<TaskDisplayData> _selectedTasks = [];
  List<TaskDisplayData> _allTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadAllTasks().then((_) {
      _selectedTasks = _getTasksForDay(_selectedDay!);
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _loadAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsJson = prefs.getString('selectedMaintenanceItems');

    List<TaskDisplayData> loadedTasks = [];
    if (itemsJson != null) {
      final List<dynamic> decodedItems = json.decode(itemsJson);
      for (var itemMap in decodedItems) {
        MaintenanceItem item = MaintenanceItem.fromJson(itemMap);
        if (item.isSelected) {
          for (var task in item.tasks) {
            loadedTasks.add(TaskDisplayData(task: task, itemName: item.name));
          }
        }
      }
    }
    setState(() {
      _allTasks = loadedTasks;
    });
  }

  List<TaskDisplayData> _getTasksForDay(DateTime day) {
    return _allTasks.where((taskDisplayData) {
      final taskDueDate = taskDisplayData.task.dueDate;
      return taskDueDate.year == day.year &&
          taskDueDate.month == day.month &&
          taskDueDate.day == day.day;
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedTasks = _getTasksForDay(selectedDay);
    });
  }

  // Mark a task as completed and update its due date
  void _markTaskCompleted(TaskDisplayData taskDisplayData) {
    setState(() {
      taskDisplayData.task.dueDate = taskDisplayData.task.calculateNextDueDate();
      taskDisplayData.task.isCompleted = true; // Temporary visual state
    });
    _saveTasks().then((_) {
      _loadAllTasks().then((_) { // Reload all tasks to ensure calendar updates
        _selectedTasks = _getTasksForDay(_selectedDay!); // Update tasks for current selected day
        _showSnackbar('Task "${taskDisplayData.itemName}: ${taskDisplayData.task.name}" completed! Next due: ${DateFormat.yMMMd().format(taskDisplayData.task.dueDate)}');
      });
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
        _loadAllTasks().then((_) {
          _selectedTasks = _getTasksForDay(_selectedDay!);
          _showSnackbar('Task "${taskDisplayData.itemName}: ${taskDisplayData.task.name}" due date updated to ${DateFormat.yMMMd().format(taskDisplayData.task.dueDate)}');
        });
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<MaintenanceItem> itemsToSave = [];

    final String? existingItemsJson = prefs.getString('selectedMaintenanceItems');
    List<MaintenanceItem> existingSelectedItems = [];
    if (existingItemsJson != null) {
      existingSelectedItems = (json.decode(existingItemsJson) as List)
          .map((e) => MaintenanceItem.fromJson(e))
          .toList();
    }

    Map<String, MaintenanceTask> updatedTasksMap = {};
    _allTasks.forEach((td) {
      updatedTasksMap[td.task.id] = td.task;
    });

    for (var existingItem in existingSelectedItems) {
      List<MaintenanceTask> updatedTasksForThisItem = [];
      for (var taskInItem in existingItem.tasks) {
        if (updatedTasksMap.containsKey(taskInItem.id)) {
          updatedTasksForThisItem.add(updatedTasksMap[taskInItem.id]!);
        } else {
          updatedTasksForThisItem.add(taskInItem);
        }
      }
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
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text('Maintenance Calendar', style: TextStyle(fontSize: 30)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getTasksForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue[300],
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _selectedTasks.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    'No tasks for \n${DateFormat.yMMMd().format(_selectedDay!)}!',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _selectedTasks.length,
              itemBuilder: (context, index) {
                final taskDisplayData = _selectedTasks[index];
                return TaskCard(
                  taskDisplayData: taskDisplayData,
                  onMarkCompleted: _markTaskCompleted,
                  onEditDate: _editTaskDate,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
