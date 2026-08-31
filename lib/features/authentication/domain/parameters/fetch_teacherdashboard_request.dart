import 'package:equatable/equatable.dart';

class TeacherDashboardRequest extends Equatable {
  TeacherDashboardRequest({
    required this.branchId,
    required this.accYear,
    required this.employeeId,
  });

  final int branchId;
  static const String branchIdKey = "branch_id";

  final String accYear;
  static const String accYearKey = "acc_year";

  final int employeeId;
  static const String employeeIdKey = "employeeId";

  TeacherDashboardRequest copyWith({
    int? branchId,
    String? accYear,
    int? employeeId,
  }) {
    return TeacherDashboardRequest(
      branchId: branchId ?? this.branchId,
      accYear: accYear ?? this.accYear,
      employeeId: employeeId ?? this.employeeId,
    );
  }

  factory TeacherDashboardRequest.fromJson(Map<String, dynamic> json) {
    return TeacherDashboardRequest(
      branchId: json["branch_id"] ?? 0,
      accYear: json["acc_year"] ?? "",
      employeeId: json["employeeId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "acc_year": accYear,
    "employeeId": employeeId,
  };

  @override
  String toString() {
    return "$branchId, $accYear, $employeeId, ";
  }

  @override
  List<Object?> get props => [branchId, accYear, employeeId];
}
