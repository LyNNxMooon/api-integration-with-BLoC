import 'package:bloc_api/BLoC/general/general_events.dart';
import 'package:bloc_api/BLoC/general/general_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/general_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenereBloc extends Bloc<GenereEvents, GenereStates> {
  final GeneralRepository generalRepo;

  GenereBloc({required this.generalRepo}) : super(GenereInit()) {
    on<FetchGeneresEvent>(_onFetchGeneres);
  }

  final _hiveModel = HiveModel();

  Future<void> _onFetchGeneres(
      FetchGeneresEvent event, Emitter<GenereStates> emit) async {
    emit(GenereLoading());
    try {
      final genereResponse =
          await generalRepo.fetchAllGeneres(_hiveModel.getUserToken());

      emit(GenereLoaded(generes: genereResponse));
    } catch (error) {
      emit(GenereError(message: "Error fetching generes: $error"));
    }
  }
}
