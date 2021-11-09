import 'package:f_tasks/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'f_tasks.db';
  static const _dbVersion = 1;

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(_databaseName);
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);
    return await openDatabase(path,
        version: _dbVersion, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tasksTable (
${TaskFields.id} $idType,
${TaskFields.title} $textType,
${TaskFields.date} $textType
)
''');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;
    final id = await db.insert(tasksTable, task.toMap());
    return task.copy(id: id);
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    final orderBy = '${TaskFields.date} ASC';
    final result = await db.query(tasksTable, orderBy: orderBy);
    return result.map((element) => Task.fromMap(element)).toList();
  }

  Future close() async {
    final currentDatabase = await instance.database;
    currentDatabase.close();
  }
}
