import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';
class bookingcarlist extends StatefulWidget {
  const bookingcarlist({Key? key}) : super(key: key);

  @override
  _bookingcarlistState createState() => _bookingcarlistState();
}

class _bookingcarlistState extends State<bookingcarlist> {

  List<Map<String,dynamic>>Bookinglist=[];

  getbookinglist()
  async {


    var url=Uri.parse(baseUrl+"Appapis/getbookings.php");
    var response= await http.post(url,body:{'email':email});

    log(response.body);


    if(response.body=="notfound[]")
    {


    }
    else{
      var userdata = await json.decode(response.body);
      var listofcars=userdata['data'];
      for(var data in listofcars)
      {

        setState(() {
          Bookinglist.add(data);
        });


      }
      log(Bookinglist.length.toString());

    }


  }
  String email="";
  getdata()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      email= prefs.getString('email').toString();
    });

    getbookinglist();

  }
  @override
  void initState() {
    // TODO: implement initState

    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                Row(
                  children: [

                    Text(
                      "My Bookings",
                      style: headingstyle, ),


                  ],
                ),
                SizedBox(height:10,),
                ListView.builder(
                    itemCount: Bookinglist.length,
                    shrinkWrap: true,
                    physics:NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration:BoxDecoration(
                            color:Colors.black12.withOpacity(0.04),
                            borderRadius:BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 0, vertical: 6),

                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width:100,
                                      child: Text("Car Name:  ",
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold),)),

                                  Text(Bookinglist[index]['carname']
                                      .toString(),
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis),

                                ],
                              )
                              , SizedBox(height: 5,),
                              Row(
                                children: [

                                  Container(
                                      width: 100,
                                      child: Text("Days:  ",
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold),)),
                                  Text(
                                      Bookinglist[index]['days'],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis),

                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [

                                  Container(
                                      width: 100,
                                      child: Text("Total Bill:  ",
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold),)),
                                  Text(Bookinglist[index]['totalprice'],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis),

                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [

                                  Container(
                                      width:100,
                                      child: Text("Status:  ",
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight
                                                .bold),)),
                                  Text(Bookinglist[index]['status']
                                      .toString(),
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,),

                                ],
                              ),

                              SizedBox(height: 5,),

                            ],

                          ),
                        ),

                      );
                    })
                // ListView.builder(
                //
                //     itemCount:widget.carlist.length,
                //     shrinkWrap:true,
                //     itemBuilder: (context,index)
                //     {
                //       return Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:10),
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(vertical: 5.0),
                //
                //           decoration:BoxDecoration(
                //               color:Colors.black12.withOpacity(0.04),
                //               borderRadius:BorderRadius.circular(10)
                //           ),
                //           child:ListTile(
                //             onTap:(){
                //               Navigator.push(context, MaterialPageRoute(builder: (context)=>carDetails(widget.carlist[index])));
                //
                //             },
                //             leading:Container(
                //               width:100,
                //               height:100,
                //
                //               child:Image.network(baseUrl+"img/${widget.carlist[index].image}",fit:BoxFit.cover,),
                //             ),
                //             title:Text("${widget.carlist[index].name}",overflow:TextOverflow.ellipsis,),
                //             subtitle:Text("${widget.carlist[index].perday}\$ per day"),
                //
                //
                //
                //           ),
                //         ),
                //       );
                //
                //     })


              ],
            ),
          ),
        ),
      ),
    );
  }
}
