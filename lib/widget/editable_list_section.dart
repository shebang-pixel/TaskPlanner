import 'package:flutter/material.dart';

class EditableListSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String) onAdd;
  final Function(int) onDelete;
  final bool isTodo; // To switch between Checkbox or Bullet points

  const EditableListSection({
    super.key,
    required this.title,
    required this.items,
    required this.onAdd,
    required this.onDelete,
    this.isTodo = false, required bool showCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        // 🔹 Handle Empty State
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No items added yet.', style: TextStyle(color: Colors.grey)),
          ),

        // 🔹 Use Spread Operator instead of ListView.builder inside Column
        // This is more efficient for small/medium lists inside a scrollable view
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          String val = entry.value;

          return ListTile(
            leading: isTodo
                ? const Icon(Icons.check_box_outline_blank_rounded, size: 20)
                : const Icon(Icons.circle, size: 6),
            title: Text(val),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
              onPressed: () => onDelete(index),
            ),
          );
        }),

        // 🔹 Action Button
        TextButton.icon(
          onPressed: () => _showAddDialog(context),
          icon: const Icon(Icons.add),
          label: Text('Add $title'),
        ),
      ],
    );
  }

  // 🔹 Modularizing the Dialog logic
  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New $title'),
        content: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (_) {
            if (controller.text.isNotEmpty) onAdd(controller.text);
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) onAdd(controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}