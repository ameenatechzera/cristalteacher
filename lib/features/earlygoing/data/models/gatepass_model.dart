import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';

class GatePassResponseModel extends GatePassEntity {
  GatePassResponseModel({
    super.status,
    super.error,
    super.message,
    List<GatePassModel>? super.data,
  });

  factory GatePassResponseModel.fromJson(Map<String, dynamic> json) {
    return GatePassResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message']?.toString(),
      data: (json['data'] as List?)
          ?.map((item) => GatePassModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GatePassModel extends GatePassData {
  GatePassModel({
    super.id,
    super.requestNo,
    super.admno,
    super.name,
    super.standardId,
    super.standard,
    super.divisionId,
    super.division,
    super.employeeId,
    super.employeeName,
    super.requestDate,
    super.reason,
    super.pickupPersonName,
    super.pickupPersonRelation,
    super.pickupPersonMobile,
    super.teacherStatus,
    super.finalStatus,
  });

  factory GatePassModel.fromJson(Map<String, dynamic> json) {
    return GatePassModel(
      id: int.tryParse(json['Id']?.toString() ?? ''),
      requestNo: json['RequestNo']?.toString(),
      admno: json['Admno']?.toString(),
      name: json['Name']?.toString(),
      standardId: json['StandardId']?.toString(),
      standard: json['Standard']?.toString(),
      divisionId: json['DivisionId']?.toString(),
      division: json['Division']?.toString(),
      employeeId: json['EmployeeId']?.toString(),
      employeeName: json['EmployeeName']?.toString(),
      requestDate: json['RequestDate']?.toString(),
      reason: json['Reason']?.toString(),
      pickupPersonName: json['PickupPersonName']?.toString(),
      pickupPersonRelation: json['PickupPersonRelation']?.toString(),
      pickupPersonMobile: json['PickupPersonMobile']?.toString(),
      teacherStatus: json['TeacherStatus']?.toString(),
      finalStatus: json['FinalStatus']?.toString(),
    );
  }
}
