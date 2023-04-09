import 'package:animation_wrappers/animation_wrappers.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Components/profile_page_button.dart';
import 'package:talngo_app/Components/row_item.dart';
import 'package:talngo_app/Components/sliver_app_delegate.dart';
import 'package:talngo_app/Components/tab_grid.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/edit_profile.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/followers.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:talngo_app/BottomNavigation/Explore/explore_page.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/following.dart';

class PlayRandomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UploadRandomBody();
  }
}

class UploadRandomBody extends StatefulWidget {
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<UploadRandomBody> {
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return
      Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Container(
          decoration:  BoxDecoration(
          gradient: lGradient),
          child: Scaffold(
            backgroundColor: transparentColor,
            body: Scaffold(
              backgroundColor: transparentColor,
              appBar: AppBar(
                title: Column(
                  children: [
                    Center(
                        child: Text("Play Random Challenge",
                            style: GoogleFonts.poppins(fontSize: 14))),
        
                  ],
                ),
                actions: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: backgroundColor,
                    ),
                    child: PopupMenuButton(
                      icon: Icon(
                        Icons.grid_view,
                        color: secondaryColor,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      onSelected: (dynamic value) {
                        if (value == 'all') {
                          Navigator.pushNamed(context, PageRoutes.challenge_category);
                        } else if (value == locale?.help) {
                          Navigator.pushNamed(context, PageRoutes.helpPage);
                        } else if (value == locale?.termsOfUse) {
                          Navigator.pushNamed(context, PageRoutes.tncPage);
                        } else if (value == locale?.logout) {
                          Phoenix.rebirth(context);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text("Categories",
                                style: GoogleFonts.poppins(fontSize: 16)),
                            value: 'cat',
                            textStyle: TextStyle(color: secondaryColor),
                          ),
                          PopupMenuItem(
                            child: Text("All",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            value: 'all',
                            textStyle: TextStyle(color: secondaryColor),
                          ),
                          PopupMenuItem(
                            child: Text("Singing",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            value: 'sing',
                            textStyle: TextStyle(color: secondaryColor),
                          ),
                          PopupMenuItem(
                            child: Text("Dancing",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            value: 'dancing',
                            textStyle: TextStyle(color: secondaryColor),
                          ),
                          PopupMenuItem(
                            child: Text("Eating",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            value: 'eating',
                            textStyle: TextStyle(color: secondaryColor),
                          )
                        ];
                      },
                    ),
                  )
                ],
                bottom: PreferredSize(preferredSize: Size.square(2.0),
                  child: Divider(thickness: 1,color: Colors.grey,),),
              ),
              body:
              GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
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
                                            'assets/images/p2.jpg'),
                                        fit: BoxFit.cover,
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
                                                          'assets/images/p2.jpg'),
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
                                                    borderRadius: BorderRadius.circular(10)),
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
                  }),
            ),
          ),
        ));
  }
}
