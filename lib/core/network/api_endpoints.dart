class ApiConstants {
  /// Returns the full URL for Register / Get Company endpoint
  static String getRegisterServerPath(String baseUrl) {
    return '$baseUrl/company/get-company';
  }

  /// Returns the full URL for Login endpoint
  static String getLoginPath(String baseUrl) {
    return '${baseUrl}login';
  }

  // static String getFetchSchoolPath(String baseUrl) {
  //   return '${baseUrl}get-school';
  // }

  static String getBranchDetailsPath(String baseUrl) {
    return '${baseUrl}app/branch-byid/1';
  }

  static String getAttendanceDetailsPath(String baseUrl) {
    return '${baseUrl}student-report/by-filter';
  }

  /// Returns the full URL for Fees / Get Acc Years
  static String getAccYearsServerPath(String baseUrl) {
    return '${baseUrl}app/accyears/1';
  }

  static String getSaveAttendancePath(String baseUrl) {
    return '${baseUrl}save-StudentAttendanceMaster';
  }

  static String getDiaryDetailsPath(String baseUrl) {
    return '${baseUrl}classdiary';
  }

  static String getSaveDiaryPath(String baseUrl) {
    return '${baseUrl}save-classdiary';
  }

  static String getFeedReportPath(String baseUrl) {
    return '${baseUrl}feed-report';
  }

  static String getSaveFeedPath(String baseUrl) {
    return '${baseUrl}save-feedmaster';
  }

  static String getFetchMaterialPath(String baseUrl) {
    return '${baseUrl}app/get-material-list';
  }

  static String saveMaterialPath(String baseUrl) {
    return '${baseUrl}save-material';
  }

  static String getMarkEntryPath(String baseUrl) {
    return '${baseUrl}exam-mark-entry/show-by-branch';
  }

  static String getGradePlanPath(String baseUrl) {
    return '${baseUrl}exam-grade-plans-data/1';
  }

  static String getAllExamPath(String baseUrl) {
    return '${baseUrl}get-allexams/1';
  }

  static String saveExamMarksPath(String baseUrl) {
    return '${baseUrl}exam-mark-entry/store';
  }

  static String getAttendanceReportPath(String baseUrl) {
    return '${baseUrl}app/teacher-wise-attendance';
  }

  static String deleteExamMarkPath(String baseUrl) {
    return '${baseUrl}exam-mark-entry/delete/';
  }

  static String deleteDiaryPath(String baseUrl) {
    return '${baseUrl}delete-classdiary/';
  }

  static String getDeleteFeedPath(String baseUrl) {
    return '${baseUrl}delete-feedmaster/';
  }

  static String updateExamMarksPath(String baseUrl) {
    return '${baseUrl}exam-mark-entry/update/';
  }
}
