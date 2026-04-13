import 'package:flutter/material.dart';

class Constraints extends StatefulWidget {
  const Constraints({super.key});

  @override
  State<Constraints> createState() => _ConstraintsState();
}

class _ConstraintsState extends State<Constraints> {
  // TODO: create a list builder to display constraints from firebase/local storage

  // Dummy constraint
  List<Map<String, dynamic>> constraints = [
    {'constraint': 'Constraint 1'},
    {'constraint': 'Constraint 2'},
    {'constraint': 'Constraint 3'},
    {'constraint': 'Constraint 4'},
    {'constraint': 'Constraint 5'},
  ];
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Constraints'),
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: constraints.length,
          itemBuilder: (context, index) {
            final item = constraints[index];
            return ListTile(title: Text(item['constraint']));
          },
        ),
        IconButton(
          onPressed: () {
            debugPrint('Add constraint');
          },
          icon: Icon(Icons.add_box_rounded),
        )
      ],
    );
  }
}
