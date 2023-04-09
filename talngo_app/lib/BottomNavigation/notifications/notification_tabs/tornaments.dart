import 'package:flutter/material.dart';

import '../../../Theme/colors.dart';

class TornamentScreen extends StatelessWidget {
  const TornamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
          gradient: lGradient),
          child: Scaffold(
            backgroundColor: transparentColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 20),
                    child: Text("New",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("MJ sing Tournament",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            Text("You joined the tournament",style: TextStyle(color: Colors.white,),),
                            SizedBox(height: 10,),
                            Row(
                             
                              children: [
                                Text("2h",style: TextStyle(color: Colors.white,),),
                                 SizedBox(width: 30,),
                                Text("Remove",style: TextStyle(color: Colors.blue,),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage("assets/images/treasure.png")
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Earlier",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("MJ sing Tournament",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            Text("You joined the tournament",style: TextStyle(color: Colors.white,),),
                            SizedBox(height: 10,),
                            Row(
                             
                              children: [
                                Text("2h",style: TextStyle(color: Colors.white,),),
                                 SizedBox(width: 30,),
                                Text("Remove",style: TextStyle(color: Colors.blue,),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage("assets/images/treasure.png")
                          )
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
    );
  }
}