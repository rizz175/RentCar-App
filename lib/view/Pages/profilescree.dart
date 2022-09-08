import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../signin_screen.dart';
class profilescreen extends StatefulWidget {
  const profilescreen({Key? key}) : super(key: key);

  @override
  _profilescreenState createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {

String name="";
String email="";
String phone="";
String address="";
  getdata()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      name= prefs.getString('name').toString();
      email= prefs.getString('email').toString();
      phone= prefs.getString('phone')??"";
      address= prefs.getString('address')??"";
    });

  }

@override
  void initState() {

    getdata();
//
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
                Row(
                  children: [
                    Text(
                      "My Profile",
                      style: headingstyle, ),

                    // GestureDetector(
                    //   onTap:(){
                    //     Navigator.pop(context);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Icon(FontAwesomeIcons.userEdit,color: Colors.white,size: 20,),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height:20,),
                CircleAvatar(
backgroundColor: Colors.black87,
                  radius: 60,
                  child:Icon(Icons.perm_identity,size:80,),
                ),
                SizedBox(height:10,),
                Text(
                  "Rizwan",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), ),
                SizedBox(height:30,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,

                        ), ),
                      Text(
                        "$email",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,

                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width:double.infinity,
                  height:1,
                  color:Colors.black12,
                ),
                SizedBox(height:10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,

                        ), ),
                      Text(
                        "$phone",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,

                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width:double.infinity,
                  height:1,
                  color:Colors.black12,
                ),
                SizedBox(height:10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,

                        ), ),
                      Text(
                        "$address",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,

                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width:double.infinity,
                  height:1,
                  color:Colors.white12,
                ),
                SizedBox(height:20,),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      child: Text('Signout'),
                      onPressed: () {


                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                SignIn()),
                                (Route<dynamic> route) => false);
                        },
                      onLongPress: () {
                        print('Long press');
                      },

                    ))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
