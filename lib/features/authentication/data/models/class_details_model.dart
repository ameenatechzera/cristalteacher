import 'package:cristalteacher/features/authentication/domain/entities/class_details_entity.dart';

class FetchTutorshipClassResponseModel extends FetchTutorshipClassEntity {
  FetchTutorshipClassResponseModel({super.status, super.error, super.data});

  factory FetchTutorshipClassResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchTutorshipClassResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      data: json['data'] == null
          ? null
          : TutorshipClassDataModel.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
    );
  }
}

class TutorshipClassDataModel extends TutorshipClassData {
  TutorshipClassDataModel({super.tutorshipClass, super.standard});

  factory TutorshipClassDataModel.fromJson(Map<String, dynamic> json) {
    return TutorshipClassDataModel(
      tutorshipClass: json['tutorshipclass'] == null
          ? []
          : (json['tutorshipclass'] as List)
                .map(
                  (e) =>
                      TutorshipClassModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
      standard: (json['Standard'] as List?)
          ?.map((e) => TutorshipClassModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TutorshipClassModel extends TutorshipClass {
  TutorshipClassModel({super.standardId, super.standard, super.division});

  factory TutorshipClassModel.fromJson(Map<String, dynamic> json) {
    return TutorshipClassModel(
      standardId: json['StandardId'] as int?,
      standard: json['Standard']?.toString(),
      division: json['Division'] == null
          ? []
          : (json['Division'] as List)
                .map(
                  (e) =>
                      DivisionDetailsModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

class DivisionDetailsModel extends DivisionDetails {
  DivisionDetailsModel({super.divisionId, super.division, super.subject});

  factory DivisionDetailsModel.fromJson(Map<String, dynamic> json) {
    return DivisionDetailsModel(
      divisionId: json['DivisionId'] as int?,
      division: json['Division']?.toString(),
      subject: json['Subject'] == null
          ? []
          : (json['Subject'] as List)
                .map(
                  (e) =>
                      SubjectDetailsModel.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

class SubjectDetailsModel extends SubjectDetails {
  SubjectDetailsModel({super.subjectId, super.subject});

  factory SubjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return SubjectDetailsModel(
      subjectId: json['SubjectId'] as int?,
      subject: json['Subject']?.toString(),
    );
  }
}
