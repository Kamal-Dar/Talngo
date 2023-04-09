import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

import '../../upload/upload_from_camera.dart';
import '../AddVideo/start_video.dart';
import '../AddVideo/video_player_file_custom.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;


class UploadRandomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UploadRandomBody();
  }
}

class UploadRandomBody extends StatefulWidget {
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<UploadRandomBody> {
 final key = UniqueKey();
  late int selectedRadio;
  File? _videoFile;
  late VideoPlayerController _controller;
  final ImagePicker picker = ImagePicker();
//final List<String> categoryList = ['Eating', 'Singing', 'Dancing'];
  
  bool _loading = false;

  int? select=1;
  bool _show=false;

   int userId = 0; // Replace with the actual user ID
  final String heading = '';
  //final String category = '';
  final String description = '';


  TextEditingController titleController = TextEditingController();
  //TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<CameraDescription>? cameras;

  String?selectedOption;
  List<String> categoryList = [];

  void onRadioButtonSelected(String?value) {
    setState(() {
      selectedOption = value;
      categoryList.add(value!);
    });
  }

  @override
  void initState() {
    super.initState();
    getCredentials();
    availableCameras().then((value) {
      setState(() {
        cameras = value;
      });
    });
  }

 void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
      print(" shareduserId is "+userId.toString());
    
      
    });
  }
  
  Future<void> uploadVideo(File? pickedFile, int userId, String heading,
      category, description) async {
    print("piskedFile is" + pickedFile.toString());
    try {
      _controller = VideoPlayerController.file(File(pickedFile!.path));
      print("video path is ===>" + pickedFile.path);
      print("heading path is ===>" + heading.toString());
      print("category path is ===>" + categoryList.toString());
      print("desscription path is ===>" + description.toString());
      final request = http.MultipartRequest(
          'POST', Uri.parse('https://talngo.com/api/random-challeng'));
      request.fields['user_id'] = userId.toString();
      request.fields['heading'] = heading;
      request.fields['category'] = categoryList.toString();
      request.fields['description'] = description;
      request.files
          .add(await http.MultipartFile.fromPath('video', pickedFile.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        SmartDialog.dismiss();
      SmartDialog.showToast("Video Uploaded Successfully");
        final responseData = await response.stream.bytesToString();
        final parsedData = jsonDecode(responseData);
        print('Upload successful: $parsedData');
      } else {
        SmartDialog.dismiss();
      SmartDialog.showToast("Video Not Uploaded");
        print('Error uploading video: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error uploading video acception: $error');
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    }
  }

  Future<void> _captureVideo() async {
    final pickedFile = await ImagePicker().getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _loading = true;
      });
      _controller = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {
            _loading = false;
          });
        });
    }
  }

  void showCustomDialog(BuildContext context) {
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
                                  _captureVideo();
                                  print(
                                      "context is  ++++" + context.toString());
                                } else if (selectedRadio == 1) {
                                  _pickVideo();
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Container(
        decoration:  BoxDecoration(
          gradient: lGradient),
        child: Scaffold(
            backgroundColor: transparentColor,
            appBar: AppBar(
              title: Column(
                children: [
                  Center(
                      child: Text("Create Challenge",
                          style: GoogleFonts.poppins(fontSize: 14))),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.square(2.0),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            body: FadedSlideAnimation(
             child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/images/111.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        ),
                                    width: 130,
                                    height: 130,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18, right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/p2.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle),
                                          width: 90,
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("@You",
                                      style: GoogleFonts.poppins(fontSize: 12))
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      image:
                                      AssetImage('assets/images/444.png'),
                                      fit: BoxFit.cover,
                                    ),
                                   ),
      
      
                              ),
                              /*Text("VS",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold))),*/
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/images/111.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        ),
                                    width: 130,
                                    height: 130,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18, right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/p3.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle),
                                          width: 90,
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("@Opponent",
                                      style: GoogleFonts.poppins(fontSize: 12))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Title",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: titleController,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle: TextStyle(color: Colors.white)),
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Lemon Eating Challenge",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        textStyle:
                                            TextStyle(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Category",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  GestureDetector(
                                    onTap: () {
                                      bottomSheet(context);
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(height: 15),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Select category or create your own category using #tag e.g #swimming, Only 4 tags can be added! ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            textStyle: TextStyle(
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ),
                                ],
                              )),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(5)),
                              child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: categoryList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: (100 / 35),
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: FadedScaleAnimation(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, top: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: TextField(
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    textStyle: TextStyle(
                                                        color: Colors.white)),
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding: EdgeInsets
                                                        .only(left: 8),
                                                    hintText: categoryList[
                                                        index],
                                                    suffixIcon: IconButton(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 15,
                                                      ),
                                                      color: secondaryColor,
                                                      onPressed: () {
                                                        setState(() {
                                                          categoryList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize: 10,
                                                            textStyle: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .grey)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .grey.shade600),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Description",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Row(
                                    children: [
                                      Text("( 100 ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12)),
                                      Text("/ 1000 )",
                                          style:
                                              GoogleFonts.poppins(fontSize: 12))
                                    ],
                                  )
                                ],
                              )),
                          SizedBox(height: 15),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "describe your challenge and tag your friend @tag e.g @name! ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            textStyle: TextStyle(
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ),
                                ],
                              )),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                controller: descriptionController,
                                maxLines: 10,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle: TextStyle(color: Colors.white)),
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Hi, this is description bolck",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        textStyle:
                                            TextStyle(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Upload Video",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: Colors.white,
                                dashPattern: [8, 4],
                                strokeWidth: 2,
                                child: _videoFile != null
                                    ? Container(
                                        height: 300,
                                        width: double.infinity,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _controller.value.isPlaying
                                                  ? _controller.pause()
                                                  : _controller.play();
                                            });
                                          },
                                          child: AspectRatio(
                                            aspectRatio:
                                                _controller.value.aspectRatio,
                                            child: VideoPlayer(_controller),
                                          ),
                                        )
                                        //child: VideoPlayer(_controller),

                                        )
                                    : GestureDetector(
                                        onTap: () {
                                          showCustomDialog(context);
                                        },
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.white12,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Icons.videocam,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (_videoFile != null||categoryList.length >= 3 &&
                              categoryList.length <= 5 &&
                              !categoryList.isEmpty) {
                                  uploadVideo(_videoFile!, userId, titleController.text,
                                      categoryList, descriptionController.text);
                                }else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Select Minimum 3 and Maximum 5 categories",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.yellow);
                          }
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text("Upload Challenge",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                                color: Colors.white)))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                        ],
                  ),
                    ),
                  ),
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            )),
      ),
    );
  }


  void bottomSheet(context) {
  int? select=1;
  bool _show=false;
  

 showModalBottomSheet(
              context: context,
              builder: (BuildContext bc){
          return SingleChildScrollView(
            child: StatefulBuilder(builder: (context,setState){
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text('Singing'),
                      leading: Radio(
                        value: 'Singing',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Dancing'),
                      leading: Radio(
                        value: 'Dancing',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Comedy'),
                      leading: Radio(
                        value: 'Comedy',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                  ListTile(
                      title: Text('Beauty'),
                      leading: Radio(
                        value: 'Beauty',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Fasion'),
                      leading: Radio(
                        value: 'Fasion',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Sports'),
                      leading: Radio(
                        value: 'Sports',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                  ListTile(
                      title: Text('Acting'),
                      leading: Radio(
                        value: 'Acting',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Photography'),
                      leading: Radio(
                        value: 'Photography',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                    ListTile(
                      title: Text('Hand Art'),
                      leading: Radio(
                        value: 'Hand Art',
                        groupValue: selectedOption,
                        onChanged: onRadioButtonSelected,
                      ),
                    ),
                  
                  ],
                );
              },
            )
          ); 
 });

}
}