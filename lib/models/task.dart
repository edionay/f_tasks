const String tasksTable = 'tasks';

class TaskFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String date = 'date';
}

class Task {
  final int? id;
  final String title;
  final DateTime date;

  Task({this.id, required this.title, required this.date});

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      TaskFields.id: id,
      TaskFields.title: title,
      TaskFields.date: date.toIso8601String()
    };
    return map;
  }

  static Task fromMap(Map<String, Object?> map) => Task(
        id: map[TaskFields.id] as int,
        title: map[TaskFields.title] as String,
        date: DateTime.parse(map[TaskFields.date] as String),
      );

  Task copy({int? id, String? title, DateTime? date}) => Task(
      id: id ?? this.id, title: title ?? this.title, date: date ?? this.date);
}
