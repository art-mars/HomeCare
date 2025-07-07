// initial setup screen for selecting areas of a house
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/allHomeAreas.dart';
import '../models/HomeArea.dart';
import 'InitialSetUpItemSelectionScreen.dart';

class InitialSetupAreaSelectionScreen extends StatefulWidget {
  const InitialSetupAreaSelectionScreen({super.key});

  @override
  State<InitialSetupAreaSelectionScreen> createState() => _InitialSetupAreaSelectionScreenState();
}

class _InitialSetupAreaSelectionScreenState extends State<InitialSetupAreaSelectionScreen> {
  List<HomeArea> currentAreas = [];

  @override
  void initState() {
    super.initState();
    currentAreas = allHomeAreas.map((area) => HomeArea(id: area.id, name:
      area.name, isSelected: false)).toList();
    _loadSelectedAreas();
  }

  Future<void> _loadSelectedAreas() async {
    final prefs = await SharedPreferences.getInstance();
    final String? areasJson = prefs.getString('selectedAreas');
    if (areasJson != null) {
      final List<dynamic> decoded = json.decode(areasJson);
      setState(() {
        for (var loadedArea in decoded.map((e) => HomeArea.fromJson(e))) {
          final index = currentAreas.indexWhere((area) => area.id == loadedArea.id);
          if (index != -1) {
            currentAreas[index].isSelected = loadedArea.isSelected;
          }
        }
      });
    }

    final generalAreaIndex = currentAreas.indexWhere((area) => area.id == 'general');
    if (generalAreaIndex != -1) {
      setState(() {
        currentAreas[generalAreaIndex].isSelected = true;
      });
    }
  }

  Future<void> _saveSelectedAreasTemporarily() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(currentAreas.map((e) => e.toJson()).toList());
    await prefs.setString('tempSelectedAreasForSetup', encoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text('Select Home Areas', style: TextStyle(fontSize: 30)),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentAreas.length,
              itemBuilder: (context, index) {
                final area = currentAreas[index];
                return CheckboxListTile(
                  title: Text(area.name, style: TextStyle(fontSize: 20)),
                  value: area.isSelected,
                  onChanged: (area.id == 'general')
                      ? null
                      : (bool? value) {
                    setState(() {
                      area.isSelected = value!;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                await _saveSelectedAreasTemporarily();
                final selectedAreaIds = currentAreas.where((a) => a.isSelected).map((a) => a.id).toList();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitialSetupItemSelectionScreen(
                      selectedAreaIds: selectedAreaIds,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Next', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
