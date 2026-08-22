class GatePassEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<GatePassData>? data;

  const GatePassEntity({this.status, this.error, this.message, this.data});
}

class GatePassData {
  final int? id;
  final String? requestNo;
  final String? admno;
  final String? name;
  final String? standardId;
  final String? standard;
  final String? divisionId;
  final String? division;
  final String? employeeId;
  final String? employeeName;
  final String? requestDate;
  final String? reason;
  final String? pickupPersonName;
  final String? pickupPersonRelation;
  final String? pickupPersonMobile;
  final String? teacherStatus;
  final String? finalStatus;

  const GatePassData({
    this.id,
    this.requestNo,
    this.admno,
    this.name,
    this.standardId,
    this.standard,
    this.divisionId,
    this.division,
    this.employeeId,
    this.employeeName,
    this.requestDate,
    this.reason,
    this.pickupPersonName,
    this.pickupPersonRelation,
    this.pickupPersonMobile,
    this.teacherStatus,
    this.finalStatus,
  });
}
