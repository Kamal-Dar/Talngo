import 'package:flutter/material.dart';

import '../../Theme/colors.dart';

class ThumbsUp extends StatefulWidget {
  const ThumbsUp({super.key});

  @override
  State<ThumbsUp> createState() => _ThumbsUpState();
}

class _ThumbsUpState extends State<ThumbsUp> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
      ),
    );
  }
}