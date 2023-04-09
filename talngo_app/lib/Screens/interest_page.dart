import 'dart:collection';
import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../Auth/Login/UI/login_page.dart';
import '../Auth/forget_password.dart';

class InterestPage extends StatefulWidget {
  final String userName;
  final String fullName;
  final String email;
  final String phone;
  final String area;
  final String city;
  final String password;
  final String confirmpassword;
  const InterestPage(
      {super.key,
      required this.userName,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.city,
      required this.area,
      required this.password,
      required this.confirmpassword});

  @override
  State<InterestPage> createState() => InterestPageState();
}

class InterestPageState extends State<InterestPage> {
  List<Course> corcess = new List.empty(growable: true);
  bool selectAll = false;

  var selectMap = new Map<int, String>();

  List<String> gridImage = <String>[
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
    'assets/images/9.png',
  ];
  List<String> gridText = <String>[
    'Singing',
    'Dancing',
    'Comedy',
    'Beauty',
    'Fasion',
    'Sports',
    'Acting',
    'Photography',
    'Hand Art',
  ];

  void register(userName, fullName, email, phone, city, area, password,
      confirmPassword) async {
    try {
      final response = await http
          .post(Uri.parse("https://talngo.com/api/auth/register"), body: {
        'name': fullName,
        'username': userName,
        'email': email,
        'phone': phone,
        'country': "Pakistan",
        'password': password,
        'password_confirmation': confirmPassword,
        'city': city,
        'area': area,
        'interest': selectMap.values.toString(),
      });

      var res = jsonDecode(response.body);
      //print("Register Response==> ${response.body}");
      if (res["status"] == 200) {
        SmartDialog.dismiss();
        showCustomDialog(context, selectMap.values.toString());

        Fluttertoast.showToast(
            msg: "Registed Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.yellow);
      } else {
        SmartDialog.dismiss();
        Fluttertoast.showToast(
            msg: res["msg"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.yellow);
      }
    } catch (e) {
      SmartDialog.dismiss();
      showNewCustomDialog(context);
      Fluttertoast.showToast(
          // msg: e.toString(),
          msg: "provided email allreasy exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
      print("error is here" + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    corcess.add(Course("Singing", false));
    corcess.add(Course("Dancing", false));
    corcess.add(Course("Commedy", false));
    corcess.add(Course("Beauty", false));
    corcess.add(Course("Fation", false));
    corcess.add(Course("Sports", false));
    corcess.add(Course("Acting", false));
    corcess.add(Course("Photography", false));
    corcess.add(Course("Hand Art", false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text("Choose your interests for better recommendations",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 100,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Select all interests",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 14,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold)),
                  //     Theme(
                  //       data: Theme.of(context)
                  //           .copyWith(unselectedWidgetColor: Colors.white),
                  //       child: Checkbox(
                  //           value: selectAll,
                  //           onChanged: (bool? value) {
                  //             setState(() {
                  //               selectAll = value!;
                  //               corcess.forEach((element) {
                  //                 element.selected = value;
                  //               });
                  //             });
                  //           }),
                  //     ),
                  //   ],
                  // ),

                  GridView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return prepareList(index);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: corcess.length,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 0, bottom: 0),
                          child: Center(
                              child: Text("Skip",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      textStyle:
                                          TextStyle(color: Colors.white)))),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectMap.length >= 3 &&
                              selectMap.length <= 5 &&
                              !selectMap.isEmpty) {
                            SmartDialog.showLoading();
                            register(
                                widget.userName,
                                widget.fullName,
                                widget.email,
                                widget.phone,
                                widget.city,
                                widget.area,
                                widget.password,
                                widget.confirmpassword);
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Select Minimum 3 and Maximum 5 Interests",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.yellow);
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 0),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget prepareList(int k) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        height: 100,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(gridImage[k]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  gridText[k],
                  style: const TextStyle(color: Colors.white),
                )),
              ],
            ),
            Positioned(
                child: Theme(
              data: Theme.of(context)
                  .copyWith(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: corcess[k].selected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value.toString() == "true") {
                      selectMap[k] = gridText[k];
                      print(selectMap.entries);
                    } else {
                      if (selectMap.containsKey(k)) {
                        selectMap.remove(k);
                        print(selectMap.entries);
                      }
                    }

                    print("Check Value==>" + value.toString());
                    //selectMap[k]=gridText[k];

                    corcess[k].selected = value!;
                  });
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class Course {
  String name;
  bool selected;
  Course(this.name, this.selected);
}

void showCustomDialog(BuildContext context, String values) {
  showDialog(
      context: context,
      barrierColor: Colors.grey.withOpacity(0.5),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Container(
              height: 230,
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
                              child: Text("Congratulations! ",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                  "Your account is successfully Created\n Click below button to Login! ",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      textStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text("Selected Interest are:\n" + values,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      textStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Center(
                                          child: Text("Ok to Login!",
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
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
            ),
          );
        });
      });
}

void showNewCustomDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierColor: Colors.grey.withOpacity(0.5),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Container(
              height: 230,
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
                              child: Text("Sorry! ",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                  "Your account has not been created! \n Provided email  is allready registered \n try with a new email  \n or select Forgot password to recover your account",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      textStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgotPassword()));
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Center(
                                          child: Text("Ok to Forgot Password!",
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
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
            ),
          );
        });
      });
}
