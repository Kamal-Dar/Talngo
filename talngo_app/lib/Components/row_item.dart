import 'package:flutter/material.dart';
import 'package:talngo_app/Theme/colors.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget route;

  RowItem(this.title, this.subtitle, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: 12, height: 1.5),
          children: [
            TextSpan(
              text: title + '\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: subtitle,
              style: TextStyle(fontSize: 8, color: mainColor),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
    );
  }
}
