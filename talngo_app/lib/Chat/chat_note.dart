
import 'package:flutter/material.dart';

import '../Routes/routes.dart';
import '../Theme/colors.dart';

class ChatNote extends StatelessWidget {
  const ChatNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        appBar: AppBar(
          backgroundColor: transparentColor,
          centerTitle: true,
          title: Text("Direct Message",style: TextStyle(color: Colors.white),),
          actions: [
            Icon(Icons.add_circle_outlined,color: Colors.white,)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
               Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    print("Chat Clicked...");
                        Navigator.pushNamed(
                                  context, PageRoutes.jimmy_chat_page);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage("assets/images/p2.jpg"),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(left: 10),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                            "Jimmy Docranto",
                            style: TextStyle(color: Colors.white),
                                             ),
                                             Text(
                            "okay",
                            style: TextStyle(color: Colors.white),
                                             ),
                                            ],
                                         ),
                         ),
                       ),
                               
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text("2 days ago",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(child: Text("2",style: TextStyle(color: Colors.white),)),
                    ),
                  ],
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/images/p2.jpg"),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(left: 10),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 10),
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                          "Jimmy Docranto",
                          style: TextStyle(color: Colors.white),
                                           ),
                                           Text(
                          "okay",
                          style: TextStyle(color: Colors.white),
                                           ),
                                           ],
                                       ),
                       ),
                     ),
               
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text("2 days ago",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(child: Text("2",style: TextStyle(color: Colors.white),)),
                    ),
                  ],
                ),
              ],
            ),
          ),
           
            ],
          ),
        ),
      ),
      );
  }
}