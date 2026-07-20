import 'package:cristalteacher/features/authentication/domain/entities/fetch_branch_entity.dart';

class GetBranchResponseModel extends GetBranchEntity {
  GetBranchResponseModel({
    super.status,
    super.error,
    BranchDataModel? super.data,
  });

  factory GetBranchResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBranchResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      data: json['data'] != null
          ? BranchDataModel.fromJson(json['data'])
          : null,
    );
  }
}

class BranchDataModel extends BranchData {
  BranchDataModel({
    super.branchId,
    super.currencyId,
    super.branchName,
    super.currencyName,
    super.place,
    super.postPin,
    super.district,
    super.state,
    super.phone1,
    super.phone2,
    super.mobile,
    super.email,
    super.website,
    super.sector,
    super.boardDist,
    super.minWorkDays,
    super.wSun,
    super.wMon,
    super.wTue,
    super.wWed,
    super.wThur,
    super.wFri,
    super.wSat,
    super.branchHead,
    super.taxNo,
    super.panNo,
    super.logo,
    super.startDate,
    super.mainBranch,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.bannerImage,
  });

  factory BranchDataModel.fromJson(Map<String, dynamic> json) {
    return BranchDataModel(
      branchId: json['branchId'] as int?,
      currencyId: json['currencyId'] as int?,
      branchName: json['branchName']?.toString(),
      place: json['place']?.toString(),

      postPin: json['post_Pin']?.toString(),
      district: json['District']?.toString(),
      state: json['State']?.toString(),

      phone1: json['Phone1']?.toString(),
      phone2: json['Phone2']?.toString(),
      mobile: json['Mobile']?.toString(),

      email: json['Email']?.toString(),
      website: json['Website']?.toString(),
      sector: json['Sector']?.toString(),
      boardDist: json['BoardDist']?.toString(),

      minWorkDays: json['MinWorkDays']?.toString(),

      wSun: json['WSun'] as bool?,
      wMon: json['WMon'] as bool?,
      wTue: json['WTue'] as bool?,
      wWed: json['WWed'] as bool?,
      wThur: json['WThur'] as bool?,
      wFri: json['WFri'] as bool?,
      wSat: json['WSat'] as bool?,

      branchHead: json['BranchHead']?.toString(),
      taxNo: json['TaxNo']?.toString(),
      panNo: json['panNo']?.toString(),

      logo: json['logo']?.toString(),
      startDate: json['startDate']?.toString(),
      mainBranch: json['mainBranch'] as bool?,

      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      bannerImage: json['bannerImage']?.toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "currencyId": currencyId,
      "branchName": branchName,
      "place": place,
      "post_Pin": postPin,
      "District": district,
      "State": state,
      "Phone1": phone1,
      "Phone2": phone2,
      "Mobile": mobile,
      "Email": email,
      "Website": website,
      "Sector": sector,
      "BoardDist": boardDist,
      "MinWorkDays": minWorkDays,
      "WSun": wSun,
      "WMon": wMon,
      "WTue": wTue,
      "WWed": wWed,
      "WThur": wThur,
      "WFri": wFri,
      "WSat": wSat,
      "BranchHead": branchHead,
      "TaxNo": taxNo,
      "panNo": panNo,
      "logo": logo,
      "startDate": startDate,
      "mainBranch": mainBranch,
      "CreatedDate": createdDate,
      "CreatedUser": createdUser,
      "ModifiedDate": modifiedDate,
      "ModifiedUser": modifiedUser,
      "bannerImage": bannerImage,
    };
  }
}
