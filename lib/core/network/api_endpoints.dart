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
}
