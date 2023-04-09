import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Theme/colors.dart';

class Tournament_Page extends StatefulWidget {
  const Tournament_Page({Key? key}) : super(key: key);

  @override
  State<Tournament_Page> createState() => _Tournament_PageState();
}

class _Tournament_PageState extends State<Tournament_Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple,Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Text("Tournament", style: GoogleFonts.poppins(fontSize: 14)),
                Container(
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/coin.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle),
                              width: 25,
                              height: 25,
                              child: Align(
                                child: Container(
                                  margin: EdgeInsets.only(top: 12, left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue, shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("300K",
                            style: GoogleFonts.notoSerifGeorgian(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.square(2.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: transparentColor),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FadedSlideAnimation(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text("Daily",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCustomDialog(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 8, bottom: 8),
                                  child: Text("Open",
                                      style: GoogleFonts.poppins(fontSize: 10)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Win Big",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "More Likes, More Reward",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rewards",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/coins.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "100",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Entry Fee",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/coins.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "25",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Expires",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time,
                                                color: Colors.amberAccent,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "5h 8m",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/treasure.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 120,
                                        height: 120,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text("Weekly",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                  ),
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.5),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Container(
                height: 400,
                child: SizedBox.expand(
                  child: Container(
                    decoration:  BoxDecoration(
          gradient: lGradient), 
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          "1 left",
                                            style: GoogleFonts.poppins(fontSize: 12,)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                              child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 14,
                                          ))),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    "Task",
                                    style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Sing 'Black & White' by MJ\n and post your videos.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 12,),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.info_outline,color: Colors.grey,size: 18,),
                                    SizedBox(width: 10,),
                                    Center(child:
                                    Text("Only 5 contestent are allowed\n Result will be based on number of likes",style: GoogleFonts.poppins(fontSize: 10,)
                                    ))
                  
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rewards",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/coins.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "100",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Entry Fee",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white12,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/coins.png'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "25",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Expires",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time,
                                                color: Colors.amberAccent,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "5h 8m",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/treasure.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 120,
                                        height: 120,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              showCustomDialog(context);
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30, top: 10, bottom: 10),
                                    child: Text("Play",
                                        style: GoogleFonts.poppins(fontSize: 10)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
            );
          });
        });
  }
}
