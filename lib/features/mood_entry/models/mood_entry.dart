// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoodEntry {
  int? entryId;
  int moodId;
  String notes;
  String timestamp;

  MoodEntry({
    required this.entryId,
    required this.moodId,
    required this.notes,
    required this.timestamp,
  });

  Map<String, Object?> toMap() {
    return {'mood_id': moodId, 'notes': notes, 'timestamp': timestamp};
  }
}
