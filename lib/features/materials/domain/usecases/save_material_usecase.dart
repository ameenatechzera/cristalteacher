import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/core/usecases/general_usecases.dart';
import 'package:cristalteacher/core/utils/typedef.dart';
import 'package:cristalteacher/features/materials/domain/parameter/save_material_parameter.dart';
import 'package:cristalteacher/features/materials/domain/repository/material_repository.dart';

class SaveMaterialUseCase
    extends UseCaseWithParams<MasterResponseModel, SaveMaterialParameter> {
  final MaterialRepository repository;

  SaveMaterialUseCase(this.repository);

  @override
  ResultFuture<MasterResponseModel> call(SaveMaterialParameter params) {
    return repository.saveMaterial(params);
  }
}
