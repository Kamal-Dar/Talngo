import 'package:flutter/material.dart';
import 'package:talngo_app/Theme/colors.dart';

class AllActivities extends StatelessWidget {
  const AllActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
            child: Row(
              children: [
                Text("New",style: TextStyle(color: Colors.white),),
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
                       child: Column(
                                       children: [
                                         Text(
                        "Jimmy Docranto",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         Text(
                        "Liked your video",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         SizedBox(height: 10,),
                                         Row(
                        children: [
                          Text(
                            "2h ago",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "remove",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                                         ),
                                       ],
                                     ),
                     ),
               
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/p2.jpg"),
                    ),
                  ),
                )
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
            child: Row(
              children: [
                Text("Earlier",style: TextStyle(color: Colors.white),),
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
                                         children: [
                                           Text(
                          "Jimmy Docranto",
                          style: TextStyle(color: Colors.white),
                                           ),
                                           Text(
                          "Liked your video",
                          style: TextStyle(color: Colors.white),
                                           ),
                                           Row(
                          children: [
                            Text(
                              "2h ago",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "remove",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                                           ),
                                         ],
                                       ),
                       ),
                     ),
               
                  ],
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/p2.jpg"),
                    ),
                  ),
                )
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
                       child: Column(
                                       children: [
                                         Text(
                        "Jimmy Docranto",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         Text(
                        "Liked your video",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         Row(
                        children: [
                          Text(
                            "2h ago",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "remove",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                                         ),
                                       ],
                                     ),
                     ),
               
                  ],
                ),
               Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/p2.jpg"),
                    ),
                  ),
                )
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
                       child: Column(
                                       children: [
                                         Text(
                        "Jimmy Docranto",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         Text(
                        "Liked your video",
                        style: TextStyle(color: Colors.white),
                                         ),
                                         Row(
                        children: [
                          Text(
                            "2h ago",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "remove",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                                         ),
                                       ],
                                     ),
                     ),
               
                  ],
                ),
               Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/p2.jpg"),
                    ),
                  ),
                )
              ],
            ),
          ),
          
            ],
      ),
    );
  }
}
