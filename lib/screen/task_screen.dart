import 'package:flutter/material.dart';
import 'package:task_planner/screen/task_editor_screen.dart';
import '../model/task.dart';
import '../widget/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // 🔹 Use the updated Task model with required 'date'
  List<Task> tasks = [
    Task(
      title: 'Morning Yoga',
      priority: 'High',
      time: '07:00 AM',
      date: DateTime.now(),
      progress: 0.0,
    ),
    Task(
      title: 'Project Alpha Review',
      priority: 'Medium',
      time: '11:30 AM',
      date: DateTime.now(),
      progress: 0.4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              // 🔹 Capture the result from the Editor
              final newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskEditorScreen(title: 'New Task')),
              );

              // 🔹 Update the list if a task was returned
              if (newTask != null && newTask is Task) {
                setState(() => tasks.add(newTask));
              }
            },
            icon: const Icon(Icons.add_circle, color: Colors.blue, size: 30),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Today's Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            // 🔹 Pass the full list to TaskCard for efficient horizontal scrolling
            TaskCard(tasks: tasks),
            
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Upcoming Priorities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            // You can add more sections here (e.g., a vertical list of tasks)
          ],
        ),
      ),
    );
  }
}
