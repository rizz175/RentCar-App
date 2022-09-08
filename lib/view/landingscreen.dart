import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/signin_screen.dart';
import 'package:solomonic/view/signup_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Stack(
        children:  [
          Container(
            height: MediaQuery.of(context).size.height,
          ),

 Hero(
                tag: "logo",
                child: Image(image: AssetImage("images/logo.png"))),


           Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: EdgeInsets.only(left: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Rent A Car",style: TextStyle(color: Colors.white,fontSize: 25,
    fontWeight: FontWeight.bold,fontFamily: "cursive"), ),
    Text("Get Your Desire Car For Your Road Trip",style: TextStyle(color: Colors.white70,fontSize:17,
    ), ),
    ],
    ),

            ),

          ),



          Positioned(
            bottom:0,
            child: Container(
              height:  MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration:  const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                        },
                        child:  Text("Join now", style: GoogleFonts.getFont('Russo One'),),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.black,
                            side:BorderSide(width: 5.0, color: Colors.white,),
                            fixedSize: const Size(140, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      ),
                    ),

                    Container(
                      child: ElevatedButton(
                        onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignIn()));
                        },
                        child:  Text("Login",  style: GoogleFonts.getFont('Russo One'),),
                        style: ElevatedButton.styleFrom(
                            primary:Colors.white,
                            onPrimary:Colors.black,
                            fixedSize: const Size(140, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
