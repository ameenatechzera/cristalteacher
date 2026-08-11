import 'package:equatable/equatable.dart';

class FetchMarkEntryParameter extends Equatable {
  final int branchId;
  final String accYear;
  final int? standardId;
  final int? divisionId;
  final int? examTermId;

  const FetchMarkEntryParameter({
    required this.branchId,
    required this.accYear,
    this.standardId,
    this.divisionId,
    this.examTermId,
  });

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'accYear': accYear,
      'standardId': standardId,
      'divisionId': divisionId,
      'examTermId': examTermId,
    };
  }

  factory FetchMarkEntryParameter.fromJson(Map<String, dynamic> json) {
    return FetchMarkEntryParameter(
      branchId: json['branchId'] as int,
      accYear: json['accYear'] as String,
      standardId: json['standardId'] as int?,
      divisionId: json['divisionId'] as int?,
      examTermId: json['examTermId'] as int?,
    );
  }

  @override
  List<Object?> get props => [
    branchId,
    accYear,
    standardId,
    divisionId,
    examTermId,
  ];
}
