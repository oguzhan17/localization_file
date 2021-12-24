import 'package:equatable/equatable.dart';

class LocalizationListStates extends Equatable {
  const LocalizationListStates();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LocalizationListInitState extends LocalizationListStates {}

class LocalizationListLoadingState extends LocalizationListStates {}

class LocalizationListLoadedState extends LocalizationListStates {
  final List listAll;

  const LocalizationListLoadedState({required this.listAll});
}
