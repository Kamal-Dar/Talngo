import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:path/path.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/video_page.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;

class StartVideo extends StatefulWidget {
  const StartVideo({super.key});

  @override
  State<StartVideo> createState() => _StartVideoState();
}

class _StartVideoState extends State<StartVideo> {
  bool _isLoading = true;
  bool _isRecording = false;
  String val = "";
  late CameraController _cameraController;
  int userId = 0;
  final directory = getExternalStorageDirectory();

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
    getCredentials();
  }
  
   void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
    
      
    });
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


  

  _recordVideo() async {
    onVideoRecorded:
    (value) {
      final path = value.path;
      val = path;
      GallerySaver.saveVideo(path);
      print('::::::::::::::::::::::::;; dkdkkd $path');
    };
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(context as BuildContext, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return FlutterCamera(
      color: Colors.transparent,
      
      onImageCaptured: (value) {
        final path = value.path;
        print("image path::::::::::::::::::::::::::::::::: $path");
        if (path.contains('.jpg')) {
          showDialog(
              context: context,
              builder: (context) {
                
                return Column(
                  children: [
                    AlertDialog(
                      content: Image.file(File(path)),
                      
                    ),
                    ElevatedButton(onPressed: (){
                      upload(File(path), context);
                    }, child: Text("upload"))
                  ],
                );
              });
        }
      },
      onVideoRecorded: (value) {
        final path = value.path;
        print('::::::::::::::::::::::::;; dkdkkd $path');
        final route = MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => VideoPage(filePath: path),
        );
        // ignore: use_build_context_synchronously
        Navigator.push(context, route);
        // GallerySaver.saveVideo(value.path).then(( valuepath) {
        //   setState(() {
        //    //secondButtonText = 'video saved!';
        //   });
        // });
        ///Show video preview .mp4
      },
    );

//      Center(
//   child: Stack(
//     alignment: Alignment.bottomCenter,
//     children: [
//       CameraPreview(_cameraController),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //  Padding(
//           //   padding: const EdgeInsets.all(25),
//           //   child: FloatingActionButton(
//           //     backgroundColor: Colors.red,
//           //     child: Icon(Icons.cameraswitch_outlined,color: Colors.white,),
//           //     onPressed: () {}
//           //   ),
//           // ),
//           //  SizedBox(width: 10,),
//           Padding(
//             padding: const EdgeInsets.all(25),
//             child: FloatingActionButton(
//               backgroundColor: Colors.red,
//               child: Icon(_isRecording ? Icons.stop : Icons.circle),
//               onPressed: () => _recordVideo(),
//             ),
//           ),

//         ],
//       ),
//     ],
//   ),
// );
  }
  
}
