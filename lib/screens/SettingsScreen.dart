
// --- Settings Screen ---
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_care_manager/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/allHomeAreas.dart';
import '../database/allMaintenanceItems.dart';
import '../models/HomeArea.dart';
import '../models/MaintenanceItem.dart';
import '../models/MaintenanceTask.dart';
import 'MainScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<HomeArea> _allAreasWithSelection = [];
  Map<String, List<MaintenanceItem>> _allSelectedItemsByArea = {};
  String? _selectedAreaDropdownId;

  @override
  void initState() {
    super.initState();
    _loadCurrentSelections();
  }

  Future<void> _loadCurrentSelections() async {
    final prefs = await SharedPreferences.getInstance();

    final String? areasJson = prefs.getString('selectedAreas');
    List<HomeArea> loadedAreas = [];
    if (areasJson != null) {
      loadedAreas = (json.decode(areasJson) as List)
          .map((e) => HomeArea.fromJson(e))
          .toList();
    }

    _allAreasWithSelection = allHomeAreas.map((area) {
      HomeArea newArea = HomeArea(id: area.id, name: area.name, isSelected: false);
      if (loadedAreas.any((loadedArea) => loadedArea.id == newArea.id && loadedArea.isSelected)) {
        newArea.isSelected = true;
      }
      if (newArea.id == 'general') {
        newArea.isSelected = true;
      }
      return newArea;
    }).toList();

    final String? itemsJson = prefs.getString('selectedMaintenanceItems');
    List<MaintenanceItem> loadedItems = [];
    if (itemsJson != null) {
      loadedItems = (json.decode(itemsJson) as List)
          .map((e) => MaintenanceItem.fromJson(e))
          .toList();
    }

    _allSelectedItemsByArea = {};
    for (var item in allMaintenanceItems) {
      MaintenanceItem currentItem = MaintenanceItem(
        id: item.id,
        name: item.name,
        areaId: item.areaId,
        isSelected: false,
        tasks: item.tasks.map((t) => MaintenanceTask(id: t.id, name: t.name, frequency: t.frequency, dueDate: t.dueDate)).toList(),
      );

      if (loadedItems.any((loadedItem) => loadedItem.id == currentItem.id && loadedItem.isSelected)) {
        currentItem.isSelected = true;
        MaintenanceItem? matchedLoadedItem = loadedItems.firstWhereOrNull((li) => li.id == currentItem.id);
        if (matchedLoadedItem != null) {
          currentItem = matchedLoadedItem;
        }
      }

      if (currentItem.areaId == 'general') {
        currentItem.isSelected = true;
      }

      if (!_allSelectedItemsByArea.containsKey(currentItem.areaId)) {
        _allSelectedItemsByArea[currentItem.areaId] = [];
      }
      _allSelectedItemsByArea[currentItem.areaId]!.add(currentItem);
    }

    setState(() {
      _selectedAreaDropdownId = _allAreasWithSelection.firstWhereOrNull((area) => area.isSelected)?.id ?? _allAreasWithSelection.first.id;
    });
  }

  Future<void> _saveAllSelections() async {
    final prefs = await SharedPreferences.getInstance();

    final String encodedAreas = json.encode(_allAreasWithSelection.map((e) => e.toJson()).toList());
    await prefs.setString('selectedAreas', encodedAreas);

    List<MaintenanceItem> itemsToSave = [];
    for (var areaId in _allSelectedItemsByArea.keys) {
      itemsToSave.addAll(_allSelectedItemsByArea[areaId]!.where((item) => item.isSelected));
    }
    final String encodedItems = json.encode(itemsToSave.map((e) => e.toJson()).toList());
    await prefs.setString('selectedMaintenanceItems', encodedItems);
  }

  void _onAreaCheckboxChanged(HomeArea area, bool? value) {
    setState(() {
      area.isSelected = value!;
      if (!area.isSelected) {
        _allSelectedItemsByArea[area.id]?.forEach((item) {
          item.isSelected = false;
        });
      }
      if (!area.isSelected && _selectedAreaDropdownId == area.id) {
        _selectedAreaDropdownId = _allAreasWithSelection.firstWhereOrNull((a) => a.isSelected)?.id ?? _allAreasWithSelection.first.id;
      }
    });
  }

  void _onItemCheckboxChanged(MaintenanceItem item, bool? value) {
    setState(() {
      item.isSelected = value!;
      if (item.isSelected) {
        _allAreasWithSelection.firstWhere((area) => area.id == item.areaId).isSelected = true;
      } else {
        final bool anyOtherItemInAreaSelected = _allSelectedItemsByArea[item.areaId]?.any((i) => i.isSelected) ?? false;
        if (!anyOtherItemInAreaSelected) {
          _allAreasWithSelection.firstWhere((area) => area.id == item.areaId).isSelected = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<MaintenanceItem> itemsForSelectedArea = _allSelectedItemsByArea[_selectedAreaDropdownId] ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text('Settings', style: TextStyle(fontSize: 30)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Home Area to Manage Items:',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  ),
                  value: _selectedAreaDropdownId,
                  hint: const Text('Select a Home Area'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAreaDropdownId = newValue;
                    });
                  },
                  items: _allAreasWithSelection.map((area) {
                    return DropdownMenuItem<String>(
                      value: area.id,
                      child: Text(area.name, style: TextStyle(fontSize: 20)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                if (_selectedAreaDropdownId != null)
                  Text(
                    'Items in ${_allAreasWithSelection.firstWhere((area) => area.id == _selectedAreaDropdownId).name}:',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: _selectedAreaDropdownId == null
                ? const Center(child: Text('Please select a home area to view items.'))
                : ListView.builder(
              itemCount: itemsForSelectedArea.length,
              itemBuilder: (context, index) {
                final item = itemsForSelectedArea[index];
                return CheckboxListTile( // Removed Card
                  title: Text(item.name, style: TextStyle(fontSize: 20)),
                  value: item.isSelected,
                  onChanged: (item.areaId == 'general')
                      ? null
                      : (bool? value) {
                    _onItemCheckboxChanged(item, value);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                await _saveAllSelections();
                Navigator.pushReplacement( // Navigate back to DashboardScreen
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Changes', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
