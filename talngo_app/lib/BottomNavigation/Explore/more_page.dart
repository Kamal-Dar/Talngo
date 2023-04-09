import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talngo_app/Components/tab_grid.dart';
import 'package:talngo_app/Theme/colors.dart';

class MorePage extends StatelessWidget {
  final String? title;
  final List? list;

  MorePage({this.title, this.list});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:  BoxDecoration(
          gradient: lGradient),
        child: Scaffold(
          backgroundColor: transparentColor,
            appBar: AppBar(
              title: Text(title!),
            ),
            body: FadedSlideAnimation(
             child: TabGrid(list),
              beginOffset: Offset(0.3, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            )),
      ),
    );
  }
}
