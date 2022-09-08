import 'package:flutter/material.dart';
import 'package:solomonic/constants/colors.dart';
import 'package:solomonic/view/Pages/Bookingscreen.dart';

class carDetails extends StatefulWidget {
 var cardata;


 carDetails(this.cardata);

  @override
  _carDetailsState createState() => _carDetailsState();
}

class _carDetailsState extends State<carDetails> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Scaffold(
      body:SafeArea(
        child:Stack(
          children: [
            Container(
              width:width,
              height:height,
              child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Container(
                    height:height*0.35,
                    width:width,
                    child:Image.network(baseUrl+"img/${widget.cardata.image}",fit:BoxFit.cover,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("${widget.cardata.name}",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:25),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,bottom:15),
                    child: Text("About",style:TextStyle(color:Colors.black,fontWeight:FontWeight.w800,fontSize:20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:00,horizontal:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Booking Status",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,

                          ), ),
                        Text(
                          "${widget.cardata.status}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,

                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:15,horizontal:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Price Per Day",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,

                          ), ),
                        Text(
                          "${widget.cardata.perday}\$ per day",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,

                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0,horizontal:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Price With Driver",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,

                          ), ),
                        Text(
                          "20\$ per day",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,

                          ),
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),

            ),
            Positioned(
                left:10,
                top:10,
                child:GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,color:Colors.white,size:30,))),
            Positioned(bottom:10,
                left:50,
                right:50,

                child:ElevatedButton(
              onPressed:(){
if(widget.cardata.status=="Available")
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>bookingscreen(widget.cardata)));

  }
else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Already Booked"),
  ));
}

              },
              child:Text("Book Now"),
            ))
          ],
        ),
      ),
    );
  }
}
