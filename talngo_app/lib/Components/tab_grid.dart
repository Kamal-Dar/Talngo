import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/BottomNavigation/Home/following_tab.dart';
import 'package:talngo_app/BottomNavigation/Home/home_page.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../Routes/routes.dart';

class Grid {
  Grid(this.imgUrl, this.views);
  String imgUrl;
  String views;
}

class TabGrid extends StatelessWidget {
  final IconData? icon;
  final List? list;
  final Function? onTap;
  final IconData? viewIcon;
  final String? views;

  TabGrid(this.list, {this.icon, this.onTap, this.viewIcon, this.views});

  @override
  Widget build(BuildContext context) {
    return
      GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: list!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowingTabPage(
                        videos1, imagesInDisc1, false,
                        variable: 1))),
            child: FadedScaleAnimation(
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
                          height: 100,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(
                                  list![index]),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Center(
                            child:
                            Container(
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
                                                list![index]),
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
          );
        });
  }
}
