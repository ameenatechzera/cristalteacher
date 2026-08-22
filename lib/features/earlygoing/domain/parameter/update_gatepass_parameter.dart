class UpdateGatePassParameter {
  final String accYear;
  final String admno;
  final String requestDate;
  final String earlyLeaveData;
  final String leaveTime;
  final String reason;
  final String pickupPersonName;
  final String pickupPersonMobile;
  final String pickupPersonRelation;
  final String teacherStatus;
  final String teacherRemarks;
  final String teacherApprovedAt;
  final String requestNo;
  final String modifiedUser;
  final int branchId;
  final String finalStatus;

  const UpdateGatePassParameter({
    required this.accYear,
    required this.admno,
    required this.requestDate,
    required this.earlyLeaveData,
    required this.leaveTime,
    required this.reason,
    required this.pickupPersonName,
    required this.pickupPersonMobile,
    required this.pickupPersonRelation,
    required this.teacherStatus,
    required this.teacherRemarks,
    required this.teacherApprovedAt,
    required this.requestNo,
    required this.modifiedUser,
    required this.branchId,
    required this.finalStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'AccYear': accYear,
      'Admno': admno,
      'RequestDate': requestDate,
      'EarlyLeaveData': earlyLeaveData,
      'LeaveTime': leaveTime,
      'Reason': reason,
      'PickupPersonName': pickupPersonName,
      'PickupPersonMobile': pickupPersonMobile,
      'PickupPersonRelation': pickupPersonRelation,
      'TeacherStatus': teacherStatus,
      'TeacherRemarks': teacherRemarks,
      'TeacherApprovedAt': teacherApprovedAt,
      'requestNo': requestNo,
      'ModifiedUser': modifiedUser,
      'branchId': branchId,
      'finalStatus': finalStatus,
    };
  }
}
