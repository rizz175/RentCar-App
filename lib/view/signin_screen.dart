import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/mainmenu.dart';
import 'package:solomonic/view/signup_screen.dart';
import 'package:solomonic/widgets/custom_pageroute.dart';
import 'package:solomonic/widgets/mybutton.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool isChanged=false;
  bool checkBoxValue=false;
  String email="";
  String password="";
  bool emailverfied=false;
  bool showSpinner=false;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  Future<void> loginto()
  async {
    if(emailverfied && email!="" && password!="")
    {
      setState(() {

        showSpinner=true;

      });


      String signupUrl="Appapis/checkuser.php";


      var bodydata={

        "email":email,

        "password":password,
      };
      var url=Uri.parse(baseUrl+signupUrl);
      log(baseUrl+signupUrl);
      var response= await http.post(url,body:bodydata);

      log(response.body.toString());
      setState(() {
        showSpinner=false;
      });
      if(response.statusCode==200)
      {


       if(response.body.toString()!="notfound[]")
         {  var data= json.decode(response.body);
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString("name", data['data'][0]['name']);
           prefs.setString("id",data['data'][0]['id']);
           prefs.setString("email", data['data'][0]['email']);
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                   builder: (BuildContext context) =>mainscreen()

               ));
         }
       else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text("Incorrect email or password"),
         ));
       }

      }


    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter correct values"),
      ));
    }





  }


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kBgColor,
                height: size.height*0.4,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Hero(
                            tag: "logo",
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                              child: SizedBox(
                                  width: 60,
                                  child: Image(image: AssetImage("images/logo.png"),width:50,)),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 5, // Space between underline and text
                                ),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0, // Underline thickness
                                    ))
                                ),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontSize: 15
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),

                              InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, CustomPageRoute( child: SignUp(),num: 0));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 5, // Space between underline and text
                                  ),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0, // Underline thickness
                                      ))
                                  ),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Welcome back,",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                          Text("Sign in to continue",style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: size.height*0.7,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:   [
                          const Text("Email address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 300,
                            child: Stack(
                              children: [
                                TextFormField(
                                 onChanged: (val) {
                                   email=val;
                                   emailverfied=isEmail(val);
                                 }
                                ),

                                Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: isChanged==true ? const Icon(Icons.done,color: kBtnColor1,): const SizedBox()),
                              ],
                            ),
                          ),

                         SizedBox(height: 20),

                      const Text("Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          obscureText: true,
                            onChanged: (val) {
                              password=val;
                            }
                        ),
                      ),


                      const SizedBox(height: 10),
                      Row(children: [
                        Checkbox(
                            value: checkBoxValue,
                            activeColor: kBgColor,
                            onChanged: (val){
                          setState(() {
                            checkBoxValue=!checkBoxValue;
                          });
                        }),
                         const Text("Remember me and keep me logged in",style: TextStyle(fontSize: 12,color: Colors.grey, overflow: TextOverflow.clip,),),
                      ]),
                  const SizedBox(height: 10),
                  MyButton(
                      onPressed:(){
                        loginto();
                      },
                    buttonColor: kBtnColor2,
                    textColor: Colors.white,
                    text: 'Sign in',
                    width: size.width,
                    height: 50.0,
                  ),
                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


