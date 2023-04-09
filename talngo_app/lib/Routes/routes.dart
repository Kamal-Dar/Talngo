import 'package:flutter/material.dart';
import 'package:talngo_app/Auth/login_navigator.dart';
import 'package:talngo_app/BottomNavigation/Explore/more_page.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/badge_request.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/language_page.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/video_option.dart';
import 'package:talngo_app/BottomNavigation/bottom_navigation.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/add_video.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/add_video_filter.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/followers.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/help_page.dart';
import 'package:talngo_app/BottomNavigation/AddVideo/post_info.dart';
import 'package:talngo_app/BottomNavigation/Explore/search_users.dart';
import 'package:talngo_app/BottomNavigation/MyProfile/tnc.dart';
import 'package:talngo_app/Chat/chat_page.dart';
import 'package:talngo_app/Screens/user_profile.dart';

import '../Auth/create_new_password.dart';
import '../Auth/create_username_page.dart';
import '../BottomNavigation/Home/Challenges_Category.dart';
import '../BottomNavigation/Home/play_random_challenge.dart';
import '../BottomNavigation/Home/upload_challenges.dart';
import '../BottomNavigation/Home/upload_random_challenge.dart';
import '../BottomNavigation/Home/viewChallenge.dart';
import '../BottomNavigation/MyProfile/edit_profile_page.dart';
import '../BottomNavigation/MyProfile/invite_friend.dart';
import '../BottomNavigation/MyProfile/main_profile_page.dart';
import '../BottomNavigation/MyProfile/my_profile_page.dart';
import '../BottomNavigation/MyProfile/treasure_box_page.dart';
import '../Chat/chat_note.dart';
import '../Chat/jimmy_chat.dart';

class PageRoutes {
  static const String loginNavigator = 'login_navigator';
  static const String bottomNavigation = 'bottom_navigation';
  static const String followersPage = 'followers_page';
  static const String helpPage = 'help_page';
  static const String tncPage = 'tnc_page';
  static const String searchPage = 'search_page';
  static const String addVideoPage = 'add_video_page';
  static const String addVideoFilterPage = 'add_video_filter_page';
  static const String postInfoPage = 'post_info_page';
  static const String userProfilePage = 'user_profile_page';
  static const String my_ProfilePage = 'my_profile_page';
  static const String chatPage = 'chat_page';
  static const String morePage = 'more_page';
  static const String videoOptionPage = 'video_option_page';
  static const String verifiedBadgePage = 'verified_badge_page';
  static const String languagePage = 'language_page';
  static const String playRandom = 'playRandom';
  static const String uploadRandom = 'uploadRandom';
  static const String uploadChallenge = 'uploadChallenge';
  static const String view_challenge = 'view_challenge';
  static const String challenge_category = 'challenge_category';
  static const String main_profile_page = 'main_profile_page';
  static const String edit_profile_page = 'edit_profile_page';
  static const String create_new_password = 'create_new_password';
  static const String create_username = 'create_username';
  static const String treasure_page = 'treasure_page';
  static const String invite_friend_page = 'invite_friend_page';
  static const String chat_note_page = 'chat_note_page';
  static const String jimmy_chat_page = 'jimmy_chat_page';
  

  Map<String, WidgetBuilder> routes() {
    return {
      loginNavigator: (context) => LoginNavigator(),
      bottomNavigation: (context) => BottomNavigation(),
      followersPage: (context) => FollowersBody(verId: "",),
      helpPage: (context) => HelpPage(),
      tncPage: (context) => TnC(),
      searchPage: (context) => SearchUsers(),
      addVideoPage: (context) => AddVideo(),
      addVideoFilterPage: (context) => AddVideoFilter(),
      postInfoPage: (context) => PostInfo(),
      userProfilePage: (context) => UserProfileBody(followerId: "",userId: ""),
      my_ProfilePage: (context) => MyProfilePage(),
      chatPage: (context) => ChatPage(),
      morePage: (context) => MorePage(),
      videoOptionPage: (context) => VideoOptionPage(),
      verifiedBadgePage: (context) => BadgeRequest(),
      languagePage: (context) => ChangeLanguagePage(),
      playRandom: (context) => PlayRandomPage(),
      uploadRandom: (context) => UploadRandomPage(),
      uploadChallenge: (context) => UploadChallengePage(),
      view_challenge: (context) => View_Challenge(),
      challenge_category: (context) => Challenges_Category(),
      main_profile_page: (context) => MainProfilePage(),
      edit_profile_page: (context) => Edit_Profile(/*videos: [],*/),
      create_new_password: (context) => CreateNewPassword(),
      create_username: (context) => CreateUserName(),
      treasure_page: (context) => TreasureBox(),
      invite_friend_page: (context) => InviteFriends(),
      chat_note_page: (context) => ChatNote(),
      jimmy_chat_page: (context) => JimmyChat(),
    };
  }
}
