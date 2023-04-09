import 'dart:convert';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/BottomNavigation/Home/play_random_challenge.dart';
import 'package:talngo_app/BottomNavigation/Home/random_challenge_dialog.dart';
import 'package:talngo_app/Components/custom_button.dart';

import '../../Components/rotated_image.dart';
import '../../Locale/locale.dart';
import '../../Routes/routes.dart';
import '../../Theme/colors.dart';
import '../tournament/tournament_screen.dart';
import 'challenge_video_tab.dart';
import 'comment_sheet.dart';
import 'filter_sheet.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class Challenges_tab extends StatefulWidget {
  final int userId;
  final int videoId;
  const Challenges_tab({Key? key, required this.userId, required this.videoId})
      : super(key: key);

  @override
  State<Challenges_tab> createState() => _Challenges_tabState();
}

class _Challenges_tabState extends State<Challenges_tab> {
  late int selectedRadio;
  var search_controller = TextEditingController();

  int userId = 0;
  var challengeVideoMap = Map<String, List<dynamic>>();
  var Heading;
   var ChallengeId;
  var ChallengerId;
  var CompetetorId;
  var challengerVidId;
  var CometetorrVidId;

  bool isLiked = false;
  bool _isLiked = false;
  List<String> challengeVedioList = [];

  final List<String> _radioText = [
    'Play a Random Challange',
    'Upload a Random Challenge'
  ];

  @override
  void initState() {
    super.initState();
    fetchChallengeVideo();
    getCredentials();
    selectedRadio = 0;
  }

  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? 0;
      //username = prefs.getString('username') ?? '';
    });
  }

  fetchChallengeVideo() async {
    SmartDialog.showLoading();
    // open a bytestream
    try {
      final response =
          await http.get(Uri.parse("https://talngo.com/api/all-challenge"));

      var res = jsonDecode(response.body);
      print("challenge Response==> ${response.body}");
      if (res["success"] == true) {
        SmartDialog.dismiss();
        var videoArray = res["data"];
        for (var i in videoArray) {
           ChallengeId = i['id'];
          ChallengerId = i['challenger_id'];
          CompetetorId = i['competitor_id'];
          challengerVidId = i['challenger_video_id'];
          CometetorrVidId = i['competitor_video_id'];
          Heading = i['heading'];
           challengeVedioList.add(ChallengeId.toString());
            challengeVedioList.add(ChallengerId.toString());
            challengeVedioList.add(CompetetorId.toString());
            challengeVedioList.add(challengerVidId.toString());
            challengeVedioList.add(CometetorrVidId.toString());
            challengeVedioList.add(Heading.toString());
            print('challenger_id is......>>' + ChallengerId.toString());
          print('competitor_id is......>>' + CompetetorId.toString());
          print('challenger_video_id is.....>>.' + challengerVidId.toString());
          print('competitor_video_id is......>>' + CometetorrVidId.toString());
          print('heading is......>>' + Heading.toString());
           challengeVideoMap[ChallengeId] = challengeVedioList;
            print('---==>' + challengeVideoMap.entries.toString());
            print('Video map: ${jsonEncode(challengeVideoMap)}');
         
           setState(() {
            //challengeVedioList.add('assets/thumbnails/dance/Layer 951.png');
           
           
          
          });
           
          
        }

        print("user id : ==>" + userId.toString());
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: search_controller,
                      decoration: InputDecoration(
                          icon: IconButton(
                            icon: Icon(Icons.mic),
                            color: Colors.grey,
                            onPressed: () => Navigator.pop(context),
                          ),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.grey,
                            onPressed: () {
                              search_controller.clear();
                            },
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(children: <Widget>[
            FadedSlideAnimation(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 20, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        for(var i in challengeVideoMap.entries)...[

                                ],
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: Text("${Heading.toString()}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              textStyle: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p2.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 100,
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChallengeVideoTab(
                                                                      videos1,
                                                                      imagesInDisc1,
                                                                      false,
                                                                      variable:
                                                                          1)));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/icons/transparent_play.png'),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              // Container(
                                              //   width: 20,
                                              //   height: 20,
                                              //   decoration: BoxDecoration(

                                              //       color: Colors.white,
                                              //       image: DecorationImage(
                                              //         image: AssetImage(
                                              //             'assets/images/p2.jpg'),
                                              //         fit: BoxFit.cover,
                                              //       ),
                                              //       borderRadius: BorderRadius.circular(30)),

                                              // ),
                                              // SizedBox(width: 5),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isLiked =
                                                                !isLiked; // toggle the like state
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.thumb_up,
                                                          color: isLiked
                                                              ? Colors.blue
                                                              : Colors
                                                                  .grey, // set color based on like state
                                                        ),
                                                      ),
                                                      Text(
                                                        "25",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("@$userId",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("VS",
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              textStyle: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/p3.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 100,
                                            height: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChallengeVideoTab(
                                                                      videos1,
                                                                      imagesInDisc1,
                                                                      false,
                                                                      variable:
                                                                          1)));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/icons/transparent_play.png'),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                             Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _isLiked =
                                                                !_isLiked; // toggle the like state
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.thumb_up,
                                                          color: 
                                                          _isLiked
                                                              ? Colors.blue
                                                              : Colors
                                                                  .grey, // set color based on like state
                                                        ),
                                                      ),
                                                      Text(
                                                        "25",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                   SizedBox(
                                                width: 5,
                                              ),
                                              Text("@$CompetetorId",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Text("Voting Open",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                textStyle: TextStyle(
                                                    color: Colors.white)))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                         ],
                    )),
                    Container(
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: -10.0,
              bottom: (MediaQuery.of(context).size.width / 1.5),
              child: Column(
                children: <Widget>[
                  CustomButton(
                      Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                      'Filter', onPressed: () {
                    FilterSheet(context);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    Icon(
                      Icons.account_tree,
                      color: Colors.white,
                    ),
                    'Tournament',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Tournament_Page()));
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      Icon(
                        Icons.grid_view_sharp,
                        color: Colors.white,
                      ),
                      'Random\nChallenges', onPressed: () {
                    showCustomDialog(context);
                  }),
                ],
              ),
            )
          ])),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          selectedRadio = -1;
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Container(
                height: 240,
                child: SizedBox.expand(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("What do you want to do? ",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    textStyle: TextStyle(color: Colors.white))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.grey,
                              disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 0,
                              groupValue: selectedRadio,
                              title: Text("Play a Random Challange",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white)),
                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.grey,
                              disabledColor: Colors.grey,
                            ),
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadio,
                              title: Text("Upload a Random Challenge",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.white)),
                              onChanged: (dynamic val) {
                                setState(() {
                                  selectedRadio = val;
                                });
                              },
                              activeColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedRadio == 0) {
                                  Navigator.pushNamed(
                                      context, PageRoutes.playRandom);
                                } else if (selectedRadio == 1) {
                                  Navigator.pushNamed(
                                      context, PageRoutes.uploadChallenge);
                                }
                              },
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: Text("Next",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            textStyle: TextStyle(
                                                color: Colors.white)))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    gradient: lGradient,
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          });
        });
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
}
