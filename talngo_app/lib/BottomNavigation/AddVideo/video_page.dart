import 'dart:convert';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:video_player/video_player.dart';

import '../../Routes/routes.dart';
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  final String filePath;

  VideoPage({Key? key, required this.filePath}) : super(key: key);
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  int userId = 0;
  
  bool isLoading = true;
  var videoMap = new Map<String, String>();
  // var req = http.MultipartRequest('POST', Uri.parse("https://talngo.com/api/video"));
  
  @override
  void initState() {
    super.initState();
    getCredentials();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
   void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    
      
    });
  }


  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  upload(File imageFile, BuildContext context1) async {
    SmartDialog.showLoading();
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://talngo.com/api/store_user_video/$userId");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('video', stream, length,
        filename: basename(imageFile.path));

    request.fields['user_id'] = userId.toString();
    request.fields['title'] = "Kuch bhi add kr do";

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    if (response.statusCode == 200) {
      SmartDialog.dismiss();
      SmartDialog.showToast("Video Uploaded Successfully");
      int count = 0;
      Navigator.of(context1).popUntil((_) => count++ >= 2);
      //Navigator.pop(context1);
      //Navigator.pushNamed(context1, PageRoutes.addVideoPage);
    } else {
      SmartDialog.dismiss();
      SmartDialog.showToast("Video Not Uploaded");
      int count = 0;
      Navigator.of(context1).popUntil((_) => count++ >= 2);
      //Navigator.pop(context1).;
      //Navigator.pushNamed(context1, PageRoutes.addVideoPage);
    }

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // uploadFile(String file_path) async {
  //   final byteData = await rootBundle.load('assets/.mp4');
  //   print("File Path===> "+file_path);
  //   Uri myUri = Uri.parse(file_path);
  //   var postUri = Uri.parse("https://talngo.com/api/video");
  //   var request = new http.MultipartRequest("POST", postUri);
  //   request.fields['user_id'] = "8";
  //   request.fields['title'] = "Kuch bhi add kr do";
  //   request.files.add(new http.MultipartFile.fromBytes('video', await File.fromUri(myUri).readAsBytes()));

  //   request.send().then((response) async{
  //     print("Response==========>"+response.toString());
  //     var responseString=await response.stream.bytesToString();
  //     print("Response_New==========>"+responseString);

  //     if (response.statusCode == 200)
  //     {
  //        print("Uploaded!");
  //     }
  //     else{
  //       print("Not Uploaded!");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 1);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                )),
            SizedBox(
              width: 10,
            ),
            Text("Preview"),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              upload(File(widget.filePath), context);
              //save to gallery
              GallerySaver.saveVideo(widget.filePath).then((valuepath) {
                setState(() {
                  //secondButtonText = 'video saved!';
                });
              });
              print('do something with the file');
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}
