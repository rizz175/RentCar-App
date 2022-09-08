import 'package:flutter/material.dart';

import '../../Model/carmodel.dart';
import '../../constants/colors.dart';
import 'carDetails.dart';
class carslistscreen extends StatefulWidget {
var carlist;
var cartype;
carslistscreen(this.carlist,this.cartype);

  @override
  _carslistscreenState createState() => _carslistscreenState();


}

class _carslistscreenState extends State<carslistscreen> {

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
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back,size: 25,),
                      ),
                    ),
                    Text(
                      "${widget.cartype}",
                      style: headingstyle, ),


                  ],
                ),
                SizedBox(height:10,),

                ListView.builder(

                    itemCount:widget.carlist.length,
                    shrinkWrap:true,
                    itemBuilder: (context,index)
                {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),

                      decoration:BoxDecoration(
                            color:Colors.black12.withOpacity(0.04),
                            borderRadius:BorderRadius.circular(10)
                        ),
                      child:ListTile(
onTap:(){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>carDetails(widget.carlist[index])));

},
                        leading:Container(
                          width:100,
                          height:100,

                          child:Image.network(baseUrl+"img/${widget.carlist[index].image}",fit:BoxFit.cover,),
                        ),
                        title:Text("${widget.carlist[index].name}",overflow:TextOverflow.ellipsis,),
                        subtitle:Text("${widget.carlist[index].perday}\$ per day"),



                      ),
                    ),
                  );

                })


              ],
            ),
          ),
        ),
      ),
    );
  }
}
