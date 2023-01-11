import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/registration/log_in_page.dart';
import 'package:graduation_project/registration/sign_up_page.dart';
import 'package:graduation_project/report_data.dart';
import 'package:graduation_project/report_result_page.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import 'home_page.dart';
import 'image_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

      initialRoute: LogInPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LogInPage.id: (context) => LogInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        ReportDataPage.id: (context) => ReportDataPage(),
        ReportResultPage.id :(context) => ReportResultPage(),
        ImagePage.id : (context) => ImagePage(),
      },

      themeMode: ThemeMode.light,

      theme: ThemeData(
        backgroundColor: ColorManager.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorManager.pink,),
        focusColor: ColorManager.pink,
        iconTheme:const IconThemeData(
          color: ColorManager.pink,
          size: AppSizes.s30,
        ),
        textTheme:const TextTheme(
          headline3: TextStyle(color: ColorManager.blue, fontSize: AppSizes.s18,),
          headline4: TextStyle(color: ColorManager.white,fontSize: AppSizes.s16,fontWeight: FontWeight.bold),
          headline6: TextStyle(color: ColorManager.black,fontSize: AppSizes.s14,),
          headline5: TextStyle(color: ColorManager.black,fontSize: AppSizes.s14),
        )
      ),

      darkTheme: ThemeData(
        backgroundColor: ColorManager.blue,
        appBarTheme: const AppBarTheme(
            backgroundColor: ColorManager.pink,
          ),
        hoverColor: ColorManager.pink4,
        iconTheme:const IconThemeData(
          color: ColorManager.pink,
          size: AppSizes.s30,
        ),
          textTheme:const TextTheme(
            headline3: TextStyle(color: ColorManager.pink, fontSize: AppSizes.s18,),
            headline4: TextStyle(color: ColorManager.white,fontSize: AppSizes.s16,fontWeight: FontWeight.bold),
            headline6: TextStyle(color: ColorManager.white,fontSize: AppSizes.s14,),
            headline5: TextStyle(color: ColorManager.white,fontSize: AppSizes.s14),
            ),
          ),


      );

  }
}







