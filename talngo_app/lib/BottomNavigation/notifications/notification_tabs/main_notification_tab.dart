import 'package:flutter/material.dart';

import 'Likes.dart';
import 'all_activities.dart';

class MainNotificationTab extends StatelessWidget {
  const MainNotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            color: Colors.transparent,
            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new TabBar(
                    tabs: [new Text("Opponent1"), new Text("Opponent1")],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            AllActivities(),
            Likes(),
            // Comments(),
            // mentions(),
            // Challenges(),
            // Tournaments(),
            // Followers(),
            // Treasure_Box(),
            // From_Talent(),
          ],
        ),
      ),
    );
  }
}
