import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Routes/routes.dart';
import '../../../Theme/colors.dart';

class ChallengesNotify extends StatefulWidget {
  const ChallengesNotify({super.key});

  @override
  State<ChallengesNotify> createState() => _ChallengesNotifyState();
}

class _ChallengesNotifyState extends State<ChallengesNotify> {
  late int selectedRadio;
   void showRejectDialog(BuildContext context) {

    showDialog(
      context: context,
      barrierColor: Colors.grey.withOpacity(0.5),
      builder: (context)
        {
          selectedRadio = -1;
          return
            StatefulBuilder(builder:(context,setState)
          {
            return Center(
              child: Container(
                height: 400,
                
                child: SizedBox.expand(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                                child: CircleAvatar(
                                                      radius: 35.0,
                                                      backgroundImage: AssetImage("assets/images/p2.jpg"),
                                                    ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Jimmy rejected your challenge what\ndo you want to do? ",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white))),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                Icon(Icons.info,color: Colors.white,),
                                Text("you can edit the challenge into \nrandom challenge ",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white))),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Theme(
                            data: Theme.of(context).copyWith(
                                   unselectedWidgetColor: Colors.grey,
                                disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 0,
                              groupValue: selectedRadio,
                              title: Text("Edit Challenge",style: GoogleFonts.poppins(fontSize: 14,color: Colors.white)),

                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,

                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.grey,
                                disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadio,
                              title: Text("Delete Challenge",style: GoogleFonts.poppins(fontSize: 14,color: Colors.white)),

                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 5),
                            child: GestureDetector(
                              onTap: (){
                                if(selectedRadio==0)
                                  {
                                    Navigator.pushNamed(context, PageRoutes.uploadRandom);
                                  }
                                else if(selectedRadio==1)
                                  {
                                    //Navigator.pushNamed(context, PageRoutes.uploadRandom);
                                  }

                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(child: Text("Done",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),),

                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:  BoxDecoration(
          gradient: lGradient,
          borderRadius: BorderRadius.circular(10)),
              ),
            );
          });
        }
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void showViewDialog(BuildContext context) {

    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context)
        {
          return
            StatefulBuilder(builder:(context,setState)
            {
              return Center(
                child: Container(
                  height: 300,
                  child: SizedBox.expand(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
          gradient: lGradient),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                                      radius: 35.0,
                                                      backgroundImage: AssetImage("assets/images/p2.jpg"),
                                                    ),
                              ),
                      
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  children: [
                                    Text("Jimmy send you a challenge what do\nyou want to do?",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  children: [
                                    Icon(Icons.info,color: Colors.white,),
                                    Text("accept the challenge with in 3 daysafter\nthat it will automatically gets rejectd",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 12,textStyle: TextStyle(color:Colors.white))),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, PageRoutes.view_challenge);
                                     },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: Center(child: Text("View",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                          onTap: (){
                                            // showRejctionDialog(context);
                                          },
                                          child: GestureDetector(
                                            onTap: (){
                  showRejectDialog(context);
                  print("Clicked");
                },
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20,right: 20),
                                                child: Center(child: Text("Reject",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                    
                                ],
                              ),
                    
                    
                    
                    
                            ],
                          ),
                        ),
                      ),
                    ),),

                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(20)),
                ),
              );
            });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10,left: 10),
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
            
            child: GestureDetector(
               onTap: (){
                  showViewDialog(context);
                  print("viw click");
                },
               
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
           Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/images/p2.jpg"),
                      ),
                       Column(
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
                 
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/p2.jpg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 20,top:10,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/images/p2.jpg"),
                      ),
                       Column(
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
                 
                    ],
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/p2.jpg"),
                      ),
                    ),
                  )
                ],
              ),
            ),
             Container(
              margin: EdgeInsets.only(bottom: 20),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              "2days ago",
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
                        SizedBox(height: 20,),
                         Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eat lemon you\nwon the challenge",
                        style: TextStyle(color: Colors.white),
                      ),
                     
                    ],
                  ),
                  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eat lemon you\nwon the challenge",
                        style: TextStyle(color: Colors.white),
                      ),
                     
                    ],
                  ),
                  SizedBox(height: 20,)
                      ],
                    ),
             ),
              ],
        ),
      ),
    );
  
  }
}