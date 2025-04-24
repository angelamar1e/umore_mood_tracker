class MoodEntry {
  String moodKey;
  String notes;
  String timestamp;

  MoodEntry({
    required this.moodKey,
    required this.notes,
    required this.timestamp,
  });

  Map<String, Object?> toMap() {
    return {'mood_key': moodKey, 'notes': notes, 'timestamp': timestamp};
  }
}
