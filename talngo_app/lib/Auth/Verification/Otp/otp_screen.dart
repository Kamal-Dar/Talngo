import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Screens/interest_page.dart';
import '../../../Theme/colors.dart';
import '../../Login/UI/login_page.dart';

class OTPScreen extends StatefulWidget {
  final String verId;
  final String userName;
  final String fullName;
  final String email;
  final String phone;
  final String city;
  final String area;
  final String password;
  final String confirmpassword;

  const OTPScreen(
      {super.key,
      required this.verId,
      required this.userName,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.city,
      required this.area,
      required this.password,
      required this.confirmpassword});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late String phoneNumber;
  late String otp, authStatus = "";

  Future<void> signIn(String otp) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verId, smsCode: otp);
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Fluttertoast.showToast(
          msg: "Your Phone No is successfully verified",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InterestPage(
                    userName: widget.userName,
                    fullName: widget.fullName,
                    email: widget.email,
                    city: widget.city,
                    area: widget.area,
                    password: widget.password,
                    confirmpassword: widget.confirmpassword,
                    phone: widget.phone,
                  )));
      print('signed in with phone number successful: user -> $user');
      SmartDialog.dismiss();
    }).catchError((onError) {
      SmartDialog.dismiss();

      Fluttertoast.showToast(
          msg: "Invalid OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);

      print('Error ->$onError');
    });

    //PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verId, smsCode: otp);

    // Sign the user in (or link) with the credential
    // await auth.signInWithCredential(credential);
    // var verification=await FirebaseAuth.instance
    //     .signInWithCredential(PhoneAuthProvider.credential(
    //   verificationId: widget.verId,
    //   smsCode: otp,

    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
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
                Text("OTP", style: GoogleFonts.poppins(fontSize: 14)),
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
        body: Container(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Verication Code",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "We texted you a code\nplease enter it below",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              OtpTextField(
                textStyle: TextStyle(color: Colors.white),
                numberOfFields: 6,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  otp = verificationCode;

                  // Fluttertoast.showToast(
                  //     msg: "OTP Verified",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.red,
                  //     textColor: Colors.yellow);

                  // showDialog(
                  //     context: context,
                  //     builder: (context){
                  //     return AlertDialog(
                  //         title: Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //     );
                  //     }
                  // );
                }, // end onSubmit
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Text(
                      "This helps us verify every user in our markete place",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                        child: Text(
                      "Did't get code ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 200),
                    child: ElevatedButton(
                      onPressed: () {
                        if (otp.length == 6) {
                          SmartDialog.showLoading();
                          signIn(otp);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Enter Valid OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.yellow);
                        }
                      },
                      child: Text("Confirm"),
                    )),
              ),
            ]),
          ),
        ),
        backgroundColor: transparentColor,
      ),
    );
  }
}
