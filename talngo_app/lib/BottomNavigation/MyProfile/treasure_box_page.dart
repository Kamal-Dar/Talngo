import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Theme/colors.dart';

class TreasureBox extends StatelessWidget {
  const TreasureBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
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
                SizedBox(width: 20,),
                Text("Treasure Box", style: GoogleFonts.poppins(fontSize: 14)),
    
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
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text("Your Coins",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 120,right: 120),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
    
                            image: DecorationImage(
                                image: AssetImage("assets/images/coin.png"))
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text("300K",style: TextStyle(color: Colors.white),),
                    ],
                  ),
    
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                  width:250,
                  child: ElevatedButton(onPressed: (){}, child: Text("Add coins")))
            ],
          ),
        ),
      ),
    );
  }
}