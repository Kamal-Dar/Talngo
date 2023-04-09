
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Auth/Login/UI/login_page.dart';

import '../Theme/colors.dart';

class PasswordUpdated  extends StatelessWidget {
  const PasswordUpdated ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: Center(
    
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("Password Updated",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
    
    
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
    
                    ),
                    child: Icon(Icons.check,color: Colors.white,size: 60,),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("Your Password has been Updated ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      )),
                ),
    
                const SizedBox(
                  height: 30,
                ),
    
    
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50,top: 20),
                  child:  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),
                        child: Center(
                            child: Text("Sign In",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle:
                                    TextStyle(color: Colors.white)))),
                      ),
                    ),
                  ),
                ),
    
    
              ],
            ),
    
        ),
      ),
    );
  }
}

