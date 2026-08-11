import 'package:cristalteacher/features/materials/domain/entities/fetch_material_entity.dart';

class FetchMaterialModel extends FetchMaterialEntity {
  const FetchMaterialModel({
    super.status,
    super.error,
    super.message,
    super.data,
  });

  factory FetchMaterialModel.fromJson(Map<String, dynamic> json) {
    return FetchMaterialModel(
      status: int.tryParse(json['status'].toString()),
      error: json['error'] as bool?,
      message: json['message']?.toString(),
      data: (json['data'] as List?)
          ?.map((e) => MaterialModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': error,
      'message': message,
      'data': data?.map((e) => (e as MaterialModel).toJson()).toList(),
    };
  }
}

class MaterialModel extends MaterialEntity {
  const MaterialModel({
    super.materialId,
    super.staffId,
    super.accYear,
    super.standardId,
    super.divisionId,
    super.subjectId,
    super.material,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.documentName,
    super.notes,
    super.link,
    super.favorite,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      materialId: int.tryParse(json['materialId'].toString()),
      staffId: int.tryParse(json['StaffId'].toString()),
      accYear: json['AccYear']?.toString(),
      standardId: int.tryParse(json['StandardId'].toString()),
      divisionId: int.tryParse(json['DivisionId'].toString()),
      subjectId: int.tryParse(json['SubjectId'].toString()),
      material: json['Material']?.toString(),
      branchId: int.tryParse(json['branchId'].toString()),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      documentName: json['documentName']?.toString(),
      notes: json['notes']?.toString(),
      link: json['link']?.toString(),
      favorite: json['favorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materialId': materialId,
      'StaffId': staffId,
      'AccYear': accYear,
      'StandardId': standardId,
      'DivisionId': divisionId,
      'SubjectId': subjectId,
      'Material': material,
      'branchId': branchId,
      'CreatedDate': createdDate,
      'CreatedUser': createdUser,
      'ModifiedDate': modifiedDate,
      'ModifiedUser': modifiedUser,
      'documentName': documentName,
      'notes': notes,
      'link': link,
      'favorite': favorite,
    };
  }
}
