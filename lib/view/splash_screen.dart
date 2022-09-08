import 'package:flutter/material.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/landingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainMenu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10,  right: 10,),
            child: Hero(
                tag: "logo",
                child: Image(image: AssetImage("images/logo.png"))),
          ),
        ),
      ),
    );
  }
}
