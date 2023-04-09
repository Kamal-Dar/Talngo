import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/BottomNavigation/Explore/explore_page.dart';
import 'package:talngo_app/Components/profile_page_button.dart';
import 'package:talngo_app/Components/row_item.dart';
import 'package:talngo_app/Components/sliver_app_delegate.dart';
import 'package:talngo_app/Components/tab_grid.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/followers.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/following.dart';
import 'package:http/http.dart' as http;

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyProfileBody();
  }
}

class MyProfileBody extends StatefulWidget {
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  bool isFollowed = false;
  String accessToken = "";
  String username = "";
  bool isLoading = true;
  int userId = 0;
  
   //var userId = 0;
 //var followerId=0;
  

  var followText;
  final key = UniqueKey();

  //  followUserApi(String userId, followrId) async {
  //   SmartDialog.showLoading();

  //   try {
  //     final response = await http
  //         .post(Uri.parse("https://talngo.com/api/follow-user"));
  //     var res = jsonDecode(response.body);
  //     print("Follow Response are==> ${response.body}");
  //     if (res["success"] == true) {
  //       SmartDialog.dismiss();
  //       Fluttertoast.showToast(
  //           msg: res["message"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.yellow);
  //     } else {
  //       SmartDialog.dismiss();
  //       Fluttertoast.showToast(
  //           msg: res["message"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.yellow);
  //     }
  //   } catch (e) {
  //     SmartDialog.dismiss();
  //     // Fluttertoast.showToast(
  //     //     msg: e.toString(),
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //     backgroundColor: Colors.red,
  //     //     textColor: Colors.yellow);
  //     print(e.toString());
  //   }
  // }
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
        userId = prefs.getInt('userId') ?? 0;
        // followingApi();
      
    });
  }
 

  // Future<void> followUserApi() async {
  //   final response = await http
  //       .post(Uri.parse("https://talngo.com/api/follow-user"), headers: {
  //     "Authorization": "Bearer " + accessToken
  //   }, body: {
      
  //     'follower_id': '29',
  //     'user_id': '31',
  //   });
  //   var res = jsonDecode(response.body);
  //   print("Follow Response==> ${response.body}");

  //   if (res["status"] == 200) {
      
  //     print('User ID: OK');
  //     print('Follower ID:OK');
  //     Fluttertoast.showToast(
  //           msg: res["message"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.yellow);
  //   } else {
  //     Fluttertoast.showToast(
  //           msg: res["message"],
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.yellow);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 400.0,
                    floating: false,
                    actions: <Widget>[
                      PopupMenuButton(
                        color: backgroundColor,
                        icon: Icon(
                          Icons.more_vert,
                          color: secondaryColor,
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Text(locale!.report!),
                              value: locale.report,
                              textStyle: TextStyle(color: secondaryColor),
                            ),
                            PopupMenuItem(
                              child: Text(locale.block!),
                              value: locale.block,
                              textStyle: TextStyle(color: secondaryColor),
                            ),
                          ];
                        },
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Column(
                        children: <Widget>[
                          Spacer(flex: 10),
                          FadedScaleAnimation(
                           child: CircleAvatar(
                              radius: 28.0,
                              backgroundImage:
                                  AssetImage('assets/user/user1.png'),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(flex: 12),
                              Text(
                                username,
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/icons/ic_verified.png',
                                scale: 4,
                              ),
                              Spacer(flex: 8),
                            ],
                          ),
                          Text(
                            '@emilithedancer',
                            style: TextStyle(
                                fontSize: 10, color: disabledTextColor),
                          ),
                          Spacer(),
                          FadedScaleAnimation(
                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage(
                                    "assets/icons/ic_fb.png",
                                  ),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_twt.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ImageIcon(
                                  AssetImage("assets/icons/ic_insta.png"),
                                  color: secondaryColor,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            locale!.comment7!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RowItem(
                                  '1.2m',
                                  locale.liked,
                                  Scaffold(
                                    appBar: AppBar(
                                      title: Text('Liked'),
                                    ),
                                    body: TabGrid(
                                      food + lol,
                                    ),
                                  )),
                              RowItem(
                                  '12.8k', locale.followers, FollowersBody(verId:userId.toString(),)),
                              RowItem(
                                  '1.9k', locale.following, FollowingBody(verId:userId.toString(),)),
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
                          Tab(
                            icon: ImageIcon(AssetImage(
                              'assets/icons/ic_like.png',
                            )),
                          ),
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
                   child: TabGrid(dance),
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),
                  FadedSlideAnimation(
                   child: TabGrid(food + lol),
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
    );
  }
}
