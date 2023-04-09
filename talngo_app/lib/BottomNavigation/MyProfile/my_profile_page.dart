import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Components/profile_page_button.dart';
import 'package:talngo_app/Components/row_item.dart';
import 'package:talngo_app/Components/sliver_app_delegate.dart';
import 'package:talngo_app/Components/tab_grid.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/edit_profile.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/followers.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:talngo_app/BottomNavigation/Explore/explore_page.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/following.dart';
import 'package:http/http.dart' as http;

class MyProfilePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MyProfileBody(userId: '',);
  }
}

class MyProfileBody extends StatefulWidget {
   final String userId;
  const MyProfileBody(
      {super.key,
      required this.userId,
     
      });
   
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  final key = UniqueKey();
  bool isFollowed = false;
  String accessToken = "";
  String username = "";
  String name = "";
  bool isLoading = false;
  int userId = 0;
  String total_follower = "";
  String total_follwing = "";
  var videoMap = new Map<String, List<dynamic>>();
  List<String> userVedioList = [];
  

  @override
  void initState() {
    super.initState();

    getCredentials();
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? '';
      username = prefs.getString('username') ?? '';
      name = prefs.getString('name') ?? '';
      userId = prefs.getInt('userId') ?? 0;
      followingApi();
      fetchuserVideo();
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
      print("PROFILE Response are==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['id'];
          var name = i['video'];
           setState(() {
                 userVedioList.add('assets/thumbnails/dance/Layer 951.png');
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

 
  Future<void> followingApi() async {
    final response = await http.get(
        Uri.parse("https://talngo.com/api/total-followers-following/" +
            userId.toString().trim()),
        headers: {"Authorization": "Bearer " + accessToken});
    var res = jsonDecode(response.body);
    // print("Following Response==> ${response.body}");

    // print('User ID----->: $userId');
    // print('access Token----->: $accessToken');
    if (res["success"] == true) {
      Map<String, dynamic> i = res['data'];
      // print("data is==> ${i}");
      setState(() {
        total_follower = i['followers'].toString();
        total_follwing = i['followering'].toString();
      });

      // Fluttertoast.showToast(
      //     msg: res["message"],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.yellow);
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 64.0),
      child: Container(
        decoration: BoxDecoration(gradient: lGradient),
        child: Scaffold(
          backgroundColor: transparentColor,
          body: (total_follower.isEmpty)
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                        : Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 404.0,
                          floating: false,
                          actions: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                cardColor: backgroundColor,
                              ),
                              child: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: secondaryColor,
                                ),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                                onSelected: (dynamic value) {
                                  if (value == locale!.changeLanguage) {
                                    Navigator.pushNamed(
                                        context, PageRoutes.languagePage);
                                  } else if (value == locale.help) {
                                    Navigator.pushNamed(
                                        context, PageRoutes.helpPage);
                                  } else if (value == locale.termsOfUse) {
                                    Navigator.pushNamed(
                                        context, PageRoutes.tncPage);
                                  } else if (value == locale.logout) {
                                    Phoenix.rebirth(context);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text(locale!.changeLanguage!),
                                      value: locale.changeLanguage,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                    ),
                                    PopupMenuItem(
                                      child: Text(locale.help!),
                                      value: locale.help,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                    ),
                                    PopupMenuItem(
                                      child: Text(locale.termsOfUse!),
                                      value: locale.termsOfUse,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                    ),
                                    PopupMenuItem(
                                      child: Text(locale.logout!),
                                      value: locale.logout,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                    )
                                  ];
                                },
                              ),
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Column(
                              children: <Widget>[
                                Spacer(flex: 10),
                                CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage:
                                      AssetImage('assets/images/disk.png'),
                                ),
                                Spacer(),
                                Text(
                                  name,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  username,
                                  style:
                                      TextStyle(fontSize: 10, color: mainColor),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_fb.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    SizedBox(width: 16),
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_twt.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    SizedBox(width: 16),
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_insta.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  locale!.comment5!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8),
                                ),
                                Spacer(),
                                ProfilePageButton(
                                  locale.editProfile,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()));
                                  },
                                  width: 120,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    // RowItem(
                                    //     '1.2m',
                                    //     locale.liked,
                                    //     Scaffold(
                                    //       appBar: AppBar(
                                    //         title: Text('Liked'),
                                    //       ),
                                    //       body: TabGrid(
                                    //         food,
                                    //       ),
                                    //     )),
                                    RowItem(total_follower, locale.followers,
                                        FollowersBody(verId: userId.toString(),)),
                                     RowItem(total_follwing,
                                            locale.following, FollowingBody(verId: userId.toString(),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(
                            TabBar(
                              labelColor: mainColor,
                              unselectedLabelColor: lightTextColor,
                              indicatorColor: transparentColor,
                              tabs: [
                                Tab(icon: Icon(Icons.dashboard)),
                                Tab(icon: Icon(Icons.favorite_border)),
                                Tab(icon: Icon(Icons.bookmark_border)),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: <Widget>[
                        FadedSlideAnimation(
                         child: TabGrid(
                             userVedioList,
                            viewIcon: Icons.remove_red_eye,
                            views: '2.2k',
                            onTap: () => Navigator.pushNamed(
                                context, PageRoutes.videoOptionPage),
                          ),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                        FadedSlideAnimation(
                         child: TabGrid(
                            dance,
                            icon: Icons.favorite,
                          ),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                       
                        FadedSlideAnimation(
                         child: TabGrid(
                            lol,
                            icon: Icons.bookmark,
                          ),
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
