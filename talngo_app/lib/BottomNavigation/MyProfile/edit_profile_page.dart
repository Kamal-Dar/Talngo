import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../Components/tab_grid.dart';
import '../../Routes/routes.dart';
import '../../Theme/colors.dart';
import '../Explore/explore_page.dart';
import 'package:http/http.dart' as http;

class Edit_Profile extends StatefulWidget {
  // final List<String> videos;
  const Edit_Profile({
    Key? key,
    /*required this.videos*/
  }) : super(key: key);

  @override
  State<Edit_Profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_Profile> {

  bool _isOn = false;

  late TabController _controller;
  int userId = 0;
  late String username = "";
  late String bio = "";
  late String userFullName = "";
  late String email = "";
  late String phone = "";
  late String interest = "";
  bool isLoading = true;
  var videoMap = new Map<String, String>();
  late int selectedRadio;
  File? _userImage;
  late VideoPlayerController controller;
  final ImagePicker picker = ImagePicker();
  bool _loading = false;
  TextEditingController bioController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    getupdateApi();
    getCredentials();
  }

  void _toggle() {
    setState(() {
      _isOn = !_isOn;
    });
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
      username = prefs.getString('username') ?? '';
      bio = prefs.getString('bio') ?? '';
      userFullName = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      interest = prefs.getString('interest') ?? '';
      fetchuserVideo();
    });
    _loadImage().then((value) {
      setState(() {
        _userImage = value.isNotEmpty ? File(value) : null;
      });
    });
  }

  fetchuserVideo() async {
    print(userId.toString());
    SmartDialog.showLoading();
    // open a bytestream
    videoMap.clear();
    try {
      final response = await http
          .get(Uri.parse("https://talngo.com/api/get_user_video/$userId"));
      var res = jsonDecode(response.body);
      print("Register Response are==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['id'];
          var name = i['video'];
          setState(() {
            videoMap[id.toString()] = name;
            //userVideo.add("https://talngo.com/" + name);
          });
        }
        // Fluttertoast.showToast(
        //     msg: res["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.yellow);
      } else {
        SmartDialog.dismiss();
        // Fluttertoast.showToast(
        //     msg: res["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.yellow);
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

  deletuserVideo(String videoId) async {
    SmartDialog.showLoading();

    try {
      final response = await http
          .get(Uri.parse("https://talngo.com/api/delete_user_video/$videoId"));
      var res = jsonDecode(response.body);
      print("Deleted Response are==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        Fluttertoast.showToast(
            msg: res["message"],
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

  void showCustomDialog(BuildContext context, String VideoID) {
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
                                child: Text("Delete! ",
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
                                    "Are you sure you want to delete video...! ",
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
                                child: Text("Your Video Details:\n",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
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
                                            child: Text("Cancel",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Fluttertoast.showToast(
                                          msg: "Clicked on Delete Button...",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.yellow);
                                      deletuserVideo(VideoID);
                                      fetchuserVideo();

                                      // Navigator.of(context).pop();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => LoginPage()));
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
                                            child: Text("Delete",
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
            );
          });
        });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Reduce image quality to reduce file size
    );

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreview(File(pickedFile.path)),
        ),
      );
    }
  }

  Future<void> updateProfileApi(String name1, String bio1,String userId1, String _userImage1) async {
    print("update name is "+name1.toString());
    print("update bio is "+bio1.toString());
    print("update user_id is "+userId1.toString());
    print("update image is "+_userImage1.toString());
  final response =
      await http.post(Uri.parse("https://talngo.com/api/auth/update-profile"), body: {
    'name': name1.toString(),
    'bio': bio1.toString(),
    'id': userId1.toString(),
    'image': _userImage1.toString(),
  });
  var res = jsonDecode(response.body);
  print("update Api Response==> ${response.body}");

  if (res["status"] == 200) {
    print('name +++:${name1.toString()}');
    print('bio +++: ${bio1.toString()}');
    print('id +++: $userId1');
    // print('id +++: $comments');
    Fluttertoast.showToast(
        msg: res["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.yellow);
  } else {
    Fluttertoast.showToast(
        msg: res["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }
}

getupdateApi() async {
   // print(userId.toString());
    SmartDialog.showLoading();
    // open a bytestream
    //videoMap.clear();
    try {
      final response = await http
          .get(Uri.parse("https://talngo.com/api/auth/get-profile/$userId"));
      var res = jsonDecode(response.body);
      print("Updated api Response are==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        //var videoArray = res["data"];
        // for (var i in videoArray) {
        //   var id = i['id'];
        //   var name = i['video'];
        //   setState(() {
        //     videoMap[id.toString()] = name;
        //     //userVideo.add("https://talngo.com/" + name);
        //   });
        // }
        // Fluttertoast.showToast(
        //     msg: res["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.yellow);
      } else {
        SmartDialog.dismiss();
        // Fluttertoast.showToast(
        //     msg: res["message"],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.yellow);
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





  Future<void> _captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _userImage = pickedFile != null ? File(pickedFile.path) : null;
      _saveImage(pickedFile!.path);
    });
  }

  Future<void> _saveImage(String img) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', img);
  }

  Future<String> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath') ?? '';
  }

  void showCamraDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          selectedRadio = -1;
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Container(
                height: 240,
                // ignore: sort_child_properties_last
                child: SizedBox.expand(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("What do you want to do? ",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle: TextStyle(color: Colors.white))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.grey,
                              disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 0,
                              groupValue: selectedRadio,
                              title: Text("Open Camera",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white)),
                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.grey,
                              disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadio,
                              title: Text("Select from galley",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white)),
                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () async {
                                if (selectedRadio == 0) {
                                  _captureImage();
                                  print(
                                      "context is  ++++" + context.toString());
                                } else if (selectedRadio == 1) {
                                  _pickImage();
                                }
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: Text("Next",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                                color: Colors.white)))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    gradient: lGradient,
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          });
        });
  }

  void updateProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 500.0,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                gradient: lGradient
                ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: lGradient
                    ),
                    child: Center(
                        child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ))),
                SizedBox(height: 10),
                Container(
                    height: 20,
                    child: Icon(
                      Icons.help,
                      size: 30,
                      color: Colors.yellow,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'update profile?',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Form(
                  key: _key, // a GlobalKey<FormState> to access the form's state
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pleases entery your Name';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            label: Text(
                              "Enter Name",
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Bio';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                         controller: bioController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            label: Text(
                              "Enter your bio",
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
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateProfileApi(nameController.text.toString(),bioController.text.toString(),userId.toString(),_userImage.toString());
                      },
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: lGradient),
                        child: Center(
                            child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: lGradient),
                        child: Center(
                            child: Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showCamraDialog(context);
                    },
                    icon: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
        );
      },
    );
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
              backgroundColor: transparentColor,
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("$username",
                          style: GoogleFonts.poppins(fontSize: 14))
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
              body: FadedSlideAnimation(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          
                                        },
                                        child: _userImage != null
                                            ? Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: _userImage !=
                                                          null
                                                      ? FileImage(_userImage!)
                                                      : null,
                                                  child: _userImage == null
                                                      ? Text('No image')
                                                      : null,
                                                ),
                                              )
                                            : Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/p3.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    shape: BoxShape.circle),
                                              ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /*RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        unratedColor: Colors.amber.withAlpha(50),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {});
                                        },
                                        updateOnDrag: true,
                                      ),*/
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Superstar",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("$username",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.blue,
                                          //       shape: BoxShape.circle),
                                          //   width: 20,
                                          //   height: 20,
                                          //   child: Center(
                                          //       child: Icon(
                                          //         Icons.edit,
                                          //         size: 11,
                                          //         color: Colors.white,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("$userFullName",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.blue,
                                          //       shape: BoxShape.circle),
                                          //   width: 20,
                                          //   height: 20,
                                          //   child: Center(
                                          //       child: Icon(
                                          //         Icons.edit,
                                          //         size: 11,
                                          //         color: Colors.white,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("$bio",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              updateProfileDialog();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle),
                                              width: 20,
                                              height: 20,
                                              child: Center(
                                                  child: GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 11,
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     ElevatedButton(onPressed: (){}, child: Text("update")),
                                  //   ],
                                  // )
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
                                  Text("Manage Account",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("private Account",
                                      style: GoogleFonts.poppins(fontSize: 13)),
                                  GestureDetector(
                                    onTap: _toggle,
                                    child: Icon(
                                      _isOn
                                          ? Icons.toggle_on
                                          : Icons.toggle_off,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SingleChildScrollView(
                              child: SizedBox(
                                height: 600,
                                child: DefaultTabController(
                                  length: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: transparentColor,
                                    ),
                                    child: new Scaffold(
                                      backgroundColor: transparentColor,
                                      appBar: TabBar(
                                        indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                        isScrollable: true,
                                        labelColor: Colors.white,
                                        unselectedLabelColor: disabledTextColor,
                                        tabs: <Widget>[
                                          Tab(text: "Your Videos"),
                                          Tab(text: "Likes"),
                                          Tab(text: "Challenges"),
                                        ],
                                      ),
                                      body: TabBarView(
                                        children: <Widget>[
                                          FadedSlideAnimation(
                                            child: (videoMap.entries.isEmpty)
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ))
                                                : GridView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        videoMap.entries.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 2 / 2.5,
                                                      crossAxisSpacing: 2,
                                                      mainAxisSpacing: 2,
                                                    ),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onLongPress: () {
                                                          print("===>" +
                                                              videoMap.keys
                                                                  .elementAt(
                                                                      index));
                                                          showCustomDialog(
                                                              context,
                                                              videoMap.keys
                                                                  .elementAt(
                                                                      index));
                                                        },
                                                        child:
                                                            FadedScaleAnimation(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/p3.jpg'),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/icons/transparent_play.png'),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                                width: 35,
                                                                height: 35,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                            beginOffset: Offset(0, 0.3),
                                            endOffset: Offset(0, 0),
                                            slideCurve: Curves.linearToEaseOut,
                                          ),
                                          FadedSlideAnimation(
                                            child: GridView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: 5,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2 / 2.5,
                                                  crossAxisSpacing: 2,
                                                  mainAxisSpacing: 2,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {},
                                                    child: FadedScaleAnimation(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/p2.jpg'),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                10.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/icons/transparent_play.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                            width: 35,
                                                            height: 35,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            beginOffset: Offset(0, 0.3),
                                            endOffset: Offset(0, 0),
                                            slideCurve: Curves.linearToEaseOut,
                                          ),
                                          FadedSlideAnimation(
                                            child: GridView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: 15,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2 / 2.5,
                                                  crossAxisSpacing: 2,
                                                  mainAxisSpacing: 2,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {},
                                                    child: FadedScaleAnimation(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/p2.jpg'),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                10.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/icons/transparent_play.png'),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                            width: 35,
                                                            height: 35,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            beginOffset: Offset(0, 0.3),
                                            endOffset: Offset(0, 0),
                                            slideCurve: Curves.linearToEaseOut,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // create widgets for each tab bar here
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

class ImagePreview extends StatelessWidget {
  final File imageFile;

  const ImagePreview(this.imageFile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
