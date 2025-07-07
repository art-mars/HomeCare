import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/allHomeAreas.dart';
import '../database/allMaintenanceItems.dart';
import '../models/MaintenanceItem.dart';
import '../models/MaintenanceTask.dart';
import 'MainScreen.dart';

class InitialSetupItemSelectionScreen extends StatefulWidget {
  final List<String> selectedAreaIds;
  const InitialSetupItemSelectionScreen({super.key, required this.selectedAreaIds});

  @override
  State<InitialSetupItemSelectionScreen> createState() => _InitialSetupItemSelectionScreenState();
}

class _InitialSetupItemSelectionScreenState extends State<InitialSetupItemSelectionScreen> {
  int currentAreaIndex = 0;
  List<MaintenanceItem> currentItemsForArea = [];
  Map<String, List<MaintenanceItem>> selectedItemsByArea = {};

  @override
  void initState() {
    super.initState();
    _loadPreviousSelectionsAndCurrentAreaItems();
  }

  Future<void> _loadPreviousSelectionsAndCurrentAreaItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? existingItemsJson = prefs.getString('selectedMaintenanceItems');

    if (existingItemsJson != null) {
      final List<dynamic> decoded = json.decode(existingItemsJson);
      for (var itemMap in decoded) {
        MaintenanceItem item = MaintenanceItem.fromJson(itemMap);
        if (!selectedItemsByArea.containsKey(item.areaId)) {
          selectedItemsByArea[item.areaId] = [];
        }
        selectedItemsByArea[item.areaId]!.add(item);
      }
    }

    _loadCurrentAreaItems();
  }

  void _loadCurrentAreaItems() {
    if (widget.selectedAreaIds.isNotEmpty && currentAreaIndex < widget.selectedAreaIds.length) {
      final String areaId = widget.selectedAreaIds[currentAreaIndex];
      List<MaintenanceItem> items = allMaintenanceItems
          .where((item) => item.areaId == areaId)
          .map((item) {
        MaintenanceItem newItem = MaintenanceItem(
          id: item.id,
          name: item.name,
          areaId: item.areaId,
          isSelected: false,
          tasks: item.tasks.map((t) => MaintenanceTask(id: t.id, name: t.name, frequency: t.frequency, dueDate: t.dueDate)).toList(),
        );
        if (selectedItemsByArea.containsKey(areaId)) {
          if (selectedItemsByArea[areaId]!.any((selectedItem) => selectedItem.id == newItem.id && selectedItem.isSelected)) {
            newItem.isSelected = true;
          }
        }

        if (newItem.areaId == 'general') {
          newItem.isSelected = true;
        }
        return newItem;
      })
          .toList();

      setState(() {
        currentItemsForArea = items;
      });
    }
  }

  Future<void> _saveAllSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<MaintenanceItem> allSelectedItemsFlat = [];
    selectedItemsByArea.values.forEach((list) {
      allSelectedItemsFlat.addAll(list);
    });
    final String encoded = json.encode(allSelectedItemsFlat.map((e) => e.toJson()).toList());
    await prefs.setString('selectedMaintenanceItems', encoded);
    await prefs.remove('tempSelectedAreasForSetup');
  }

  void _nextPage() async {
    final String currentAreaId = widget.selectedAreaIds[currentAreaIndex];
    selectedItemsByArea[currentAreaId] = currentItemsForArea.where((item) => item.isSelected).toList();

    if (currentAreaIndex < widget.selectedAreaIds.length - 1) {
      setState(() {
        currentAreaIndex++;
      });
      _loadCurrentAreaItems();
    } else {
      await _saveAllSelectedItems();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // navigate to MainScreen after setup
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentAreaName = allHomeAreas.firstWhere((area) => area.id == widget.selectedAreaIds[currentAreaIndex]).name;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text('Select Items for $currentAreaName', style: TextStyle(fontSize: 30)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentItemsForArea.length,
              itemBuilder: (context, index) {
                final item = currentItemsForArea[index];
                return CheckboxListTile(
                  title: Text(item.name, style: TextStyle(fontSize: 20)),
                  value: item.isSelected,
                  onChanged: (item.areaId == 'general')
                      ? null
                      : (bool? value) {
                    setState(() {
                      item.isSelected = value!;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              child: Text(currentAreaIndex < widget.selectedAreaIds.length - 1 ?
                'Next Area' : 'Finish Setup',style: TextStyle(fontSize: 20)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
