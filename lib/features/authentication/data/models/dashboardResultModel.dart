import 'package:cristalteacher/features/authentication/domain/entities/teacher_dashboard_result.dart';

class DashboardResultModel extends TeacherDashboardResult{
  DashboardResultModel({required super.status, required super.error, required super.data});
  factory DashboardResultModel.fromJson(Map<String, dynamic> json){
    return DashboardResultModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}