import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Components/continue_button.dart';
import 'package:talngo_app/Components/entry_field.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';

import '../../../Routes/routes.dart';
import '../../Login/UI/login_page.dart';
import '../../login_navigator.dart';
import 'package:http/http.dart' as http;

import '../../Verification/Otp/otp_screen.dart';

//register page for registration of a new user
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
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
                Text("SignUp for Talngo",
                    style: GoogleFonts.poppins(fontSize: 14)),
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
          child:RegisterForm(),
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
  List<String> cities = ["Select City"];
  List<String> areas = ["Select Area"];
  var CityMap = new Map<String, List>();
  var Cities = new Map<String, String>();

  bool isLoading = true;
  // cities.add(value);
  String countryCode = '+92';
  String city_selected_ID = '';
  late String city = "Select City";
  late String area = "Select Area";
  bool _isObscure = true;
  bool isObscure = true;
  var _isLoading = false;

  late String phoneNumber, verificationId;
  late String otp, authStatus = "";

  final GlobalKey<FormState> _key = new GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController;
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPsswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  Future<bool> checkEmailAndPhoneExist(String email, String phone) async {
    final url =
        'https://talngo.com/api/auth/register'; // Replace with your server's URL
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'phone': phone,
    });
    var res = jsonDecode(response.body);
    if (res["status"] == 200) {
      Fluttertoast.showToast(
          msg: "Registed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.yellow);

      return response.body == 'true';
    } else {
      throw Exception('Failed to check email and phone exist');
    }
  }

  void register(String userName, fullName, email, phone, country, password,
      confirmPassword, role) async {
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
      // show  loading cirrcular progress indecator

      //phoneNumber = phoneController.text.toString();
      verifyPhoneNumber(context);
      // verifyPhoneNumber(context);
      // setState(() => _isLoading = false);
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    //await auth.setSettings(appVerificationDisabledForTesting: true);
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        // checkEmailAndPhoneExist(emailController.text,passwordController.text);
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int? forceCodeResent]) {
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
        });
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return OTPScreen(
            verId: verificationId,
            userName: userNameController.text.toString(),
            fullName: fullNameController.text.toString(),
            email: emailController.text.toString(),
            phone: phoneController.text.toString(),
            city: city,
            area: area,
            password: passwordController.text.toString(),
            confirmpassword: confirmPsswordController.text.toString(),
          );
        }), (route) => true).then((value) {});
        //otpDialogBox(context).then((value) {});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }

  Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
  }

  void cityApi() async {
    setState(() {});
    final resp = await http.get(
      Uri.parse("https://talngo.com/api/city"),
    );
    setState(() {
      isLoading = false;
    });
    var cityData = jsonDecode(resp.body.toString());
    if (resp.statusCode == 200) {
      print("all..........................${cityData}");

      var dataArray = cityData['data'] as List;
      // Iterate over the array
      for (var item in dataArray) {
        //print("items are ");
        var cityId = item['id'];
        var name = item['name'];
        var area_list = item['city_area'];
        CityMap[name] = area_list;
        Cities[name] = cityId.toString();

        print("name of item is ${name}");
      }
    } else {
      print('Error getting data');
    }
  }

  void addAreas() {
    areas.removeRange(1, areas.length);
    area = "Select Area";
    if (CityMap.entries != null) {
      for (var key in CityMap.keys) {
        if (key == city) {
          var areaArray = CityMap[key] as List;
          print(areaArray);

          for (var area in areaArray) {
            var name = area['name'];
            if (!areas.contains(name)) {
              areas.add(name);
            }
            //areas.toSet().toList();
            print("Area Name ==> " + name);
          }
          areas.add("others");
        }
      }
    }
  }

  void OthersApi(String area_Name) async {
    for (var key in Cities.keys) {
      if (key == city) {
        city_selected_ID = Cities[key] as String;
        print(city_selected_ID);
      }
    }
    try {
      final response =
          await http.post(Uri.parse("https://talngo.com/api/area"), body: {
        'city_id': city_selected_ID,
        'name': area_Name,
      });

      var res = jsonDecode(response.body);
      print("Register Response==> ${response.body}");
      if (res["status"] == 200) {
        SmartDialog.dismiss();

        Fluttertoast.showToast(
            msg: "Area Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.yellow);
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
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Cities["Select City"] = "0";
    phoneController = new TextEditingController(text: '+92');
    cityApi();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _key,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: transparentColor),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/icon.png'),
                          ),
                        ),
                      ),
                    ),
                    //name textField
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                            "Create a profile, follow other accounts,accept\n challenges, create your own video and\n much more",
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: userNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          focusColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "Create Username",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pleases enter full name';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: fullNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "Full Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (!value!.contains("@") ||
                              !value.contains(".com") ||
                              value == null ||
                              value.isEmpty) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 20,
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          label: Text(
                            "Enter Email Address",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length != 13 ||
                              value == null ||
                              value.isEmpty) {
                            return 'Pleases enter a valid phone number';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              )),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "+92",
                          label: Text(
                            "Phone",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Pleases enter a valid pakistani city';
                        //   }
                        //   return null;
                        // },
                        style: TextStyle(color: Colors.white),
                        controller: cityController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.location_city,
                                color: Colors.white,
                              )),
                          suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 55, right: 10),
                              child: DropdownButton<String>(
                                // Step 3.

                                isExpanded: true,
                                value: city,
                                selectedItemBuilder: (BuildContext context) {
                                  return Cities.keys.map((String value) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    );
                                  }).toList();
                                },
                                iconEnabledColor: Colors.white,
                                // Step 4.
                                items: Cities.keys.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                // Step 5.
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  // Navigator.of(context).pop();
                                  setState(() {
                                    city = newValue!;
                                    addAreas();
                                  });
                                },
                              )),
                          contentPadding: EdgeInsets.only(left: 10),
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
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Pleases enter a valid area';
                        //   }
                        //   return null;
                        // },
                        style: TextStyle(color: Colors.white),
                        controller: areaController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.area_chart_rounded,
                                color: Colors.white,
                              )),
                          suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 55, right: 10),
                              child: DropdownButton<String>(
                                // Step 3.

                                isExpanded: true,
                                value: area,
                                selectedItemBuilder: (BuildContext context) {
                                  return areas.map((String value) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    );
                                  }).toList();
                                },
                                iconEnabledColor: Colors.white,
                                // Step 4.
                                items: areas.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                // Step 5.
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  // Navigator.of(context).pop();
                                  setState(() {
                                    area = newValue!;
                                    //addAreas();
                                  });
                                },
                              )),
                          contentPadding: EdgeInsets.only(left: 10),
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

                    if (area.toString() == "others") ...[
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pleases enter a valid area';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          controller: areaController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.area_chart_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            contentPadding: EdgeInsets.only(left: 10),
                            label: Text(
                              "Enter your area",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.white),
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
                    ],

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (passwordController.text.length < 8) {
                            return 'Please enter a strong password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
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
                          label: Text(
                            "Type Password",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (confirmPsswordController.text !=
                              passwordController.text) {
                            Fluttertoast.showToast(
                                msg: "Pleases enter a matched password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.yellow);
                            return 'Pleases enter a matched password';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        controller: confirmPsswordController,
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
                          label: Text(
                            "Confirm Password",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
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

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "By continuing you agree to Talngo's Term of use and confirm that you have read Talngo\n Privacy Policy" +
                              '\n',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                    //continue button
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: GestureDetector(
                        onTap: _isLoading ? null : _onSubmit,
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginBody()));

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
                                    : Text("Next",
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

                    Center(
                      child: Text(
                        "Or SignUp with",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 0,
                          ),
                          InkWell(
                            onTap: () {
                              Colors.cyan;
                              print("cities are ${cities}");
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
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                textStyle: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Text(
                              "SignIn Now",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  textStyle: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void _onSubmit() {
    setState(() => _isLoading = true);
    phoneNumber = phoneController.text;
    //checkNumberIsRegistered(number: phoneNumber);
    register(
      userNameController.text.toString(),
      fullNameController.text.toString(),
      emailController.text.toString(),
      phoneController.text.toString(),
      countryCode,
      passwordController.text.toString(),
      confirmPsswordController.text.toString(),
      roleController.text.toString(),
    );
    if (areaController.text != "") {
      OthersApi(areaController.text);
    }
  }

  // Future<bool> checkNumberIsRegistered({required String number}) async {
  //   bool isNumberRegistered = false;
  //   try {
  //     await dbref.child("RegisteredNumbers").once().then((data) {
  //       for (var i in data.snapshot.children) {
  //         String data = i.child("phoneNo").value.toString();
  //         if (number == data) {
  //           isNumberRegistered = true;
  //           print("data on is.....>"+data.toString());
  //           return isNumberRegistered;
  //         } else {
  //           isNumberRegistered = false;
  //           print("data is.....>"+data.toString());
  //         }
  //       }
  //     });
  //     return isNumberRegistered;
  //   } catch (e) {
  //     print("data not found....>"+e.toString());
  //     return false;
  //   }
  // }
}
