part of 'covid_controller_cubit.dart';

abstract class CovidControllerState extends Equatable {
  const CovidControllerState();
}

class CovidControllerInitial extends CovidControllerState {
  @override
  List<Object> get props => [];
}

class CovidControllerGetDataLoading extends CovidControllerState {
  @override
  List<Object> get props => [];
}

class CovidControllerGetDataSuccessfully extends CovidControllerState {
  final List<CovidModel> covidModel;

  CovidControllerGetDataSuccessfully({required this.covidModel});
  @override
  List<Object> get props => [this.covidModel];
}

class CovidControllerGetDataError extends CovidControllerState {
  final bool error;

  CovidControllerGetDataError(this.error);
  @override
  List<Object> get props => [this.error];
}
