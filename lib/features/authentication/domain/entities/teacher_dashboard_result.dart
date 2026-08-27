import 'package:equatable/equatable.dart';

class TeacherDashboardResult extends Equatable {
  TeacherDashboardResult({
    required this.status,
    required this.error,
    required this.data,
  });

  final int status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final List<Datum> data;
  static const String dataKey = "data";


  TeacherDashboardResult copyWith({
    int? status,
    bool? error,
    List<Datum>? data,
  }) {
    return TeacherDashboardResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory TeacherDashboardResult.fromJson(Map<String, dynamic> json){
    return TeacherDashboardResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "data": data.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $error, $data, ";
  }

  @override
  List<Object?> get props => [
    status, error, data, ];
}

class Datum extends Equatable {
  Datum({
    required this.employeeId,
    required this.employeeName,
    required this.employeeCode,
    required this.designationId,
    required this.subjectsTaught,
    required this.classInCharge,
    required this.divisionInCharge,
    required this.studentCountInCharge,
    required this.classChargeSubjects,
    required this.todayPeriods,
    required this.todayClasses,
    required this.todayDivisions,
    required this.todaySubjects,
    required this.phoneNo,
    required this.mobileNo,
    required this.email,
    required this.active,
  });

  final int employeeId;
  static const String employeeIdKey = "employee_id";

  final String employeeName;
  static const String employeeNameKey = "employee_name";

  final String employeeCode;
  static const String employeeCodeKey = "employee_code";

  final String designationId;
  static const String designationIdKey = "designation_id";

  final String subjectsTaught;
  static const String subjectsTaughtKey = "subjects_taught";

  final String classInCharge;
  static const String classInChargeKey = "class_in_charge";

  final String divisionInCharge;
  static const String divisionInChargeKey = "division_in_charge";

  final int studentCountInCharge;
  static const String studentCountInChargeKey = "student_count_in_charge";

  final String classChargeSubjects;
  static const String classChargeSubjectsKey = "class_charge_subjects";

  final List<TodayPeriod> todayPeriods;
  static const String todayPeriodsKey = "today_periods";

  final String todayClasses;
  static const String todayClassesKey = "today_classes";

  final String todayDivisions;
  static const String todayDivisionsKey = "today_divisions";

  final String todaySubjects;
  static const String todaySubjectsKey = "today_subjects";

  final dynamic phoneNo;
  static const String phoneNoKey = "phone_no";

  final String mobileNo;
  static const String mobileNoKey = "mobile_no";

  final dynamic email;
  static const String emailKey = "email";

  final bool active;
  static const String activeKey = "active";


  Datum copyWith({
    int? employeeId,
    String? employeeName,
    String? employeeCode,
    String? designationId,
    String? subjectsTaught,
    String? classInCharge,
    String? divisionInCharge,
    int? studentCountInCharge,
    String? classChargeSubjects,
    List<TodayPeriod>? todayPeriods,
    String? todayClasses,
    String? todayDivisions,
    String? todaySubjects,
    dynamic? phoneNo,
    String? mobileNo,
    dynamic? email,
    bool? active,
  }) {
    return Datum(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      employeeCode: employeeCode ?? this.employeeCode,
      designationId: designationId ?? this.designationId,
      subjectsTaught: subjectsTaught ?? this.subjectsTaught,
      classInCharge: classInCharge ?? this.classInCharge,
      divisionInCharge: divisionInCharge ?? this.divisionInCharge,
      studentCountInCharge: studentCountInCharge ?? this.studentCountInCharge,
      classChargeSubjects: classChargeSubjects ?? this.classChargeSubjects,
      todayPeriods: todayPeriods ?? this.todayPeriods,
      todayClasses: todayClasses ?? this.todayClasses,
      todayDivisions: todayDivisions ?? this.todayDivisions,
      todaySubjects: todaySubjects ?? this.todaySubjects,
      phoneNo: phoneNo ?? this.phoneNo,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      active: active ?? this.active,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      employeeId: json["employee_id"] ?? 0,
      employeeName: json["employee_name"] ?? "",
      employeeCode: json["employee_code"] ?? "",
      designationId: json["designation_id"] ?? "",
      subjectsTaught: json["subjects_taught"] ?? "",
      classInCharge: json["class_in_charge"] ?? "",
      divisionInCharge: json["division_in_charge"] ?? "",
      studentCountInCharge: json["student_count_in_charge"] ?? 0,
      classChargeSubjects: json["class_charge_subjects"] ?? "",
      todayPeriods: json["today_periods"] == null ? [] : List<TodayPeriod>.from(json["today_periods"]!.map((x) => TodayPeriod.fromJson(x))),
      todayClasses: json["today_classes"] ?? "",
      todayDivisions: json["today_divisions"] ?? "",
      todaySubjects: json["today_subjects"] ?? "",
      phoneNo: json["phone_no"],
      mobileNo: json["mobile_no"] ?? "",
      email: json["email"],
      active: json["active"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "employee_name": employeeName,
    "employee_code": employeeCode,
    "designation_id": designationId,
    "subjects_taught": subjectsTaught,
    "class_in_charge": classInCharge,
    "division_in_charge": divisionInCharge,
    "student_count_in_charge": studentCountInCharge,
    "class_charge_subjects": classChargeSubjects,
    "today_periods": todayPeriods.map((x) => x?.toJson()).toList(),
    "today_classes": todayClasses,
    "today_divisions": todayDivisions,
    "today_subjects": todaySubjects,
    "phone_no": phoneNo,
    "mobile_no": mobileNo,
    "email": email,
    "active": active,
  };

  @override
  String toString(){
    return "$employeeId, $employeeName, $employeeCode, $designationId, $subjectsTaught, $classInCharge, $divisionInCharge, $studentCountInCharge, $classChargeSubjects, $todayPeriods, $todayClasses, $todayDivisions, $todaySubjects, $phoneNo, $mobileNo, $email, $active, ";
  }

  @override
  List<Object?> get props => [
    employeeId, employeeName, employeeCode, designationId, subjectsTaught, classInCharge, divisionInCharge, studentCountInCharge, classChargeSubjects, todayPeriods, todayClasses, todayDivisions, todaySubjects, phoneNo, mobileNo, email, active, ];
}

class TodayPeriod extends Equatable {
  TodayPeriod({
    required this.todayPeriodClass,
    required this.period,
    required this.subject,
    required this.division,
  });

  final String todayPeriodClass;
  static const String todayPeriodClassKey = "class";

  final String period;
  static const String periodKey = "period";

  final String subject;
  static const String subjectKey = "subject";

  final String division;
  static const String divisionKey = "division";


  TodayPeriod copyWith({
    String? todayPeriodClass,
    String? period,
    String? subject,
    String? division,
  }) {
    return TodayPeriod(
      todayPeriodClass: todayPeriodClass ?? this.todayPeriodClass,
      period: period ?? this.period,
      subject: subject ?? this.subject,
      division: division ?? this.division,
    );
  }

  factory TodayPeriod.fromJson(Map<String, dynamic> json){
    return TodayPeriod(
      todayPeriodClass: json["class"] ?? "",
      period: json["period"] ?? "",
      subject: json["subject"] ?? "",
      division: json["division"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "class": todayPeriodClass,
    "period": period,
    "subject": subject,
    "division": division,
  };

  @override
  String toString(){
    return "$todayPeriodClass, $period, $subject, $division, ";
  }

  @override
  List<Object?> get props => [
    todayPeriodClass, period, subject, division, ];
}
