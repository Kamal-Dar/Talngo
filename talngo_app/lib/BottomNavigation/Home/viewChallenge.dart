import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../../Routes/routes.dart';

class View_Challenge extends StatefulWidget {
  const View_Challenge({Key? key}) : super(key: key);

  @override
  State<View_Challenge> createState() => _View_ChallengeState();
}

class _View_ChallengeState extends State<View_Challenge> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: SafeArea(
          child: FadedSlideAnimation(
           child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/p2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/transparent_play.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 60,
                              height:60,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
    
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/p2.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("@Alen",
                                        style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text("24/02/2022",
                                            style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text("2 days ago",
                                            style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
    
    
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text("Category",
                                            style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
    
    
    
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Text("Eating",
                                            style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
    
    
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("Title",
                              style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
    
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("Lemon eating challenge",
                              style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text("Description",
                              style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30,bottom: 10,right: 5),
                          child:
                          Text("Hi, all you have to do is eat a wedge of lemon rocord your(hopfully hilarious) reaction post it online, lets see who gets more votes",
                              style: GoogleFonts.poppins(fontSize: 12,color: Colors.white)),
    
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          child: Padding(
                            padding: EdgeInsets.only(left: 50,right: 50),
                            child: GestureDetector(
                              onTap: (){
    
                                //Navigator.pushNamed(context, PageRoutes.view_challenge);
    
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageRoutes.uploadRandom);
                                },
                                child: Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(child: Text("Proceed",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.bold,textStyle: TextStyle(color:Colors.white)))),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
    
                ),
              ],
            ),
    
            beginOffset: Offset(0, -0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }
}
