
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Auth/pssword_updated.dart';

import '../Routes/routes.dart';
import '../Theme/colors.dart';

class CreateNewPassword  extends StatelessWidget {
  const CreateNewPassword ({Key? key}) : super(key: key);

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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
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
          child: RegisterForm(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        decoration:  BoxDecoration(
         color: transparentColor),

        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),


            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right:5),
              child: TextField(

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock,color: Colors.grey,size: 20,),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,size: 20,),
                  focusColor: Colors.grey,
                  contentPadding: EdgeInsets.only(left: 10),
                  label:  Text("Type Password",
                    textAlign: TextAlign.center,
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),),
                    borderSide:
                    BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right:5),
              child: TextField(


                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock,color: Colors.grey,size: 20,),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey,size: 20,),
                  contentPadding: EdgeInsets.only(left: 10),
                  label:  Text("Retype Password",
                    textAlign: TextAlign.center,
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),),
                    borderSide:
                    BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),



            //continue button
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 5,top: 40),
              child:  GestureDetector(
                onTap: (){
                 Navigator .pushNamed(
                      context, PageRoutes.create_username);
                  print("Clicked");
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

