
import 'dart:convert';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Auth/pssword_updated.dart';

import '../Routes/routes.dart';
import '../Theme/colors.dart';
import 'package:http/http.dart' as http;

class RecorvedPassword  extends StatelessWidget {
  final String email;
  
  const RecorvedPassword ({Key? key, required this.email, }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
    
                Text("Create Password", style: GoogleFonts.poppins(fontSize: 14)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.info_outline,
                        size: 22,
                      ),
                    ),
                  ),
                ),
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
    
        //this column contains 3 textFields and a bottom bar
        body: FadedSlideAnimation(
         child: RegisterForm(email: email),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}


class RegisterForm extends StatefulWidget {
  final String email;
  const RegisterForm ({Key? key, required this.email, }) : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
   bool _isObscure = true;
   bool isObscure = true;
  var _isLoading = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("email for this is"+widget.email);
  }

   void resetPassword(email,pasword) async {
    try {
      final response = await http
          .post(Uri.parse("https://talngo.com/api/auth/reset-Password"), body: {
        
        'email': email,
        'password': pasword,
      });
      
      print("Email: " + email);
      print("pasword: " + pasword);
     
      //print("Role: " + role);

      var res = jsonDecode(response.body);
      print("Revever password Response==> ${response.body}");
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
            return PasswordUpdated();
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
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
      print("error is here" + e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: transparentColor,
          border: Border.all(color: transparentColor),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),

        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 30,),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,

                ),
                child: Icon(Icons.receipt,color: Colors.white,size: 60,),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 0,right: 0),
                child: Text("Your identity has been verified\n set your new password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
           Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Enter a strong password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "New Password",
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

      SizedBox(
              height: 20,
            ),
           Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Enter a strong password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(!isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "Confirm Password",
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

         

            //continue button
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5,top: 40),
              child:  GestureDetector(
                onTap: (){
                  print("email is_____"+widget.email);
                  resetPassword(widget.email,passwordController.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PasswordUpdated()));
                  // print("Clicked");
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 0),
                    child: Center(
                        child: Text("Next",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                textStyle:
                                TextStyle(color: Colors.white)))),
                  ),
                ),
              ),

            ),

            const SizedBox(
              height: 20,
            ),


          ],
        ),
      ),
    );
  }
}

