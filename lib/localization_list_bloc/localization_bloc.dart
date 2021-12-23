import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/load_keys_repository.dart';
import 'localization_states.dart';

part 'localization_events.dart';

class LocalizationListBloc
    extends Bloc<LocalizationListEvents, LocalizationListStates> {
  LocalizationListBloc({
    required LocalizationListStates initialState,
  }) : super(initialState) {
    on<StartEvent>((event, emit) async {
      emit(LocalizationListLoadingState());
      debugPrint('Loading');
      await LoadKeysRepository().loadKeys();
      emit(LocalizationListLoadedState());
      debugPrint('Loaded');
      // await Future.delayed(Duration(seconds: 2));
    });
  }

// Stream<LocalizationListStates> mapEventToState(
//     LocalizationListEvents event) async* {
//   if (event is StartEvent) {
//     try {
//       yield LocalizationListLoadingState();
//       //
//       yield LocalizationListLoadedState();
//     } catch (e) {
//       yield LocalizationListErrorState(errorMessage: e.toString());
//     }
//   }
// }
}
