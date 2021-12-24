import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository.dart';
import 'localization_events.dart';
import 'localization_states.dart';

class LocalizationListBloc
    extends Bloc<LocalizationListEvents, LocalizationListStates> {
  LocalizationListBloc({
    required LocalizationListStates initialState,
  }) : super(initialState) {
    on<StartEvent>((event, emit) async {
      List listAll;
      emit(LocalizationListLoadingState());
      listAll = await LoadKeysRepository().loadKeys();
      _loadedToValue(listAll, emit);
    });
  }

  void _loadedToValue(List listAll, Emitter<LocalizationListStates> emit) {
    emit(LocalizationListLoadedState(listAll: listAll));
  }
}
