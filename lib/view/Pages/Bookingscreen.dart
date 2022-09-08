import 'package:flutter/material.dart';
import 'package:solomonic/view/Pages/verificationScreen.dart';

import '../../constants/colors.dart';
import 'carDetails.dart';
class bookingscreen extends StatefulWidget {
  bookingscreen(this.cartype);
  var cartype;
  @override
  _bookingscreenState createState() => _bookingscreenState();


}

class _bookingscreenState extends State<bookingscreen> {

  TextEditingController carname=TextEditingController();
  TextEditingController validdate=TextEditingController();

  String days="";
  bool driver=false;
  int total=0;
  @override
  void initState() {
    // TODO: implement initState

    carname.text=widget.cartype.name;
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Car Booking ",
                      style: headingstyle, ),


                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:10,),
                      Text(
                        "Car Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.black12.withOpacity(0.05)),
                        child: TextField(
                          controller: carname,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white24,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Days to Book",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.black12.withOpacity(0.05)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: days == ""
                                ? Padding(
                              padding: const EdgeInsets.only(left: 11.0),
                              child: Text('Days '),
                            )
                                : Padding(
                              padding: const EdgeInsets.only(left: 11.0),
                              child: Text(
                                days,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black),
                            items: ["1","2","3","4","5","6","7","8","9","10","11"].map(
                                  (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString()),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              days = val.toString();
                              setState(() {

                                  int price=int.parse(widget.cartype.perday);
                                  int t=int.parse(days)*price;
                                  total=total+t;

                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Booking Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.black12.withOpacity(0.05)),
                        child: TextField(
                          controller: validdate,
                          onTap: () async {
                            DateTime selectedDate = DateTime.now();

                            final DateTime? selected = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2025),
                            );
                            if (selected != null && selected != selectedDate)
                              setState(() {
                                selectedDate = selected;
                                validdate.text =
                                    selectedDate.toString().substring(0, 10);
                              });
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white24,
                              border: InputBorder.none,
                              hintText: validdate.text,
                              suffixIcon: Icon(Icons.calendar_today_outlined)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 0, right: 00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Car with Driver\n(Extra 20\$ per Day)',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Material(
                              child: Checkbox(
                                value: driver,
                                onChanged: (value) {
                                  setState(() {
                                    driver = value ?? false;
                                    if (driver) {
                                      total=total+20;
                                    } else {
                                      total=total-20;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:20,
                      ),
                      Container(
                        width:double.infinity,
                        height:1,
                        color:Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              "Total Price",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,fontWeight:FontWeight.w800

                              ), ),
                            Text(
                              "$total\$",
                              style: TextStyle(
                                fontSize: 19,
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
SizedBox(height:30,),
                      Container(
                        width:MediaQuery.of(context).size.width*08,
                        child:ElevatedButton(
                          onPressed:(){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>verificationScreen(widget.cartype,total.toString(),validdate.text,days)));

                          },
                          child:Text("Next"),
                        ),
                      )
                    ],
                  ),
                )





              ],
            ),
          ),
        ),
      ),
    );
  }
}
