class AttendanceDetailsEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<AttendanceDetailsData>? data;

  const AttendanceDetailsEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class AttendanceDetailsData {
  final String? accYear;
  final String? sectionName;
  final int? admissionId;
  final String? admno;
  final String? name;
  final String? gender;
  final String? father;
  final String? mother;
  final String? motherMobile;
  final String? dob;
  final String? dobInWords;
  final int? age;
  final String? placeofBirth;
  final String? guardian;
  final String? relation;
  final String? occupation;
  final String? houseName;
  final String? street;
  final String? place;
  final String? post;
  final String? nationality;
  final String? state;
  final String? district;
  final String? landphone;
  final String? mobile;
  final String? email;
  final String? bloodGroup;
  final String? aadharNo;
  final String? standard;
  final String? division;
  final String? religion;
  final String? category;
  final String? caste;
  final String? doj;
  final String? medium;
  final String? firstlan;
  final String? secondlan;
  final String? mothertongue;
  final String? pretcno;
  final String? pretcdate;
  final String? pretcschool;
  final String? previousClass;
  final String? madrassaadmno;
  final String? madrassastd;
  final String? madrassadiv;
  final String? deformity;
  final String? identitymark1;
  final String? identitymark2;
  final String? consessiontype;
  final bool? relativestatus;
  final bool? busstatus;
  final String? activestatus;
  final String? vaccinationdate;
  final String? bankname;
  final String? accountno;
  final String? artsschool;
  final String? artsdistrict;
  final String? artsstate;
  final String? artsnational;
  final String? sportsschool;
  final String? sportsdistrict;
  final String? sportsstate;
  final String? sportsnational;

  const AttendanceDetailsData({
    this.accYear,
    this.sectionName,
    this.admissionId,
    this.admno,
    this.name,
    this.gender,
    this.father,
    this.mother,
    this.motherMobile,
    this.dob,
    this.dobInWords,
    this.age,
    this.placeofBirth,
    this.guardian,
    this.relation,
    this.occupation,
    this.houseName,
    this.street,
    this.place,
    this.post,
    this.nationality,
    this.state,
    this.district,
    this.landphone,
    this.mobile,
    this.email,
    this.bloodGroup,
    this.aadharNo,
    this.standard,
    this.division,
    this.religion,
    this.category,
    this.caste,
    this.doj,
    this.medium,
    this.firstlan,
    this.secondlan,
    this.mothertongue,
    this.pretcno,
    this.pretcdate,
    this.pretcschool,
    this.previousClass,
    this.madrassaadmno,
    this.madrassastd,
    this.madrassadiv,
    this.deformity,
    this.identitymark1,
    this.identitymark2,
    this.consessiontype,
    this.relativestatus,
    this.busstatus,
    this.activestatus,
    this.vaccinationdate,
    this.bankname,
    this.accountno,
    this.artsschool,
    this.artsdistrict,
    this.artsstate,
    this.artsnational,
    this.sportsschool,
    this.sportsdistrict,
    this.sportsstate,
    this.sportsnational,
  });
}
