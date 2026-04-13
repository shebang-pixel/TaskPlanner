import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/personal_journal.dart';
import 'journal_details_page.dart';

class PersonalJournalPage extends StatefulWidget {
  const PersonalJournalPage({super.key});

  @override
  State<PersonalJournalPage> createState() => _PersonalJournalPageState();
}

class _PersonalJournalPageState extends State<PersonalJournalPage> {
  final List<PersonalJournal> _allJournals = [
    PersonalJournal(
      title: 'A Productive Day',
      date: DateTime.now().subtract(const Duration(days: 1)).toString(),
      description: 'Today I managed to finish all my tasks ahead of schedule. I felt very energized and focused throughout the day.',
    ),
    PersonalJournal(
      title: 'Reflecting on Growth',
      date: DateTime.now().subtract(const Duration(days: 3)).toString(),
      description: 'I realized that I have been much more consistent with my habits lately. It is a great feeling to see progress.',
    ),
    PersonalJournal(
      title: 'Morning Thoughts',
      date: DateTime.now().toString(),
      description: 'The weather is beautiful today. I want to spend some time outdoors and enjoy the fresh air.',
    ),
  ];

  List<PersonalJournal> _filteredJournals = [];
  bool _isAscending = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredJournals = List.from(_allJournals);
    _sortJournals();
  }

  void _sortJournals() {
    setState(() {
      _filteredJournals.sort((a, b) {
        final dateA = DateTime.parse(a.date);
        final dateB = DateTime.parse(b.date);
        return _isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    });
  }

  void _filterJournals(String query) {
    setState(() {
      _filteredJournals = _allJournals
          .where((j) => j.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _sortJournals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('My Journals', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(_isAscending ? Icons.south : Icons.north),
            onPressed: () {
              _isAscending = !_isAscending;
              _sortJournals();
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
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterJournals,
                decoration: InputDecoration(
                  hintText: 'Search journals...',
                  prefixIcon: const Icon(Icons.search),
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
            child: _filteredJournals.isEmpty
                ? const Center(child: Text('No journals found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredJournals.length,
                    itemBuilder: (context, index) {
                      final journal = _filteredJournals[index];
                      final date = DateTime.parse(journal.date);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Hero(
                          tag: 'journal_${journal.date}',
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JournalDetailsPage(journal: journal),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.book_outlined, color: Colors.blue),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            journal.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            DateFormat('MMM dd, yyyy').format(date),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.chevron_right, color: Colors.grey[400]),
                                  ],
                                ),
                              ),
                            ),
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
          // TODO: Navigate to Add Journal Page
        },
        label: const Text('Add Journal'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
