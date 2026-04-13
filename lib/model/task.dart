class Task {
  final String title;
  final String priority;
  final String time;
  final DateTime date;
  final List<String> todos;
  final List<String> challenges;
  final List<String> constraints;
  final double progress;

  Task({
    required this.title,
    required this.priority,
    required this.time,
    required this.date,
    this.todos = const [],
    this.challenges = const [],
    this.constraints = const [],
    this.progress = 0.0,
  });
}
