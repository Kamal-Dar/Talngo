import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/BottomNavigation/Home/following_tab.dart';
import 'package:talngo_app/BottomNavigation/Home/home_page.dart';

import '../Routes/routes.dart';

class ThumbTile extends StatelessWidget {
  final String mediaListData;

  ThumbTile(this.mediaListData);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: FadedScaleAnimation(
       child: Container(
          margin: EdgeInsets.only(left: 8.0),
          height: screenWidth /2+100,
          width: screenWidth / 4+80,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child:
            Container(


              decoration: BoxDecoration(
                color: Colors.white12,

                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child:
              Column(
                children: [
                  Container(
                    height: 150,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(
                            mediaListData),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
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
                        width: 35,
                        height:35,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,

                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          mediaListData),
                                      fit: BoxFit.cover,
                                    ),

                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),

                                ),
                                SizedBox(width: 5,),
                                Text("@Username",
                                    style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white))

                              ],
                            ),
                            SizedBox(height: 5,),
                            Text("Lemon Eating Challenge",
                                style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),

                            Text("#eating   #challenge",
                                style: GoogleFonts.poppins(fontSize: 10,color: Colors.white)),

                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: (){

                                Navigator.pushNamed(context, PageRoutes.view_challenge);

                              },
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(child: Text("View Challenge",style: GoogleFonts.poppins(fontSize: 12,textStyle: TextStyle(color:Colors.white)))),
                              ),
                            ),

                          ]

                      ),
                    ),

                  )


                ],

              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FollowingTabPage(
                    videos2 + videos1,
                    imagesInDisc2 + imagesInDisc1,
                    false,
                    variable: 1,
                  ))),
    );
  }
}
