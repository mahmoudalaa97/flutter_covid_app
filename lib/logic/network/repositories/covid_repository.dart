import 'package:covid21/logic/network/api_strings.dart';
import 'package:covid21/logic/network/dio_helper.dart';
import 'package:dio/dio.dart';

abstract class CovidRepository {
  Future<Response?> getDataByCountryAndDate(
      {required DateTime from, required DateTime to});
}

class CovidApiClient extends CovidRepository {
  @override
  Future<Response?> getDataByCountryAndDate(
      {String? country,required DateTime from, required DateTime to}) async {
    return await DioHelper.getData(
        path: ApiStrings.getByCountryAndDate, query: {"from": from, "to": to});
  }
}
