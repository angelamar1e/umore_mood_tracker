import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';

Future<Database> getDatabase() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE mood_entries(entry_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, mood_key TEXT, notes TEXT, timestamp TEXT)',
      );
    },
    version: 1,
  );

  return database;
}

Future<void> insertEntry(MoodEntry entry) async {
  // Get a reference to the database.
  final db = await getDatabase();

  await db.insert(
    'mood_entries',
    entry.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
