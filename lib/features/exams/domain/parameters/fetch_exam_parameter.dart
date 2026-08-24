// import 'package:equatable/equatable.dart';

// class FetchMarkEntryParameter extends Equatable {
//   final int branchId;
//   final String accYear;
//   final int? standardId;
//   final int? divisionId;
//   final int? examTermId;

//   const FetchMarkEntryParameter({
//     required this.branchId,
//     required this.accYear,
//     this.standardId,
//     this.divisionId,
//     this.examTermId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'branchId': branchId,
//       'accYear': accYear,
//       'standardId': standardId,
//       'divisionId': divisionId,
//       'examTermId': examTermId,
//     };
//   }

//   factory FetchMarkEntryParameter.fromJson(Map<String, dynamic> json) {
//     return FetchMarkEntryParameter(
//       branchId: json['branchId'] as int,
//       accYear: json['accYear'] as String,
//       standardId: json['standardId'] as int?,
//       divisionId: json['divisionId'] as int?,
//       examTermId: json['examTermId'] as int?,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     branchId,
//     accYear,
//     standardId,
//     divisionId,
//     examTermId,
//   ];
// }
import 'package:equatable/equatable.dart';

class FetchMarkEntryParameter extends Equatable {
  final String accYear;
  final int branchId;
  final int? divisionId;
  final int? employeeId;
  final int? examTermId;
  final int? examTypeId;
  final String? fromDate;
  final int? standardId;
  final int? subjectId;
  final String? toDate;

  const FetchMarkEntryParameter({
    required this.accYear,
    required this.branchId,
    this.divisionId,
    this.employeeId,
    this.examTermId,
    this.examTypeId,
    required this.fromDate,
    this.standardId,
    this.subjectId,
    required this.toDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'accYear': accYear,
      'branchId': branchId,
      'divisionId': divisionId,
      'employeeId': employeeId,
      'examTermId': examTermId,
      'examTypeId': examTypeId,
      'fromDate': fromDate,
      'standardId': standardId,
      'subjectId': subjectId,
      'toDate': toDate,
    };
  }

  factory FetchMarkEntryParameter.fromJson(Map<String, dynamic> json) {
    return FetchMarkEntryParameter(
      accYear: json['accYear'] as String,
      branchId: json['branchId'] as int,
      divisionId: json['divisionId'] as int?,
      employeeId: json['employeeId'] as int?,
      examTermId: json['examTermId'] as int?,
      examTypeId: json['examTypeId'] as int?,
      fromDate: json['fromDate'] as String,
      standardId: json['standardId'] as int?,
      subjectId: json['subjectId'] as int?,
      toDate: json['toDate'] as String,
    );
  }

  @override
  List<Object?> get props => [
    accYear,
    branchId,
    divisionId,
    employeeId,
    examTermId,
    examTypeId,
    fromDate,
    standardId,
    subjectId,
    toDate,
  ];
}
