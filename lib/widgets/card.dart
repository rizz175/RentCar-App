import 'package:flutter/material.dart';
import 'package:solomonic/constants/colors.dart';

import 'mybutton.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.name,
    required this.title,
    required this.location,
  required this.price,
  required this.onHireTap,
  required this.onProfileTap,
  required this.rating,
  required this.img,
  }) : super(key: key);

  final VoidCallback onHireTap;
  final VoidCallback onProfileTap;
  final String name;
  final String title;
  final String rating;
  final String location;
  final String price;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 165,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(image: AssetImage(img),fit: BoxFit.cover,)),
                    ),
                    Positioned(
                        bottom: -8,
                        right: -8,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white,width: 2),
                            ),
                            child: const Icon(Icons.circle,color: Colors.green,size: 12)))
                  ],
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28,left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(name,style: const TextStyle(overflow: TextOverflow.clip,fontWeight: FontWeight.bold,fontSize: 15),),
                const SizedBox(height: 2,),
                 Text(title,style: const TextStyle(overflow: TextOverflow.clip,color: Colors.grey),),
                const SizedBox(height: 2,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children:   [
                      const Icon(Icons.star,color: Color(0xffFFD700),size: 15,),
                      Text(rating,style: const TextStyle(fontWeight: FontWeight.bold),)
                    ],),
                    const SizedBox(width: 10),
                    Row(children:   [
                      const Icon(Icons.location_on,color: Colors.grey,size: 15,),
                      Text(location,style: const TextStyle(color: Colors.grey),)
                    ],),
                    const SizedBox(width: 25),
                    Row(children:   [
                      Text("\$"+price,style: const TextStyle(fontWeight: FontWeight.bold),),
                      const Text("/hr",style: TextStyle(color: Colors.grey),)
                    ],),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(onPressed: onHireTap, text: "HIRE ME", textColor: Colors.white, buttonColor: kBtnColor2, height: 35,width: 100.0,),
                    const SizedBox(width: 20),
                    MyButton(onPressed: onProfileTap, text: "Profile", textColor:  kBtnColor2, buttonColor: Colors.white, height: 35,width: 100.0,),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

