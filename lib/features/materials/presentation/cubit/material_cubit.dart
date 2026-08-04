import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/materials/domain/entities/fetch_material_entity.dart';
import 'package:cristalteacher/features/materials/domain/parameter/fetch_material_parameter.dart';
import 'package:cristalteacher/features/materials/domain/parameter/save_material_parameter.dart';
import 'package:cristalteacher/features/materials/domain/usecases/fetch_material_usecase.dart';
import 'package:cristalteacher/features/materials/domain/usecases/save_material_usecase.dart';
import 'package:equatable/equatable.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialState> {
  final FetchMaterialUseCase _fetchMaterialUseCase;
  final SaveMaterialUseCase _saveMaterialUseCase;

  MaterialCubit({
    required FetchMaterialUseCase fetchMaterialUseCase,
    required SaveMaterialUseCase saveMaterialUseCase,
  }) : _fetchMaterialUseCase = fetchMaterialUseCase,
       _saveMaterialUseCase = saveMaterialUseCase,
       super(MaterialInitial());

  Future<void> fetchMaterials(FetchMaterialParameter request) async {
    print('📘 Fetch Materials Request: ${request.toJson()}');

    emit(FetchMaterialLoading());

    try {
      final result = await _fetchMaterialUseCase(request);

      result.fold(
        (failure) {
          print('❌ Fetch Materials Failed');
          print(failure.message);

          emit(FetchMaterialFailure(failure.message));
        },
        (response) {
          emit(FetchMaterialSuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during fetchMaterials');
      print(e);
      print(stackTrace);

      emit(const FetchMaterialFailure('An unexpected error occurred'));
    }
  }

  Future<void> saveMaterial(SaveMaterialParameter request) async {
    print('📘 Save Material Request');

    emit(SaveMaterialLoading());

    try {
      final result = await _saveMaterialUseCase(request);

      result.fold(
        (failure) {
          print('❌ Save Material Failed');
          print(failure.message);

          emit(SaveMaterialFailure(failure.message));
        },
        (response) {
          emit(SaveMaterialSuccess(response));
        },
      );
    } catch (e, stackTrace) {
      print('❌ Exception during saveMaterial');
      print(e);
      print(stackTrace);

      emit(const SaveMaterialFailure('An unexpected error occurred'));
    }
  }
}
