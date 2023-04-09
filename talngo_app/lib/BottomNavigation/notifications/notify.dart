import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Chat/chat_note.dart';

import '../../Routes/routes.dart';
import '../../Theme/colors.dart';
import 'notification_tabs/Likes.dart';
import 'notification_tabs/all_activities.dart';
import 'notification_tabs/challenges.dart';
import 'notification_tabs/tornaments.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);
  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  String dropdownValue = 'All activities';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Container(
        decoration: BoxDecoration(gradient: lGradient),
        child: Scaffold(
            backgroundColor: transparentColor,
            appBar:  PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  flexibleSpace:  Container(
                    color: Colors.transparent,
                    child:  SafeArea(
                      child: Column(
                        children: <Widget>[
                           Expanded(child:  Container()),
                          Container(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child:  TabBar(
                                tabs: [
                                   DropdownButton<String>(
                                    // Step 3.
                                    isExpanded: true,
                                    value: dropdownValue,
                                    selectedItemBuilder: (BuildContext context) {
                                      return <String>[
                                        'All activities',
                                        'Likes',
                                        'Challenges',
                                        '@ mentions',
                                        'Tournaments',
                                        'Followers',
                                        'treasure Box',
                                        'From Talent',
                                      ].map((String value) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            dropdownValue,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    iconEnabledColor: Colors.white,
                                    // Step 4.
                                    items: <String>[
                                      'All activities',
                                      'Likes',
                                      'Challenges',
                                      '@ mentions',
                                      'Tournaments',
                                      'Followers',
                                      'treasure Box',
                                      'From Talent',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      );
                                    }).toList(),
                                    // Step 5.
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      // Navigator.of(context).pop();
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: (){
                        print("Chat Clicked...");
                        Navigator.pushNamed(
                                  context, PageRoutes.chat_note_page);
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatNote()));
                      },
                      child: Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // ignore: unnecessary_new
            body: new TabBarView(children: [
              if (dropdownValue.toString() == "All activities") ...[
                AllActivities(),
              ] else if (dropdownValue.toString() == "Likes") ...[
                Likes(),
              ] else if (dropdownValue.toString() == "Challenges") ...[
                
                ChallengesNotify(),
              ]else if (dropdownValue.toString() == "Tournaments") ...[
                
                TornamentScreen(),
              ]  
              else ...[
                Center(
                  child: Text(
                    dropdownValue,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ])),
      ),
    );
  }

  void firstLevel() {
    switch (dropdownValue) {
      case 'All activities':
        {
          AllActivities();
        }
        break;

      case 'Likes':
        {
          Likes();
        }
        break;
      case 'ChallengesNotify':
        {
          print("IN");
          ChallengesNotify();
        }
        break;
        case 'Tournaments':
        {
          print("IN");
          TornamentScreen();
        }
        break;
      default:
        {
          Notify();
        }
        break;
    }
  }
}
