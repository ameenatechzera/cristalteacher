class FetchMaterialEntity {
  final int? status;
  final bool? error;
  final List<MaterialEntity>? data;

  const FetchMaterialEntity({this.status, this.error, this.data});
}

class MaterialEntity {
  final int? materialId;
  final int? staffId;
  final String? accYear;
  final int? standardId;
  final int? divisionId;
  final int? subjectId;
  final String? material;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  const MaterialEntity({
    this.materialId,
    this.staffId,
    this.accYear,
    this.standardId,
    this.divisionId,
    this.subjectId,
    this.material,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}
