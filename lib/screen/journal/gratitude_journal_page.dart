import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/gratitude_journal.dart';

class GratitudeJournalPage extends StatefulWidget {
  const GratitudeJournalPage({super.key});

  @override
  State<GratitudeJournalPage> createState() => _GratitudeJournalPageState();
}

class _GratitudeJournalPageState extends State<GratitudeJournalPage> {
  final List<GratitudeJournal> _allEntries = [
    GratitudeJournal(
      date: DateTime.now().toString(),
      entries: [
        'I am grateful for the sunny weather today.',
        'I am thankful for my supportive family.',
        'I appreciate the delicious breakfast I had.',
      ],
    ),
    GratitudeJournal(
      date: DateTime.now().subtract(const Duration(days: 1)).toString(),
      entries: [
        'Finished a challenging project at work.',
        'Had a great conversation with an old friend.',
        'Enjoyed a peaceful evening walk.',
      ],
    ),
    GratitudeJournal(
      date: DateTime.now().subtract(const Duration(days: 2)).toString(),
      entries: [
        'The kindness of a stranger.',
        'Finding a new book to read.',
        'Learning a new skill.',
      ],
    ),
  ];

  List<GratitudeJournal> _filteredEntries = [];
  bool _isAscending = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredEntries = List.from(_allEntries);
    _sortEntries();
  }

  void _sortEntries() {
    setState(() {
      _filteredEntries.sort((a, b) {
        final dateA = DateTime.parse(a.date);
        final dateB = DateTime.parse(b.date);
        return _isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    });
  }

  void _filterEntries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredEntries = List.from(_allEntries);
      } else {
        _filteredEntries = _allEntries.where((entry) {
          final dateStr = DateFormat('MMM dd, yyyy').format(DateTime.parse(entry.date)).toLowerCase();
          final contentMatch = entry.entries.any((e) => e.toLowerCase().contains(query.toLowerCase()));
          return dateStr.contains(query.toLowerCase()) || contentMatch;
        }).toList();
      }
      _sortEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // Warm yellow background
      appBar: AppBar(
        title: const Text('Gratitude Journal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(_isAscending ? Icons.south : Icons.north),
            onPressed: () {
              _isAscending = !_isAscending;
              _sortEntries();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterEntries,
                decoration: InputDecoration(
                  hintText: 'Search gratitude...',
                  prefixIcon: const Icon(Icons.search, color: Colors.brown),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredEntries.isEmpty
                ? const Center(child: Text('No gratitude entries found.', style: TextStyle(color: Colors.brown)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = _filteredEntries[index];
                      final date = DateTime.parse(entry.date);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                                  const SizedBox(width: 10),
                                  Text(
                                    DateFormat('EEEE, MMM dd').format(date),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 25, thickness: 1),
                              ...entry.entries.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('✨ ', style: TextStyle(fontSize: 16)),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.4,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Add Gratitude Entry
        },
        label: const Text('I am grateful for...', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
