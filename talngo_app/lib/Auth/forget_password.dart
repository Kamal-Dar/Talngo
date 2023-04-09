import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Auth/recover_password_page.dart';
import 'package:http/http.dart' as http;
import '../Theme/colors.dart';
import 'Verification/Otp/reset_otp.dart';
import 'create_new_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword ({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  var _isLoading = false;

  TextEditingController _emailController = TextEditingController();

  void forgetApi(String email) async {
    
    if (!_key.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Kindly Provide a valid email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
          setState(() => _isLoading = false);
      
    } else {
       SmartDialog.showLoading();
      try {
        final response = await http
            .post(Uri.parse("https://talngo.com/api/auth/forgetPassword"), body: {
          'email': email.trim(),
          
        });
       
        var res = jsonDecode(response.body);
        print("forget Response==> ${response.body}");

        if (res["success"] == true) {
         SmartDialog.dismiss();
          Fluttertoast.showToast(
              msg: res["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.yellow);
           

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ResetOTPScreen(email: email, );
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
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Text("Forget Password", style: GoogleFonts.poppins(fontSize: 14)),
    
              ],
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
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: transparentColor,
                border: Border.all(color: transparentColor),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 50),
                child: FadedSlideAnimation(
                 child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
              
              
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
              
                          ),
                          child: Icon(Icons.lock_reset,color: Colors.white,size: 60,),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text("Forget Password ?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Enter your Registered Email to recover your password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          )),
              
                      const SizedBox(
                        height: 20,
                      ),
                       Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "Enter Email Or Username",
                            textAlign: TextAlign.center,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child:  GestureDetector(
                          
                          onTap: _isLoading ? null : _onSubmit,
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RecorvedPassword()));
                          
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            
                              child: Center(
                                  child: Text("Next",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          textStyle:
                                          TextStyle(color: Colors.white)))),
                            ),
                          ),
                        ),
                      
              
                    ],
                  ),
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
   void _onSubmit() {
    setState(() => _isLoading = true);

    forgetApi(
        _emailController.text.toString());
  }
}



