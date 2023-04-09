import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Auth/login_navigator.dart';
import 'package:talngo_app/Components/continue_button.dart';
import 'package:talngo_app/Components/entry_field.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../../../BottomNavigation/Home/home_page.dart';
import '../../../BottomNavigation/bottom_navigation.dart';
import '../../../Routes/routes.dart';
import '../../Registration/UI/register_page.dart';
import '../../forget_password.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LoginBody();
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  bool _isObscure = true;
  var _isLoading = false;
  String session = "";
  //final myBox = Hive.box('userDetails');

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCredentials();
    if (session == "login") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return BottomNavigation();
      }));
    }
  }

  void signIn(String email, password) async {
    if (!_key.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Kindly Provide all the details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
      setState(() => _isLoading = false);
    } else {
      try {
        final response = await http
            .post(Uri.parse("https://talngo.com/api/auth/login"), body: {
          'email': email.trim(),
          'password': password.trim(),
        });
        var res = jsonDecode(response.body);
        print("Login Response==> ${response.body}");

        if (res["status"] == 200) {
          //res["user"];
          print("users data....>" + res["user"].toString());

          Map<String, dynamic> user = res["user"];

          // Iterate over the array

          // Map<dynamic, dynamic> user = jsonDecode(jsonString);

          var id = user["id"];
          var name = user["name"];
          var bio = user["bio"];
          var email = user["email"];
          var username = user["username"];
          var phone = user["phone"];
          var interest = user["interest"];
          var accessToken=res["access_token"];
          saveCredentials(
              id, username,bio,name,email,  phone, interest.toString(),accessToken.toString());

          Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.yellow);
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return BottomNavigation();
          }), (route) => false);
        } else {
          setState(() => _isLoading = false);
          Fluttertoast.showToast(
              msg: res["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.yellow);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> saveCredentials(int userId, String username,String bio, String userFullName,
      String email, String phone, String interest,String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Preference ID:===> " + userId.toString());
    print("Preference AccessTocken:===> " + accessToken);
    prefs.setInt('userId', userId.toInt());
    prefs.setString('username', username.toString());
    prefs.setString('name', userFullName.toString());
    prefs.setString('bio', bio.toString());
    prefs.setString('email', email.toString());
    prefs.setString('session', "login");
    prefs.setString('phone', phone.toString());
    prefs.setString('interest', interest.toString());
    prefs.setString('access_token', accessToken);
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      session = prefs.getString('session') ?? '';
      print("session is....$session");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text("Sign In", style: GoogleFonts.poppins(fontSize: 14)),
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
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: transparentColor,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.all(16.0),
              child: FadedSlideAnimation(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icons/icon.png'))),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                          "Manage your account, accept challenge, comment on vedios and much more...",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          )),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pleases enter a valid email';
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
                      height: 30,
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
                            "Enter Password",
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

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: GestureDetector(
                        onTap: _isLoading ? null : _onSubmit,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 0),
                            child: Center(
                                child: _isLoading
                                    ? Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text("Sign In",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                                color: Colors.white)))),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Forgot Password",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        textStyle:
                                            TextStyle(color: Colors.white))))),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "New User?  SignUp",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ///
                    Center(
                      child: Text(
                        "Or SignIn with",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Colors.cyan;
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage("assets/icons/ic_ggl.png"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage("assets/icons/ic_fb.png"),
                            ),
                          ),
                        ),
                      ],
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
    );
  }

  void _onSubmit() {
    setState(() => _isLoading = true);

    signIn(
        _emailController.text.toString(), _passwordController.text.toString());
  }
}
