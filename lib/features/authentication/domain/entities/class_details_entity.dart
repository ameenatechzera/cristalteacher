class FetchTutorshipClassEntity {
  final int? status;
  final bool? error;
  final TutorshipClassData? data;

  FetchTutorshipClassEntity({this.status, this.error, this.data});
}

class TutorshipClassData {
  final List<TutorshipClass>? tutorshipClass;

  TutorshipClassData({this.tutorshipClass});
}

class TutorshipClass {
  final int? standardId;
  final String? standard;
  final List<DivisionDetails>? division;

  TutorshipClass({this.standardId, this.standard, this.division});
}

class DivisionDetails {
  final int? divisionId;
  final String? division;
  final List<SubjectDetails>? subject;

  DivisionDetails({this.divisionId, this.division, this.subject});
}

class SubjectDetails {
  final int? subjectId;
  final String? subject;

  SubjectDetails({this.subjectId, this.subject});
}
