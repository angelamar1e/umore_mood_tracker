// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoodEntry {
  int? entryId;
  String moodKey;
  String notes;
  String timestamp;

  MoodEntry({
    required this.entryId,
    required this.moodKey,
    required this.notes,
    required this.timestamp,
  });

  Map<String, Object?> toMap() {
    return {'mood_key': moodKey, 'notes': notes, 'timestamp': timestamp};
  }
}
