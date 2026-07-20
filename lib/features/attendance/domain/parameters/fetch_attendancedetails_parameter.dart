class AttendanceDetailsRequest {
  final String accyear;
  final int standard;
  final int division;
  final String? gender;
  final String sortBy;

  const AttendanceDetailsRequest({
    required this.accyear,
    required this.standard,
    required this.division,
    this.gender,
    required this.sortBy,
  });

  factory AttendanceDetailsRequest.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailsRequest(
      accyear: json['accyear'],
      standard: json['standard'],
      division: json['division'],
      gender: json['gender'],
      sortBy: json['sortBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accyear': accyear,
      'standard': standard,
      'division': division,
      'gender': gender,
      'sortBy': sortBy,
    };
  }

  AttendanceDetailsRequest copyWith({
    String? accyear,
    int? standard,
    int? division,
    String? gender,
    String? sortBy,
  }) {
    return AttendanceDetailsRequest(
      accyear: accyear ?? this.accyear,
      standard: standard ?? this.standard,
      division: division ?? this.division,
      gender: gender ?? this.gender,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
