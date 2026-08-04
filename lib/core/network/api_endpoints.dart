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

  static String getAllMaterialsPath(String baseUrl) {
    return '${baseUrl}get-all-materials';
  }

  static String saveMaterialPath(String baseUrl) {
    return '${baseUrl}save-material';
  }
}
