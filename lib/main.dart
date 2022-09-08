import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData( //2
    //3

    elevatedButtonTheme:  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
    primary: Colors.black,//change background color of button
    onPrimary: Colors.white,//change text color of button
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),

    )),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.white,
        //
    ),

      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context)=> super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
}