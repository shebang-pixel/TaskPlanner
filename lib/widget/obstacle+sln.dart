import 'package:flutter/material.dart';

class Challenge extends StatefulWidget{
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  // TODO: create a list builder to display challenges from firebase/local storage

  // dummy challenge + sln
  List<Map<String, dynamic>> challenges = [
    {
      'challenge' : 'Challenge 1',
      'solution' : 'Solution 1'
    },
    {
      'challenge' : 'Challenge 2',
      'solution' : 'Solution 2'
    },
    {
      'challenge' : 'Challenge 3',
      'solution' : 'Solution 3'
    },
    {
      'challenge' : 'Challenge 4',
      'solution' : 'Solution 4'
    },
    {
      'challenge' : 'Challenge 5',
      'solution' : 'Solution 5'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text('Challenges'),
      children: [
        ListView.builder(
          shrinkWrap: true,

          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final item = challenges[index];

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ExpansionTile(
                title: Text(
                 item['challenge'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Text(item['solution'])
                ],
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            debugPrint('Add todo');
          },
          icon: Icon(Icons.add_box_rounded),
        ),
      ],
    );
  }
}