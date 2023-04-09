import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Newstab extends StatefulWidget {
  const Newstab({Key? key}) : super(key: key);

  @override
  State<Newstab> createState() => _NewstabState();
}

class _NewstabState extends State<Newstab> {

  @override
  void initState() {
    super.initState();
    
      loadPerson();
    
  }

  Future<Videos> loadPerson() async {
  String jsonString =  await rootBundle.loadString('assets/videos.json');
    var jsonData = jsonDecode(jsonString);
    print("===>"+jsonData['video'].toString());
    var newData=jsonData['video'];
    
    var vId,vTitle,vUrl;
    for (var i in newData)
    {
      vId = i['id'];
      vTitle = i['title'];
      vUrl = i['videoUrl'];
  
    }
   
  
  print("Video ID: "+vId.toString()+",\n Title: "+vTitle.toString()+",\n Video Url: "+vUrl.toString());
  return Videos(id: vId, title: vTitle, videoUrl: vUrl);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Text("News"),
        ),
      ),
    );
  }
}


class Videos {
  String id='';
  String title='';
  String videoUrl='';

  Videos({required this.id, required this.title, required this.videoUrl});
}
