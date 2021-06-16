import 'package:covid21/logic/cubit/covid_controller_cubit.dart';
import 'package:covid21/logic/network/dio_helper.dart';
import 'package:covid21/logic/network/repositories/covid_repository.dart';
import 'package:covid21/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  /// Check code on the main is finished
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff25727A),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: BlocProvider(
        create: (context) => CovidControllerCubit(CovidApiClient())
          ..getDataByCountryAndDate(
              from: DateTime.now(),
              to: DateTime(
                2021,
              )),
        child: HomeScreen(),
      ),
    );
  }
}
