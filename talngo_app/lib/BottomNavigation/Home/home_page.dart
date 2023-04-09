import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talngo_app/BottomNavigation/Home/following_tab.dart';
import 'package:talngo_app/BottomNavigation/Home/recomended_tab.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:http/http.dart' as http;
import 'challenges_tab.dart';
import 'new_tab.dart';
import 'news_tab.dart';
import 'package:flutter/services.dart' show rootBundle;

List<String> videos1 = [
  'assets/videos/3.mp4',
  'assets/videos/1.mp4',
  'assets/videos/2.mp4',
];

List<String> videos2 = [
  'assets/videos/4.mp4',
  'assets/videos/5.mp4',
  'assets/videos/6.mp4',
];

List<String> imagesInDisc1 = [
  'assets/user/user1.png',
  'assets/user/user2.png',
  'assets/user/user3.png',
];

List<String> imagesInDisc2 = [
  'assets/user/user4.png',
  'assets/user/user3.png',
  'assets/user/user1.png',
];

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}

class HomeBody extends StatefulWidget {
  
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  //var followVideoMap = new Map<String, String>();
  var tempVideoMap = new Map<String, String>();
  bool isLoading = true;
  var video_id;
  @override
  void initState() {
    super.initState();
    fetchVideo();
    fetchfollowingVideo();
    //loadPerson();
  }

  // Future<Videos> loadPerson() async {
  //   String jsonString = await rootBundle.loadString('assets/videos.json');
  //   var jsonData = jsonDecode(jsonString);
  //   print("===>" + jsonData['video'].toString());
  //   var newData = jsonData['video'];

  //   var vId, vTitle, vUrl;
  //   for (var i in newData) {
  //     vId = i['id'];
  //     vTitle = i['title'];
  //     vUrl = i['videoUrl'];
  //   }

  //   print("Video ID: " +
  //       vId.toString() +
  //       ",\n Title: " +
  //       vTitle.toString() +
  //       ",\n Video Url: " +
  //       vUrl.toString());
  //   return Videos(id: vId, title: vTitle, videoUrl: vUrl);
  // }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(icon: Image.asset(
        'assets/icons/icon.png',
        width: 30,
        height: 30,
      ),),
      Tab(text: AppLocalizations.of(context)!.following),
      Tab(text: "Tournaments"),
      Tab(text: "Challenges"),
    ];

    return DefaultTabController(
      length: tabs.length,
      child:FutureBuilder(

        future: http.get(Uri.parse("https://talngo.com/api/video")),
        builder: (context,snapShot) {
          if(snapShot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapShot.hasError){
            return Center(
              child: Text(snapShot.error.toString()),
            );
          }
          var res = jsonDecode(snapShot.data!.body);
      
        
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['user_id'];
          var name = i['video'];
            video_id = i['id'];
            print("video_id is in home"+video_id.toString());
        }
          return Stack(
            children: <Widget>[
              TabBarView(
                children: <Widget>[
                  (tempVideoMap.entries.isEmpty)
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : NewsTabPage(tempVideoMap, imagesInDisc1, false, userId: '',videoId: video_id==null?0:video_id, ),
                  FollowingTabPage(videos1, imagesInDisc1, false),
                  RecomendedTabPage(videos2, imagesInDisc2, false),
                  Challenges_tab(userId: 0, videoId: video_id==null?0:video_id,),
                ],
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        indicator: BoxDecoration(color: transparentColor),
                        tabs: tabs,
                      ),
                      Positioned.directional(
                        textDirection: Directionality.of(context),
                        top: 14,
                        start: 84,
                        child: CircleAvatar(
                          backgroundColor: mainColor,
                          radius: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  fetchVideo() async {
    SmartDialog.showLoading();
    // open a bytestream
    try {
      final response =
          await http.get(Uri.parse("https://talngo.com/api/video"));

      var res = jsonDecode(response.body);
      print("fetch Response==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['user_id'];
          var name = i['video'];
            video_id = i['id'];
          print('user_id is......' + id);
          setState(() {
            //followVideoMap[id.toString()] = name;
            tempVideoMap[id.toString()] = name;
            //userVideo.add("https://talngo.com/" + name);
          });
          //videos2.add("https://talngo.com/"+name);
          print("name of videos is....." + name);
          print('vide id is......' + video_id.toString());
          print("name of videos is++++....." + tempVideoMap.entries.toString());
        }
        print("Video List: ==>" + videoArray.toString());
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

fetchfollowingVideo() async {
    SmartDialog.showLoading();
    // open a bytestream
    try {
      final response =
          await http.get(Uri.parse("https://talngo.com/api/get_following_video/54"));

      var res = jsonDecode(response.body);
      print("fetch following Response==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['user_id'];
          //var name = i['video'];
            video_id = i['id'];
          print('user_id in following is......' + id);
          setState(() {
            //followVideoMap[id.toString()] = name;
            tempVideoMap[id.toString()] = id;
            //userVideo.add("https://talngo.com/" + name);
          });
          //videos2.add("https://talngo.com/"+name);
          print("name of userId is....." + id);
          // print('vide id is......' + video_id.toString());
          // print("name of videos is++++....." + tempVideoMap.entries.toString());
        }
        print("Video List: ==>" + videoArray.toString());
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



}

