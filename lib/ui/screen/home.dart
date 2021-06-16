import 'package:covid21/core/utils/date_format_helper.dart';
import 'package:covid21/core/utils/size_responsive.dart';
import 'package:covid21/logic/cubit/covid_controller_cubit.dart';
import 'package:covid21/logic/model/covid_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CovidControllerCubit covidController =
        context.watch<CovidControllerCubit>();
    List<CovidModel>? covidModel = covidController.covidModel;
    Size size = MediaQuery.of(context).size;
    print("Build");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Egypt,cairo",
              style: textStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Icon(Icons.arrow_drop_down_outlined)
          ],
        ),
        leading: Image.asset("assets/menu.png"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/bell.png",
                width: 25,
              ))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: size.width * s10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/covid-bg.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * s80,
                child: Container(
                  padding: EdgeInsets.only(right: size.width * s50),
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                        covidModel != null,
                        widgetBuilder: (context) =>   Text(
                          "${context.watch<CovidControllerCubit>().covidModel?.last.confirmed ?? ""}",
                          style: textStyle(
                              fontSize: size.width * s40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        fallbackBuilder: (context) =>
                            CircularProgressIndicator(),
                      ),

                      Text(
                        "Total Cases",
                        style: textStyle(
                            fontSize: size.width * s18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height - size.height * s120,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * s20, vertical: size.width * s40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.zero,
                                color: Colors.grey.shade400,
                                blurRadius: 5)
                          ]),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 150,
                              width: (size.width - 100) / 2,
                              child: Image.asset(
                                "assets/doctor.png",
                              )),
                          Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "COVID19",
                                style: textStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Conditional.single(
                                context: context,
                                conditionBuilder: (context) =>
                                    covidModel != null,
                                widgetBuilder: (context) => Text(
                                    "${DateFormatHelper.getDateFormat(covidModel?.last.date)}",
                                    style: textStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                fallbackBuilder: (context) =>
                                    CircularProgressIndicator(),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildExpandedItem(
                          context,
                          title: "Recovered",
                          colorTitle: Colors.green.shade600,
                          data: covidModel?.last.recovered.toString()??null,
                        ),
                        buildExpandedItem(context,
                            title: "Active",
                            colorTitle: Colors.amber.shade600,
                            data: covidModel?.last.active.toString()??null,
                            colorData: Colors.black),
                        buildExpandedItem(
                          context,
                          title: "Deaths",
                          colorTitle: Colors.red.shade600,
                          data: covidModel?.last.deaths.toString()??null,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedItem(
    BuildContext context, {
    required String? title,
    required String? data,
    required Color? colorTitle,
    Color? colorData = Colors.black,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                  offset: Offset.zero,
                  color: Colors.grey.shade400,
                  blurRadius: 5)
            ]),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total\n$title",
              textAlign: TextAlign.center,
              style: textStyle(
                  fontSize: 15, color: colorTitle, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Conditional.single(context: context,
                conditionBuilder: (context) => data!=null,
                widgetBuilder: (context) =>   Text(
                  "$data",
                  style: textStyle(
                      fontSize: 16, color: colorData, fontWeight: FontWeight.w900),
                ),
                fallbackBuilder: (context) => CircularProgressIndicator(),)

          ],
        ),
      ),
    );
  }

  TextStyle textStyle(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'QuickSand',
        fontWeight: fontWeight);
  }
}
