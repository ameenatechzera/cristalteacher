class SaveExamMarksEntity {
  final bool status;
  final String message;
  final int markEntryId;

  const SaveExamMarksEntity({
    required this.status,
    required this.message,
    required this.markEntryId,
  });
}
