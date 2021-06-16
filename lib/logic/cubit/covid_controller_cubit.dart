import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:covid21/logic/model/covid_model.dart';
import 'package:covid21/logic/network/repositories/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'covid_controller_state.dart';

class CovidControllerCubit extends Cubit<CovidControllerState> {
  final CovidRepository covidRepository;

  CovidControllerCubit(this.covidRepository) : super(CovidControllerInitial());

 static  CovidControllerCubit get(context)=> BlocProvider.of(context);
  List<CovidModel>? covidModel;

  getDataByCountryAndDate(
      {String? country, required DateTime from, required DateTime to}) async {
    emit(CovidControllerGetDataLoading());
    await covidRepository
        .getDataByCountryAndDate(from: from, to: to)
        .then((response) {
      covidModel = covidModelFromJson(jsonEncode(response!.data));
      emit(CovidControllerGetDataSuccessfully(covidModel: covidModel!));
    }).catchError((error) {
      print(error);
    });
  }
}
