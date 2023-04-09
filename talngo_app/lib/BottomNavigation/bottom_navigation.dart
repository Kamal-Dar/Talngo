import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/BottomNavigation/Explore/explore_page.dart';
import 'package:talngo_app/BottomNavigation/Home/home_page.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/my_profile_page.dart';
import 'package:talngo_app/BottomNavigation/notifications/notify.dart';
import 'package:talngo_app/BottomNavigation/thumbs_up/thumbs-up_page.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:talngo_app/Theme/style.dart';
import '../Auth/Login/UI/login_page.dart';
import 'MyProfile/main_profile_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    ThumbsUp(),
    //ExplorePage(),
    Container(),
    Notify(),
    MainProfilePage(),
  ];

  void onTap(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, PageRoutes.addVideoPage);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_home.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_homeactive.png')),
        label: locale.home,
      ),
      // BottomNavigationBarItem(
      //   icon: ImageIcon(AssetImage('assets/icons/ic_explore.png')),
      //   activeIcon: ImageIcon(AssetImage('assets/icons/ic_exploreactive.png')),
      //   label: locale.explore,
      // ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/thumbs_up.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/thumbs_up.png')),
        label: "Thumbpy",
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          decoration: BoxDecoration(
            borderRadius: radius,
          ),
          child: Image.asset(
            //        <-- Image
            'assets/images/logo2.png',
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
        label: 'Create',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_notification.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/icons/ic_notificationactive.png')),
        label: locale.notification,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_profile.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_profileactive.png')),
        label: locale.profile,
      ),
    ];
    return WillPopScope(
      onWillPop: () =>
          _onBackPressed(context), // this is use to keep the app in background
      child: Container(
        decoration: BoxDecoration(gradient: lGradient),
        child: Scaffold(
          backgroundColor: transparentColor,
          body: Stack(
            children: <Widget>[
              _children[_currentIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 22.0,
                  selectedItemColor: secondaryColor,
                  selectedFontSize: 12,
                  unselectedFontSize: 10,
                  unselectedItemColor: secondaryColor,
                  items: _bottomBarItems,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(context) async {
    return showCustomDialog(context);
  }

  showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Container(
                height: 200,
                child: SizedBox.expand(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: lGradient),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text("Alert! ",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Center(
                                  child: Text("Are you sure you want to exit... ",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          textStyle:
                                              TextStyle(color: Colors.white))),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Center(
                                            child: Text("No",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      if (Platform.isAndroid) {
                                        SystemNavigator.pop();
                                      } else if (Platform.isIOS) {
                                        exit(0);
                                      }
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Center(
                                            child: Text("YES",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                
              ),
            );
          });
        });
  }
}
