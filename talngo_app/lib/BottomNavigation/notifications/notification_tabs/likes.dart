import 'package:flutter/material.dart';

class Likes extends StatelessWidget {
  const Likes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20,top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("assets/images/p2.jpg"),
              ),
              Text(
                "Name 1",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("assets/images/p2.jpg"),
              ),
              Text(
                "Name 1",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("assets/images/p2.jpg"),
              ),
              Text(
                "Name 1",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("assets/images/p2.jpg"),
              ),
              Text(
                "Name 1",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
         padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("assets/images/p2.jpg"),
              ),
              Text(
                "Name 1",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
