import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:talngo_app/Components/entry_field.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';



void RandomDialog(BuildContext context) async {


  await Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      height: 300.0,
      width: 300.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.all(15.0),
            child: Text('Cool', style: TextStyle(color: Colors.red),),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Awesome', style: TextStyle(color: Colors.red),),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          },
              child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),))
        ],
      ),
    ),
  );
}
