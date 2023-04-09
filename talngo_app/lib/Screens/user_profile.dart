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
import 'package:talngo_app/Screens/splash_Screen.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/following.dart';
import 'package:http/http.dart' as http;

import '../Auth/recover_password_page.dart';

class UserProfileBody extends StatefulWidget {
  final String followerId;

  final String userId;
  const UserProfileBody({
    super.key,
    required this.followerId,
    required this.userId,
  });

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  bool isFollowed = false;
  String accessToken = "accessToken";
  String username = "";
  String name = "";
  bool isLoading = false;
  int userId = 0;
  String total_follower = "";
  String total_follwing = "";
  int? select = 1;
  bool _show = false;
  int reportId = 3;
  int videoId = 81;

  TextEditingController descriptionController = TextEditingController();
  var tempVideoMap = new Map<String, String>();
  var videoMap = new Map<String, List<dynamic>>();
  List<String> userVedioList = [];
  var reportMap = new Map<int, String>();

  var followText;
  final key = UniqueKey();

  @override
  void initState() {
    super.initState();
    print("Folloing ID: " + widget.followerId);
    print("User ID: " + widget.userId);
    getCredentials();
    followingApi();
    reportList(userId, widget.followerId, reportId, videoId,
        descriptionController.text);
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? '';
      username = prefs.getString('username') ?? '';
      name = prefs.getString('name') ?? '';
      userId = prefs.getInt('userId') ?? 0;
      fetchVideo();
      fetchuserVideo();
    });
  }

  Future<void> followingApi() async {
    final response = await http.get(
        Uri.parse("https://talngo.com/api/total-followers-following/" +
            widget.followerId.toString().trim()),
        headers: {"Authorization": "Bearer " + accessToken});
    var res = jsonDecode(response.body);
    print("Following Response==> ${response.body}");
    print("total followers ==> ${total_follower}");
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

  fetchuserVideo() async {
    print(userId.toString());
    SmartDialog.showLoading();
    // open a bytestream
    videoMap.clear();
    try {
      final response = await http.get(Uri.parse(
          "https://talngo.com/api/get_user_video/${widget.followerId}"));
      var res = jsonDecode(response.body);
      print("fetchuserVideo Response are==> ${response.body}");
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
        setState(() {
          videoMap["followerVedios"] = userVedioList;
          //userVideo.add("https://talngo.com/" + name);
        });
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

  Future<void> followUserApi() async {
    final response = await http
        .post(Uri.parse("https://talngo.com/api/follow-user"), headers: {
      "Authorization": "Bearer " + accessToken
    }, body: {
      'follower_id': widget.followerId.toString(),
      'user_id': widget.userId.toString(),
    });
    var res = jsonDecode(response.body);
    print("Follow Response==> ${response.body}");

    if (res["status"] == 200) {
      print('User ID: OK');
      print('Follower ID:OK');
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

  fetchVideo() async {
    SmartDialog.showLoading();
    // open a bytestream
    try {
      final response =
          await http.get(Uri.parse("https://talngo.com/api/video"));

      var res = jsonDecode(response.body);
      print("user profile Response==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
          var id = i['user_id'];
          var name = i['video'];
          print('user_id is......' + id);
          setState(() {
            //followVideoMap[id.toString()] = name;
            tempVideoMap[id.toString()] = name;

            //userVideo.add("https://talngo.com/" + name);
          });
          //videos2.add("https://talngo.com/"+name);
          print("name of videos is....." + name);
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

 Future<void> report(userId, followerId, reportId, videoId, description) async {
    try {
      final response = await http.post(
          Uri.parse(
            "https://talngo.com/api/report",
          ),
          headers: {
            "Authorization": "Bearer " + accessToken
          },
          body: {
            'added_by': widget.userId,
            'report_to': widget.followerId,
            'report_type_id': reportId.toString(),
            'video_id': videoId.toString(),
            'description': description,
          });

      // print("added_by: " + userId.toString());
      // print("report_to: " + followerId.toString());
      // print("report_type_id: " + reportId.toString());
      // print("video_id: " + videoId.toString());
      // print("description: " + description);

      //print("Role: " + role);
      var res = jsonDecode(response.body);

      print("REPORT Response==> ${response.body}");
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
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
      print("error is here" + e.toString());
    }
  }

  Future<void> reportList(userId, followerId, reportId, videoId, description) async {
    try {
      final response = await http.get(
          Uri.parse(
            "https://talngo.com/api/report",
          ),
          headers: {
            "Authorization": "Bearer " + accessToken,
            "Accept": "application/json",
            "Content-Type": "application/json" 
          });

          print("accessToken: " + accessToken);
      // print("added_by: " + userId.toString());
      // print("report_to: " + followerId.toString());
      // print("report_type_id: " + reportId.toString());
      // print("video_id: " + videoId.toString());
      // print("description: " + description);

      //print("Role: " + role);
      var res = jsonDecode(response.body);
      print("REPORT List Response==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var reportListData = res["data"];
        for (var i in reportListData) {
          var id = i['id'];
          var name = i['type'];
          setState(() {
             reportMap[id]=name.toString();
             print("REPORT Map==> ${reportMap}");
          });
         

        }

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
      print("error is here" + e.toString());
    }
  }

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
                        onSelected: (dynamic value) {
                          if (value == 'Report') {
                            showModalBottomSheet(
                                backgroundColor: Colors.black,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  // <-- SEE HERE
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (BuildContext bc) {
                                  return SingleChildScrollView(
                                    child: StatefulBuilder(
                                        builder: (context, setState) {
                                      return SizedBox(
                                        height: 600,
                                        child: Container(
                                          child: Wrap(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, top: 20),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_back,
                                                          color: Colors.white,
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "Report Account",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20, left: 30),
                                                child: Text(
                                                  "Select an option",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              for (int i = 0; i < reportMap.values.length; i++)...[
                                                ListTile(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        reportMap.values.elementAt(i),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                                unselectedWidgetColor:
                                                                    Colors.grey,
                                                                disabledColor:
                                                                    Colors
                                                                        .grey),
                                                        child: Radio(
                                                            value: i,
                                                            groupValue: select,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                select = value;
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () {}),
                                                  
                                              ],
 
                                              
                                              Column(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      report(
                                                          userId,
                                                          widget.followerId,
                                                          reportId,
                                                          videoId,
                                                          descriptionController
                                                              .text);
                                                              Navigator.of(context).pop();
                                                    },
                                                    child: const Text("submit"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                });
                          }
                        },
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
                                widget.followerId.toString(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ProfilePageButton(
                                  locale.message,
                                  () => Navigator.pushNamed(
                                      context, PageRoutes.chatPage)),
                              SizedBox(width: 16),
                              isFollowed
                                  ? ProfilePageButton(locale.following, () {
                                      setState(() {
                                        isFollowed = false;
                                      });
                                    })
                                  : ProfilePageButton(
                                      locale.follow,
                                      () {
                                        setState(() {
                                          isFollowed = true;
                                          followUserApi();
                                        });
                                      },
                                      color: mainColor,
                                      textColor: secondaryColor,
                                    ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // RowItem(
                              //     '1.2m',
                              //     locale.liked,

                              //     Scaffold(
                              //       appBar: AppBar(
                              //         title: Text('Liked'),
                              //       ),
                              //       body: TabGrid(
                              //         food + lol,
                              //       ),
                              //     )),
                              RowItem(
                                  total_follower,
                                  locale.followers,
                                  FollowersBody(
                                    verId: widget.followerId,
                                  )),
                              RowItem(
                                  total_follwing,
                                  locale.following,
                                  FollowingBody(
                                    verId: widget.followerId,
                                  )),
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
                   child: TabGrid(userVedioList),
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
