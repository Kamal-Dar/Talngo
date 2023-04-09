import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Components/profile_page_button.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:http/http.dart' as http;

import '../../Screens/user_profile.dart';

class User {
  User(this.name, this.username, this.isFollowing, this.image);
  final String name;
  final String username;
  final String image;
  bool isFollowing;
}

class FollowingBody extends StatefulWidget {
  final String verId;
   const FollowingBody(
      {super.key,
      required this.verId,
      });
  @override
  _FollowingBodyState createState() => _FollowingBodyState();
}

class _FollowingBodyState extends State<FollowingBody> {
  String accessToken = "";
  String username = "";
  String name = "";
  bool isLoading = false;
  int userId = 0;
  String fId = "";
  String total_follower = "";
  String total_follwing = "";
  List<User> users = [];

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
    });
  }

  Future<void> followingApi() async {
    final response = await http.get(
        Uri.parse("https://talngo.com/api/total-followers-following-list/" +
            widget.verId..toString().trim()),
        headers: {"Authorization": "Bearer " + accessToken});
    var res = jsonDecode(response.body);
    print("Following user Response==> ${response.body}");
    print('User ID----->: $userId');
    print('access Token----->: $accessToken');

    if (res["success"] == true) {
      Map<String, dynamic> i = res['data'];
      var folloerList = i['followers'];
      var follwingList = i['followering'];
      for (var i in follwingList) {
        Map<String, dynamic> userId = i['follower'];
        //var folowerId = i['follower_id'];
        String name = userId['name'];
        setState(() {
           users.add(User(name, "@" + name, true, 'assets/user/user2.png'));
        });

        print(userId);
      }
      print("following list is==> ${follwingList.toString()}");

      print('User ID----->: $folloerList');
      print('access Token----->: $follwingList');
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
    var locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
          backgroundColor: transparentColor,
          appBar: AppBar(
            title: Text(locale.following!),
            centerTitle: true,
          ),
          body: (users.isEmpty)
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                        :FadedSlideAnimation(
           child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileBody(
                                  followerId: fId,
                                  userId: userId.toString(),
                                )),
                      );
                      Fluttertoast.showToast(
                          msg: 'user profile',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.yellow);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(users[index].image),
                      ),
                      title: Text(
                        users[index].name,
                        style: TextStyle(color: secondaryColor),
                      ),
                      subtitle: Text(
                        users[index].username,
                        style: TextStyle(color: mainColor),
                      ),
                      trailing: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: users[index].isFollowing
                            ? ProfilePageButton(
                                locale.following,
                                () {
                                  setState(() {
                                    users[index].isFollowing =
                                        !users[index].isFollowing;
                                  });
                                },
                              )
                            : ProfilePageButton(
                                locale.follow,
                                () {
                                  setState(() {
                                    users[index].isFollowing =
                                        !users[index].isFollowing;
                                  });
                                },
                                color: mainColor,
                                textColor: secondaryColor,
                              ),
                      ),
                    ),
                  );
                }),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          )),
    );
  }
}
