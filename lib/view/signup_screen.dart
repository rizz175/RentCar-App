import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/signin_screen.dart';
import 'package:solomonic/widgets/custom_pageroute.dart';
import 'package:solomonic/widgets/mybutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isChanged=false;
  bool showSpinner=false;
  bool checkBoxValue=false;
  String fullname="";
  String email="";
  bool emailverfied=false;
  String password="";
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  Future<void> registeraccount()
  async {
    if(fullname!="" && emailverfied && email!="" && password!="")
      {
        setState(() {

          showSpinner=true;

        });


        String signupUrl="Appapis/registeruser.php";


          var bodydata={
             "fullname":fullname,
             "email":email,
             "password":password,
          };
          var url=Uri.parse(baseUrl+signupUrl);
          log(baseUrl+signupUrl);
          var response= await http.post(url,body:bodydata);

          log(response.body.toString());
          if(response.statusCode==200)
          {

             if(response.body=="Success")
{

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>SignIn()

                ));
          }
             else{

               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 content: Text("Enter correct values"),
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
        inAsyncCall: showSpinner,

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
                              InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, CustomPageRoute( child: SignIn(),num: 1));
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
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),

                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 5, // Space between underline and text
                                ),
                                decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: Colors.white,
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
                          Text("Hey, get on board",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                          Text("Sign up to continue",style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: size.height*0.73,
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
                      const Text("Full Name",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          onChanged:(v){
                            fullname=v;
                          },

                        ),
                      ),
                      SizedBox(height: 20),
                      const Text("Email address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 300,
                        child: Stack(
                          children: [
                            TextFormField(
                              onChanged:(v){
                                email=v;
                                emailverfied=isEmail(email);
                              },
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
                          onChanged:(v){
                            password=v;
                          },
                          obscureText: true,
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
                        const SizedBox(
                          width: 250,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'By signing up you agree to our ',style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                  text: 'conditions',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' and ',style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                  text: 'privacy policy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(height: 10),
                      MyButton(
                        onPressed:(){

                          registeraccount();
                        },
                        buttonColor: kBtnColor2,
                        textColor: Colors.white,
                        text: 'Sign up',
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
