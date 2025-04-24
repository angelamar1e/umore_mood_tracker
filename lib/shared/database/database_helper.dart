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

Future<void> deleteEntry(String entryId) async {
  // Get a reference to the database.
  final db = await getDatabase();

  await db.delete('mood_entries', where: 'entry_id = ?', whereArgs: [entryId]);
}

Future<List<MoodEntry>?> fetchHistory() async {
  // Get a reference to the database.
  final db = await getDatabase();
  late List<MoodEntry> history = [];

  final entries = await db.rawQuery("SELECT * FROM mood_entries");

  for (final {
        'entry_id': entryId as int,
        'mood_key': moodKey as String,
        'notes': notes as String,
        'timestamp': timestamp as String,
      }
      in entries) {
    history.add(
      MoodEntry(
        entryId: entryId,
        moodKey: moodKey,
        notes: notes,
        timestamp: timestamp,
      ),
    );
  }

  return history.isNotEmpty ? history : null;
}

Future<Map<String, int>> countByMood() async {
  // Get a reference to the database.
  final db = await getDatabase();
  late Map<String, int> moodEntriesCount = {};

  final entries = await db.rawQuery(
    "SELECT moodKey, COUNT() as count FROM mood_entries GROUP BY moodKey",
  );

  for (final {'moodKey': moodKey as String, 'count': count as int} in entries) {
    moodEntriesCount.addAll({moodKey: count});
  }

  return moodEntriesCount;
}
