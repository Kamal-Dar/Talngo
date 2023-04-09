import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/start_video.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/video_player_file_custom.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
    PickedFile?_pickedFile;
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: FadedSlideAnimation(
         child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/video 2.png',
                fit: BoxFit.fill,
                height: ht,
                width: wt,
              ),
              Positioned(
                top: 28,
                left: 4,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: secondaryColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                width: wt,
                bottom: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.camera_front,
                      color: secondaryColor,
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: videoCall,
                        child: Icon(
                          Icons.videocam,
                          color: secondaryColor,
                          size: 30,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartVideo()));

                          //            Navigator.pushNamed(
                          //  context, PageRoutes.addVideoFilterPage);
                      } 
                    ),
                    Icon(
                      Icons.flash_off,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                width: wt,
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()async{
                        // ignore: deprecated_member_use
                        _pickedFile = (await picker.getVideo(source: ImageSource.gallery));
                         Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => VideoPlayerFileCustum(
                          filePath: _pickedFile!.path,
                        )));
                      },
                      
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.swipeUpForGallery!,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
