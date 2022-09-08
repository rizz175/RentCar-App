
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solomonic/Model/carmodel.dart';
import 'package:solomonic/view/Pages/carDetails.dart';
import 'package:solomonic/view/Pages/carslist.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {


  bool showSpinner=true;
  List<carModel>luxurycarlist=[];
  List<carModel>normalcarlisr=[];
  String name="";

getdata()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {

    name= prefs.getString('name').toString();
  });

}
  getluxurycars()
  async {


    var url=Uri.parse(baseUrl+"Appapis/getluxurycars.php");
    var response= await http.get(url);

    log(response.body);


    if(response.body=="notfound[]")
    {


    }
    else{
      var userdata = await json.decode(response.body);
      var listofcars=userdata['data'];
      for(var data in listofcars)
      {

        luxurycarlist.add(carModel.fromJson(data));

      }
      log(luxurycarlist.length.toString());

    }


  }
   getnormalcars()
   async {


     var url=Uri.parse(baseUrl+"Appapis/getnormalcars.php");
     var response= await http.get(url);

     log(response.body);


     if(response.body=="notfound[]")
     {


     }
     else{
       var userdata = await json.decode(response.body);
       var listofcars=userdata['data'];
       for(var data in listofcars)
       {

         normalcarlisr.add(carModel.fromJson(data));

       }
       log(normalcarlisr.length.toString());

     }
     setState(() {
       showSpinner=false;
     });


   }


   @override
  void initState() {
      getdata();
      getluxurycars();
      getnormalcars();
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,

        children: [
          Container(
            width:width,

            decoration:BoxDecoration(
                color:Colors.black,
                borderRadius:BorderRadius.only(bottomRight:Radius.elliptical(100,10),bottomLeft:Radius.elliptical(100,10))),
            height:height*0.2,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:height*0.04,),
                Row(
                  children: [
                    SizedBox(width:10,),
                    Image.asset("images/logo.png",width:50,height:50,),
                    Text("Rent A Car",style: TextStyle(color: Colors.white,fontSize: 15,
                        fontWeight: FontWeight.bold,fontFamily: "cursive"), )
                  ],),
                    Container(
                      margin:EdgeInsets.symmetric(horizontal:14,vertical:2),
                      child: Text("Welcome $name !",style: TextStyle(color: Colors.white,fontSize:22,fontWeight:FontWeight.bold,letterSpacing:1,overflow: TextOverflow.ellipsis
                      ), ),
                    )

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(


              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Normal Cars",style:TextStyle(fontWeight:FontWeight.bold),),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>carslistscreen(normalcarlisr,"Normal Cars")));

                          },
                          child:Icon(Icons.arrow_forward,color:Colors.black54,size:18,),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:5,),
                  
                  Container(

                    height:height*0.3,
                    child: ListView.builder(
                        scrollDirection:Axis.horizontal,
                        itemCount:normalcarlisr.length>4 ?5:normalcarlisr.length,
                        itemBuilder:(context,index)
                    {
                      return InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>carDetails(normalcarlisr[index])));

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width:width*0.35,
                    decoration:BoxDecoration(
                        color:Colors.black12.withOpacity(0.04),
                        borderRadius:BorderRadius.circular(10)
                    ),
                            child:Column(
                              children: [
                                Container(
                                  width:width*0.35,
                                  height:height*0.16,
                                  child:Image.network(baseUrl+"img/${normalcarlisr[index].image}",fit:BoxFit.cover,),
                                ),
                                SizedBox(height:5,),
                                Container(
                                    width:width*0.26,
                                    child: Text("${normalcarlisr[index].name}",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:height*0.018),textAlign:TextAlign.center,overflow:TextOverflow.ellipsis,maxLines:2,),),
                                SizedBox(height:5,),
                                Container(
                                  width:width*0.26,
                                  child: Text("${normalcarlisr[index].perday}\$ Per Day",style:TextStyle(fontSize:height*0.015),textAlign:TextAlign.center,overflow:TextOverflow.ellipsis,maxLines:2,),)
                              ],
                            ),
                          ),
                        ),
                      );

                    }),
                  )

                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child: Container(


              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Luxury Cars",style:TextStyle(fontWeight:FontWeight.bold),),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>carslistscreen(luxurycarlist,"Luxury Cars")));

                          },
                          child:Icon(Icons.arrow_forward,color:Colors.black54,size:18,),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height:5,),

                  Container(

                    height:height*0.28,
                    child: ListView.builder(
                        scrollDirection:Axis.horizontal,
                        itemCount:luxurycarlist.length>4 ?5:luxurycarlist.length,
                        itemBuilder:(context,index)
                        {
                          return GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>carDetails(luxurycarlist[index])));

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width:width*0.35,
                                decoration:BoxDecoration(
                                    color:Colors.black12.withOpacity(0.04),
                                    borderRadius:BorderRadius.circular(10)
                                ),
                                child:Column(
                                  children: [
                                    Container(
                                      width:width*0.35,
                                      height:height*0.15,
                                      child:Image.network(baseUrl+"img/${luxurycarlist[index].image}",fit:BoxFit.cover,),
                                    ),
                                    SizedBox(height:5,),
                                    Container(
                                      width:width*0.26,
                                      child: Text("${luxurycarlist[index].name}",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:height*0.018),textAlign:TextAlign.center,overflow:TextOverflow.ellipsis,maxLines:2,),),
                                    SizedBox(height:5,),
                                    Container(
                                      width:width*0.26,
                                      child: Text("${luxurycarlist[index].perday}\$ Per Day",style:TextStyle(fontSize:height*0.015),textAlign:TextAlign.center,overflow:TextOverflow.ellipsis,maxLines:2,),)
                                  ],
                                ),
                              ),
                            ),
                          );

                        }),
                  )

                ],
              ),
            ),
          )



        ],
      ),
    );
  }
}
