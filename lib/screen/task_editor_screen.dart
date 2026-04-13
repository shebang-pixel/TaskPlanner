import 'package:flutter/material.dart';
import '../model/task.dart';
import '../widget/time_date_picker.dart';
import '../widget/editable_list_section.dart';

class TaskEditorScreen extends StatefulWidget {
  final String title;
  const TaskEditorScreen({super.key, required this.title});

  @override
  State<TaskEditorScreen> createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  final _formKey = GlobalKey<FormState>();

  // 🔹 Use controller for better control and memory management
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose(); // 🔹 Critical: Prevent memory leaks
    super.dispose();
  }

  // 🔹 Collected Data
  String _priority = 'Medium';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  final List<String> _todos = [];
  final List<String> _challenges = [];
  final List<String> _constraints = [];

  // Check if form is dirty (has changes)
  bool get _isDirty => _nameController.text.isNotEmpty || _todos.isNotEmpty || _challenges.isNotEmpty || _constraints.isNotEmpty;

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        title: _nameController.text,
        priority: _priority,
        date: _date,
        time: _time.format(context),
        todos: List.from(_todos),
        challenges: List.from(_challenges),
        constraints: List.from(_constraints),
        progress: 0.0,
      );

      // TODO: send this to storage

      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: !_isDirty, // 🔹 Prevent accidental discards
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text('You have unsaved changes. Are you sure you want to leave?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Discard', style: TextStyle(color: Colors.red))),
            ],
          ),
        );
        if (shouldPop ?? false) Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Task Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.done, // 🔹 Better keyboard UX
                  decoration: InputDecoration(
                    hintText: 'What needs to be done?',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 32),

                const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['High', 'Medium', 'Low'].map((p) => ChoiceChip(
                    label: Text(p),
                    selected: _priority == p,
                    onSelected: (selected) {
                      if (selected) setState(() => _priority = p);
                    },
                    selectedColor: colorScheme.primary, // 🔹 Standardized Theme color
                    labelStyle: TextStyle(color: _priority == p ? colorScheme.onPrimary : colorScheme.primary),
                  )).toList(),
                ),
                const SizedBox(height: 32),

                TimeDatePicker(
                  selectedDate: _date,
                  selectedTime: _time,
                  onDateChanged: (d) => setState(() => _date = d),
                  onTimeChanged: (t) => setState(() => _time = t),
                ),
                const SizedBox(height: 32),

                EditableListSection(
                  title: 'To-Do Items',
                  items: _todos,
                  showCheckbox: true,
                  onAdd: (val) => setState(() => _todos.add(val)),
                  onDelete: (idx) => setState(() => _todos.removeAt(idx)),
                ),
                const SizedBox(height: 16),
                EditableListSection(
                  title: 'Anticipated Challenges',
                  items: _challenges,
                  showCheckbox: false, // 🔹 Only todos need checkboxes
                  onAdd: (val) => setState(() => _challenges.add(val)),
                  onDelete: (idx) => setState(() => _challenges.removeAt(idx)),
                ),
                const SizedBox(height: 16),
                EditableListSection(
                  title: 'Environment Constraints',
                  items: _constraints,
                  showCheckbox: false,
                  onAdd: (val) => setState(() => _constraints.add(val)),
                  onDelete: (idx) => setState(() => _constraints.removeAt(idx)),
                ),

                const SizedBox(height: 48),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                    ),
                    child: const Text('Save Task Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}