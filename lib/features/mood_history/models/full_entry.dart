// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoodHistoryEntry {
  final int entryId;
  final int moodId;
  final String image;
  final String description;
  final String notes;
  final String timestamp;

  MoodHistoryEntry({
    required this.entryId,
    required this.moodId,
    required this.image,
    required this.description,
    required this.notes,
    required this.timestamp,
  });
}
