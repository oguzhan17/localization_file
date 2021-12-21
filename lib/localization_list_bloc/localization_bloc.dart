import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'localization_events.dart';
import 'localization_states.dart';

class LocalizationListBloc
    extends Bloc<LocalizationListEvents, LocalizationListStates> {

  LocalizationListBloc({required LocalizationListStates initialState,})
      : super(initialState){
  add(StartEvent());
}
}

Stream<LocalizationListStates> mapEventToState(
    LocalizationListEvents event) async* {
  if (event is StartEvent) {
    try {
      yield LocalizationListLoadingState();
      yield LocalizationListLoadedState();
    } catch (e) {
      yield LocalizationListErrorState(errorMessage: e.toString());
    }
  }

}