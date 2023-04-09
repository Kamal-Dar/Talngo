import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../Auth/Login/UI/login_page.dart';
import '../BottomNavigation/bottom_navigation.dart';
import 'interest_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String session= "";


  @override
  void initState() {
    super.initState();
    getCredentials();
   
  }
 void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      session = prefs.getString('session') ?? '';
    });
   
     Timer(
        Duration(seconds: 3),
          (){
            if(session=="login")
            {
               print("session is ....."+session);
               Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNavigation()));
            }
            else{
              Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginBody()));
               print("else is ....."+session);
            }
        // //userPreferences.isLoggedIn? 
        //  //:
            }

       // () => 
        //userPreferences.isLoggedIn? 
         // BottomNavigation():
          // LoginBody()
          );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/icon.png'))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Pakistan Got Talent",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 3,
              ),
              Center(
                child: Text("By AGT & Talngo",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal)),
              ),
              SizedBox(
                height: 30,
              ),
              Text("This is the moment show ",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
              SizedBox(
                height: 5,
              ),
              Text("your talent",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
