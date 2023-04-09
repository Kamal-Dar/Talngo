import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
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
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 18,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Invite Friends",
                    style: GoogleFonts.poppins(fontSize: 14)),
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invite friends",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Stay connected on Talent",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          String message =
                          'Check out this amazing app! Download it now!';
                          await Share.share(message);
                        },
                        child: Text(
                          "invite",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        image: DecorationImage(
                            image: AssetImage("assets/icons/call.png"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Contacts",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Find your contacts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "invite",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage("assets/icons/face.png"),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Facebook friend",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Find friends on facebook",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "invite",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
