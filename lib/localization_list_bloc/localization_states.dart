import 'package:equatable/equatable.dart';

abstract class LocalizationListStates extends Equatable {
  const LocalizationListStates();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LocalizationListInitState extends LocalizationListStates {
  @override
  List<Object> get props => [];
}

class LocalizationListLoadingState extends LocalizationListStates {
  @override
  List<Object> get props => [];
}

class LocalizationListLoadedState extends LocalizationListStates {

  @override
  List<Object> get props => [];
}

class LocalizationListErrorState extends LocalizationListStates {
  final String errorMessage;

  const LocalizationListErrorState({required this.errorMessage});

  @override
  List<Object> get props => [];
}
