
part of 'localization_bloc.dart';

abstract class LocalizationListEvents extends Equatable {
  const LocalizationListEvents();

  @override
  List<Object> get props => throw UnimplementedError();
}

class StartEvent extends LocalizationListEvents{}

