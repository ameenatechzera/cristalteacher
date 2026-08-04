import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/materials/domain/entities/fetch_material_entity.dart';
import 'package:cristalteacher/features/materials/domain/parameter/fetch_material_parameter.dart';
import 'package:cristalteacher/features/materials/domain/repository/material_repository.dart';

class FetchMaterialUseCase
    implements UseCaseWithParams<FetchMaterialEntity, FetchMaterialParameter> {
  final MaterialRepository _materialRepository;

  FetchMaterialUseCase(this._materialRepository);

  @override
  ResultFuture<FetchMaterialEntity> call(FetchMaterialParameter request) async {
    return _materialRepository.fetchMaterials(request);
  }
}
