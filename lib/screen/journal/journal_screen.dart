import 'package:flutter/material.dart';
import 'personal_journal_page.dart';
import 'gratitude_journal_page.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Journaling'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Personal Notes'),
              Tab(text: 'Gratitude journal'),
            ],
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: TabBarView(
          children: [
            PersonalJournalPage(),
            GratitudeJournalPage(),
          ],
        ),
      ),
    );
  }
}
