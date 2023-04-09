import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talngo_app/Components/entry_field.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:http/http.dart' as http;

class Comment {
  final String? image;
  final String? name;
  final String? comment;
  final String? time;

  String? Comments;

  Comment({this.image, this.name, this.comment, this.time});
}

List<Comment> comments = [];
bool _isLoading = true;

Future<void> getcommentApi(videoId) async {
  final response = await http.get(Uri.parse(
      "https://talngo.com/api/get_video_all_comments/" + videoId.toString()));
  var res = jsonDecode(response.body);
  print("get comment Api Response==> ${response.body}");
  print("viddeo id to get==> " + videoId.toString());

  if (res["success"] == true) {
    var commentData = res["data"];
    for (var i in commentData) {
      var commentId = i['id'];
      var video_id = i['video_id'];
      var comment = i['comment'];
      var email = i['email'];
      var created_at = i['created_at'];
      var updated_at = i['updated_at'];
      var userImage = i['profile_pic'];
      var userName = i['User_Name'];
      

      print("commentId ==> " + commentId.toString());
      print("comment ==> " + comment.toString());
      print("video_id ==> " + video_id.toString());
      print("email ==> " + email.toString());
      print("created_at ==> " + created_at.toString());
      print("updated_at ==> " + updated_at.toString());
      print("Image ==> " + "https://talngo.com/uploads/images/profile/"+userImage.toString());

      comments.add(
        Comment(
            image: 'assets/user/user1.png',
            name: userName,
            comment: comment.toString()+"\n",
            time: created_at.toString()
            ),
      );
    }
    _isLoading = false;
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

Future<void> commentApi(int videoId, userId, String comments) async {
  final response =
      await http.post(Uri.parse("https://talngo.com/api/video-comment"), body: {
    'video_id': videoId.toString(),
    'added_by': userId.toString(),
    'comment': comments,
  });
  var res = jsonDecode(response.body);
  print("comment Api Response==> ${response.body}");

  if (res["status"] == 200) {
    print('added_by +++:${userId.toString()}');
    print('video_id +++: ${videoId.toString()}');
    print('comment +++: $comments');
    Fluttertoast.showToast(
        msg: res["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.yellow);
  } else {
    Fluttertoast.showToast(
        msg: res["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }
}

void commentSheet(
  BuildContext context,
  videoId,
  userId,
) async {
  comments.clear();
  getcommentApi(videoId);

  var locale = AppLocalizations.of(context)!;

  TextEditingController _commentController = TextEditingController();
 File?userImage;
 String userName;
  

 
   await showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          borderSide: BorderSide.none),
      context: context,
      builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: <Widget>[
                FadedSlideAnimation(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          locale.comments!,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: lightTextColor),
                        ),
                      ),
                      Expanded(
                        child: _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 60.0),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Divider(
                                    color: darkColor,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    leading: Image.asset(
                                      comments[index].image!,
                                      scale: 2.3,
                                    ),
                                    title: Text(comments[index].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                height: 2,
                                                color: disabledTextColor)),
                                    subtitle: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: comments[index].comment,
                                        ),
                                        TextSpan(
                                            text: comments[index].time,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                      ]),
                                    ),
                                    trailing: ImageIcon(
                                      AssetImage('assets/icons/ic_like.png'),
                                      color: disabledTextColor,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: EntryField(
                    counter: null,
                    controller: _commentController,
                    padding: EdgeInsets.zero,
                    hint: locale.writeYourComment,
                    fillColor: darkColor,
                    prefix: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.webp'),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        int vId;
                        commentApi(
                            videoId!, userId, _commentController.text.toString());
                      },
                      child: Icon(
                        Icons.send,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
}
