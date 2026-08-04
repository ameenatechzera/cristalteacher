class SaveDiaryParameter {
  final String accYear;
  final int standardId;
  final int divisionId;
  final int subjectId;
  final int employeeId;
  final int diaryType;
  final String diaryTitle;
  final String description;
  final String diaryDate;
  final String dueDate;
  final bool isActive;
  final bool isFavourite;
  final int branchId;
  final String createdUser;
  final List<String> files;
  final String videoUrl;

  const SaveDiaryParameter({
    required this.accYear,
    required this.standardId,
    required this.divisionId,
    required this.subjectId,
    required this.employeeId,
    required this.diaryType,
    required this.diaryTitle,
    required this.description,
    required this.diaryDate,
    required this.dueDate,
    required this.isActive,
    required this.isFavourite,
    required this.branchId,
    required this.createdUser,
    required this.files,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "SubjectId": subjectId,
      "EmployeeId": employeeId,
      "diaryType": diaryType,
      "diaryTitle": diaryTitle,
      "Description": description,
      "diaryDate": diaryDate,
      "dueDate": dueDate,
      "isActive": isActive,
      "isFavourite": isFavourite,
      "branchId": branchId,
      "CreatedUser": createdUser,
      "files": files,
      "videoUrl": videoUrl,
    };
  }
}
