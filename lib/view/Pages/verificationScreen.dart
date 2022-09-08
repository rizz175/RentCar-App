import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../mainmenu.dart';
import 'carDetails.dart';
class verificationScreen extends StatefulWidget {


  var cardata;
  String total;
  String bookingdate;
  String days;

  verificationScreen(this.cardata, this.total, this.bookingdate, this.days);

  @override
  _verificationScreenState createState() => _verificationScreenState();


}

class _verificationScreenState extends State<verificationScreen> {

  TextEditingController mobile=TextEditingController();
  TextEditingController NationalID=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController fullname=TextEditingController();

  TextEditingController validdate=TextEditingController();
  bool showSpinner=false;

  String days="";
  bool driver=false;
  File FrontImage = File('your initial file');
  String frontimage = "";
  File BackImage = File('your initial file');
  String backimage = "";
  String email="";
  getdata()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      email= prefs.getString('email').toString();
    });

  }
  @override
  void initState() {
    // TODO: implement initState

log(widget.bookingdate+"__"+widget.total);
getdata();
    super.initState();
  }
  Future<void> loadAssets2() async {
    ImagePicker imagePicker = ImagePicker();
    var selected = await imagePicker.getImage(source: ImageSource.camera);
    print(selected!.path.toString());

    final bytes = File(selected.path).readAsBytesSync();

    setState(() {
      frontimage = selected.path;
      FrontImage = File(selected.path);
    });
  }
  Future<void> loadAssets1() async {
    ImagePicker imagePicker = ImagePicker();
    var selected = await imagePicker.getImage(source: ImageSource.camera);
    print(selected!.path.toString());

    final bytes = File(selected.path).readAsBytesSync();

    setState(() {
      backimage = selected.path;
      BackImage = File(selected.path);
    });
  }
  Future<void> uploaddata(BuildContext context) async {
    print("calll");
setState(() {
  showSpinner=true;
});
    var url =
    Uri.parse(baseUrl+"Appapis/addbooking.php");

    var request = http.MultipartRequest('POST', url);

    request.files.add
      (
      await http.MultipartFile.fromPath('Image', "${frontimage}"),
    );
    request.files.add
      (
      await http.MultipartFile.fromPath('Image2', "${backimage}"),
    );
    request.fields.addAll( {
      'name':fullname.text,
      'mobile':mobile.text,
      'carname': widget.cardata.name,
      'carnumber':widget.cardata.number.toString(),
      'carmodel':widget.cardata.model,
      'days':widget.days,
      'address':address.text,
      'idcard':NationalID.text,
      'bookingdate':widget.bookingdate,
      'totalprice':widget.total,
      'email':email

    });
    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    log(body.toString());
    setState(() {
      showSpinner=false;
    });
if(body.toString()=="Success")
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Details are submitted"),
    ));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                mainscreen()),
            (Route<dynamic> route) => false);
  }
else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Check Credentials"),
  ));
}
  }
  // void bookingINTOdatabase()
  // {
  //   var request = new http.MultipartRequest("POST",Uri.parse(baseUrl+"Appapis/booking.php"));
  //   request.fields['user'] = 'someone@somewhere.com';
  //   request.files.add(http.MultipartFile.fromPath(
  //     contentType: new MediaType('application', 'x-tar'),
  //   ));
  //   request.send().then((response) {
  //     if (response.statusCode == 200) print("Uploaded!");
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall:showSpinner,
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
                        "Customer info ",
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
                          "Full Name",
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
                            controller:fullname,
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
                          "National ID",
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
                            controller:NationalID,
                            keyboardType:TextInputType.number,

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
                          "Mobile No",
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
                            controller:mobile,
                            keyboardType:TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white24,
                              border: InputBorder.none,
                            ),
                          ),
                        ),   SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address",
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
                            controller:address,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white24,
                              border: InputBorder.none,
                            ),
                          ),
                        ),   SizedBox(
                          height: 20,
                        ),

                        Text(
                          "FrontSide ID Card Image",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: loadAssets2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                                color: Colors.black12),
                            child: frontimage == ""
                                ? Icon(Icons.add)
                                : Image.file(
                              FrontImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "BackSide ID Card Image",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: loadAssets1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                                color: Colors.black12),
                            child: backimage == ""
                                ? Icon(Icons.add)
                                : Image.file(
                              BackImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height:30,),
                        Container(
                          width:MediaQuery.of(context).size.width*08,
                          child:ElevatedButton(
                            onPressed:(){
if(fullname.text.isNotEmpty&& mobile.text.isNotEmpty && NationalID.text.isNotEmpty&& address.text.isNotEmpty&& backimage!="" && frontimage!="")
          {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>verificationScreen()));
uploaddata(context);
          }
else{
  print("empty");
}



                            },
                            child:Text("Submit"),
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
      ),
    );
  }
}
