import 'package:flutter/material.dart';
import 'task_screen.dart';
import 'journal/journal_screen.dart';
import 'stats_screen.dart';

class MainScreen  extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0; //initial page

  // on icon tap
  void onTabTapped(int index) {
    setState(() {
      _counter = index;
    });
  }

  // Screens
  final List<Widget> _pages = [
    TaskScreen(),
    JournalScreen(),
    StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_counter],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _counter,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.note_add ), label: 'Journaling'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        unselectedItemColor: Colors.orange[400],
        showUnselectedLabels: true,
      ),
    );
  }
}