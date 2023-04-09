
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Chat/chat_page.dart';

import '../Theme/colors.dart';

class JimmyChat extends StatelessWidget {
  const JimmyChat({super.key});

  @override
  Widget build(BuildContext context) {
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
                                    Text("Block this user they won't be \nable to send you message and\n\t\t\t\t\t\t\t\t\t\t\t\tvisit your profile",textAlign: TextAlign.left,style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                     // Navigator.pushNamed(context, PageRoutes.view_challenge);
                                     },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: Center(child: Text("Cancel",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        GestureDetector(
                                          onTap: (){
                                            // showRejctionDialog(context);
                                          },
                                          child: GestureDetector(
                                            onTap: (){
                  //showRejectDialog(context);
                  print("Clicked");
                },
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20,right: 20),
                                                child: Center(child: Text("Confirm",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
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


    return Container(
       decoration: BoxDecoration(gradient: lGradient),
       child: Scaffold(
        backgroundColor: transparentColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("jimmy",style: TextStyle(color: Colors.white),),
          actions: [
            GestureDetector(
              onTap: (() {
                _settingModalBottomSheet(context);
              }),
              child: Icon(Icons.menu_open),
              )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("today",style: TextStyle(color: Colors.white),),
                  )),
              ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage("assets/images/p2.jpg"),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: (() {
                            showViewDialog(context);
                          }),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5,),
                                child: Row(
                                  children: [
                                    Text("Hi",style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text("1:04 AM",style: TextStyle(color: Colors.white,fontSize: 12),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Container(
                          
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey,
                          ),
                           child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2,right: 5,bottom: 2,),
                                  child: Text("Hi",style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text("1:04 AM",style: TextStyle(color: Colors.white,fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ),
                         SizedBox(width: 5,),
                         CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage("assets/images/p2.jpg"),
                        ),
                        
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.white,),
                    Text("Tap to like",style: TextStyle(color: Colors.white),),
                  ],
                )
            ],
          ),
        ),
       ),
    );
  }
}



void _settingModalBottomSheet(context){
    
     showModalBottomSheet(
                  backgroundColor: Colors.black,
      context: context,
      shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical( 
            top: Radius.circular(25.0),
          ),
        ),
      builder: (BuildContext bc){
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p2.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                shape: BoxShape.circle),
                                            width: 50,
                                            height: 50,
                                            
                                          ),
                              const Center(child: Text("visit profile ",style: TextStyle(color: Colors.white),)),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,))
                            ],
                          ),
                        ),
                        
                          Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Text(
                                                        "Mute notification",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                     
                                                      Icon(Icons.toggle_on,color: Colors.white,size: 50,)

                                                    ],
                                                  ),
                                
                       Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Text(
                                                        "Pin to top",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                     
                                                      Icon(Icons.toggle_on,color: Colors.white,size: 50,)

                                                    ],
                                                  ),
                       Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Text(
                                                        "Repeat",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                     
                                                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,)

                                                    ],
                                                  ),
                                                  SizedBox(height: 20,),
                                                   Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Text(
                                                        "Block",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                     
                                                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 12,)

                                                    ],
                                                  ),
                      
                      ],
                    ),
            ),
                 );
      }
    );
               }