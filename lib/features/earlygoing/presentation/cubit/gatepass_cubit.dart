import 'package:bloc/bloc.dart';
import 'package:cristalteacher/core/models/master_response_model.dart';
import 'package:cristalteacher/features/earlygoing/domain/entities/gatepass_entity.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/parameter/update_gatepass_parameter.dart';
import 'package:cristalteacher/features/earlygoing/domain/usecases/fetch_gatepass_usecase.dart';
import 'package:cristalteacher/features/earlygoing/domain/usecases/update_gatepass_usecase.dart';
import 'package:equatable/equatable.dart';

part 'gatepass_state.dart';

class GatepassCubit extends Cubit<GatepassState> {
  final FetchGatePassUseCase _fetchGatePassUseCase;
  final UpdateGatePassUseCase _updateGatePassUseCase;

  GatepassCubit({
    required FetchGatePassUseCase fetchGatePassUseCase,
    required UpdateGatePassUseCase updateGatePassUseCase,
  }) : _fetchGatePassUseCase = fetchGatePassUseCase,
       _updateGatePassUseCase = updateGatePassUseCase,
       super(GatepassInitial());

  Future<void> fetchGatePass(FetchGatePassParameter request) async {
    emit(GatepassLoading());

    try {
      final result = await _fetchGatePassUseCase(request);

      result.fold(
        (failure) {
          emit(GatepassFailure(failure.message));
        },
        (response) {
          emit(GatepassSuccess(response));
        },
      );
    } catch (e) {
      emit(const GatepassFailure('An unexpected error occurred'));
    }
  }

  Future<void> updateGatePass(UpdateGatePassParameter request, int id) async {
    emit(UpdateGatePassLoading());

    try {
      final result = await _updateGatePassUseCase(request, id);

      result.fold(
        (failure) {
          emit(UpdateGatePassFailure(failure.message));
        },
        (response) {
          emit(UpdateGatePassSuccess(response));
        },
      );
    } catch (e) {
      emit(const UpdateGatePassFailure('An unexpected error occurred'));
    }
  }
}
