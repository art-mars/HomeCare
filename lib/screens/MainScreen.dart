import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CalendarScreen.dart';
import 'DashboardScreen.dart';
import 'SettingsScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // lhe list of widgets to display based on the selected tab
  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'To-Do List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), // calendar icon
            label: 'Calendar', // calendar label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // settings icon
            label: 'Settings', // settings label
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
