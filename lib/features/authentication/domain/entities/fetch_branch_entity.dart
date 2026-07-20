class GetBranchEntity {
  final int? status;
  final bool? error;
  final BranchData? data;

  GetBranchEntity({this.status, this.error, this.data});
}

class BranchData {
  final int? branchId;
  final int? currencyId;
  final String? branchName;
  final String? currencyName;
  final String? place;
  final String? postPin;
  final String? district;
  final String? state;
  final String? phone1;
  final String? phone2;
  final String? mobile;
  final String? email;
  final String? website;
  final String? sector;
  final String? boardDist;
  final String? minWorkDays;
  final bool? wSun;
  final bool? wMon;
  final bool? wTue;
  final bool? wWed;
  final bool? wThur;
  final bool? wFri;
  final bool? wSat;
  final String? branchHead;
  final String? taxNo;
  final String? panNo;
  final String? logo;
  final String? startDate;
  final bool? mainBranch;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final String? bannerImage;

  BranchData({
    this.branchId,
    this.currencyId,
    this.branchName,
    this.currencyName,
    this.place,
    this.postPin,
    this.district,
    this.state,
    this.phone1,
    this.phone2,
    this.mobile,
    this.email,
    this.website,
    this.sector,
    this.boardDist,
    this.minWorkDays,
    this.wSun,
    this.wMon,
    this.wTue,
    this.wWed,
    this.wThur,
    this.wFri,
    this.wSat,
    this.branchHead,
    this.taxNo,
    this.panNo,
    this.logo,
    this.startDate,
    this.mainBranch,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.bannerImage,
  });
}
