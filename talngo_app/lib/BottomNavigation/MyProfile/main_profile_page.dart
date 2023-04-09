import 'dart:convert';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Auth/Login/UI/login_page.dart';

import '../../Routes/routes.dart';
import '../../Theme/colors.dart';
import 'package:http/http.dart' as http;

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key}) : super(key: key);

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  late String accessToken = "";
  late String username = "";
  String session = "";

  @override
  void initState() {
    super.initState();
    getCredentials();
  }
   Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session', "logout");
   
  }

 

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      session = prefs.getString('session') ?? '';
      accessToken = prefs.getString('access_token') ?? '';
       username = prefs.getString('username') ?? '';
    });
  }

  logout() async {
    SmartDialog.showLoading();
    // open a bytestream
   
    try {
      final response = await http.post(
        Uri.parse("https://talngo.com/api/logout"),
        headers: {"Authorization": "Bearer "+accessToken},
      );

      var res = jsonDecode(response.body);

      print("Logout Response is ==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        saveCredentials();
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.yellow);
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginBody();
          }), (route) => false);
      } else {
        SmartDialog.dismiss();
        Fluttertoast.showToast(
            msg: res["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (e) {
      SmartDialog.dismiss();
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.yellow);
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Container(
          decoration: BoxDecoration(gradient: lGradient),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                        onTap: (){
                 Navigator .pushNamed(
                      context, PageRoutes.my_ProfilePage);
                          },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/p3.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle),
                            width: 35,
                            height: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("@ $username",
                              style: GoogleFonts.poppins(fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.square(2.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              body: FadedSlideAnimation(
               child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.edit_profile_page);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Edit Profile",
                                        style:
                                            GoogleFonts.poppins(fontSize: 13)),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Manage Account",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.invite_friend_page);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Invite Friends",
                                        style:
                                            GoogleFonts.poppins(fontSize: 13)),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.treasure_page);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Treasure Box",
                                        style:
                                            GoogleFonts.poppins(fontSize: 13)),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("What is Talngo?",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("How Talngo Works",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Privacy Policy",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Terms & Conditions",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Assistance",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      logout();
                                      // Navigator.pushNamed(
                                      //     context, PageRoutes.bottomNavigation);
                                    },
                                    child: Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Center(
                                            child: Text("LOG OUT",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                beginOffset: Offset(0, 0.3),
                endOffset: Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
              ),
            ),
          ),
        ));
  }
}
