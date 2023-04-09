import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talngo_app/Auth/login_navigator.dart';
import 'package:talngo_app/BottomNavigation/Explore/explore_page.dart';
import 'package:talngo_app/BottomNavigation/Home/comment_sheet.dart';
import 'package:talngo_app/Components/custom_button.dart';
import 'package:talngo_app/Components/rotated_image.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import '../../Components/profile_page_button.dart';
import '../../Screens/user_profile.dart';
import 'package:share/share.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class NewsTabPage extends StatelessWidget {
  final Map<String, String> videosMap;
  final List<String> images;
  final bool isFollowing;
  final String userId;
  final int videoId;

  final int? variable;

  NewsTabPage(this.videosMap, this.images, this.isFollowing,
      {this.variable, required this.userId,
       required this.videoId
       });
       

  @override
  Widget build(BuildContext context) {
    print("video_id on news"+videoId.toString());
    return NewsTabBody(videosMap, images, isFollowing, variable,videoId);
  }
}

class NewsTabBody extends StatefulWidget {
  final Map<String, String> videos;
  final List<String> images;
  final bool isFollowing;
  final int? variable;
  final int videoId;

  NewsTabBody(this.videos, this.images, this.isFollowing, this.variable, this.videoId);

  @override
  _FollowingTabBodyState createState() => _FollowingTabBodyState();
}

class _FollowingTabBodyState extends State<NewsTabBody> {
  PageController? _pageController;

  int current = 0;
  bool isOnPageTurning = false;

  

  void scrollListener() {
    if (isOnPageTurning &&
        _pageController!.page == _pageController!.page!.roundToDouble()) {
      setState(() {
        current = _pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning &&
        current.toDouble() != _pageController!.page) {
      if ((current.toDouble() - _pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.videos);
    //loadPerson();
    _pageController = PageController();
    _pageController!.addListener(scrollListener);
  }

//   Future<Videos> loadPerson() async {
//   String jsonString =  await rootBundle.loadString('assets/videos.json');
//     var jsonData = jsonDecode(jsonString);
//     print("===>"+jsonData['video'].toString());
//     var newData=jsonData['video'];

//     var vId,vTitle,vUrl;
//     for (var i in newData)
//     {
//       vId = i['id'];
//       vTitle = i['title'];
//       vUrl = i['videoUrl'];

//     }

//   print("Video ID: "+vId.toString()+",\n Title: "+vTitle.toString()+",\n Video Url: "+vUrl.toString());
//   return Videos(id: vId, title: vTitle, videoUrl: vUrl);
// }z

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, position) {
        return VideoPage(
          widget.videos,
          widget.videos.values.toList()[position],
          widget.images[position],
          pageIndex: position,
          currentPageIndex: current,
          isPaused: isOnPageTurning,
          isFollowing: widget.isFollowing,
          videoId: widget.videoId,
        );
      },
      itemCount: widget.videos.length,
    );
  }
}

class VideoPage extends StatefulWidget {
  final Map<String, String> videosMainMap;
  final String video;
  final String image;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;
  final int?videoId;
  
  VideoPage(this.videosMainMap, this.video, this.image,
      {this.pageIndex, this.currentPageIndex, this.isPaused, this.isFollowing,  this.videoId});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with RouteAware {
  //late VideoPlayerController _controller;
  
  bool isFollowed = false;

  bool _isVideoLoading = true;
  bool initialized = false;
  bool isLiked = false;
  late String accessToken = "";
  int userId = 0;
  String fId = "";
  String username = "";
  String img = "";
  int? videoId;
  int? count;
 
  

  @override
  void initState() {
    print("video_id on video Page "+videoId.toString());
    super.initState();
    //print("video id is" + videoId.toString());
    getCredentials();
    fId = widget.videosMainMap.keys.elementAt(widget.currentPageIndex!);
     print( "bbxzxbX"+widget.video,);
    img="https://talngo.com/"+widget.video;
    _isVideoLoading = false;

    // _controller = VideoPlayerController.network(
    //   widget.video,
    // )..initialize().then((value) {
    //     setState(() {
    //       _controller.setLooping(true);
    //       initialized = true;
    //       _isVideoLoading = false;
    //     });
    //   });
  }

 Stream<bool> get followStream async* {
    yield isFollowed;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield isFollowed;
    }
  }


  void getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? '';
      userId = prefs.getInt('userId') ?? 0;
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> followUserApi() async {
    final response = await http
        .post(Uri.parse("https://talngo.com/api/follow-user"), headers: {
      "Authorization": "Bearer " + accessToken
    }, body: {
      'follower_id': fId,
      'user_id': userId.toString(),
    });
    var res = jsonDecode(response.body);
    print("Follow Response of new Tab==> ${response.body}");

    if (res["success"] == true) {
      // print('User ID: OK');
      // print('Follower ID:OK');
      Fluttertoast.showToast(
          msg: res["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.yellow);
    } else {
      Fluttertoast.showToast(
          msg: res["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

  Future<void> likeApi(userId) async {
    final response = await http
        .post(Uri.parse("https://talngo.com/api/video/${widget.videoId}/like"), body: {
      'video_id': widget.videoId.toString(),
      'user_id': userId.toString(),
    });
    print("video id +++" + widget.videoId.toString());
    var res = jsonDecode(response.body);
    print("like Api Response==> ${response.body}");

    if (res["status"] == 200) {
      
      print('user_id +++:${userId.toString()}');
      print('video_id +++: ${widget.videoId.toString()}');
       count = res['count'];
      print("count is "+count.toString());
      Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.yellow);
    } else {
      Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
    }
  }

Future<File> _getVideoFile(String videoId) async {
  final tempDir = await getTemporaryDirectory();
  final tempFilePath = '${tempDir.path}/$videoId.mp4';
  final dio = Dio();

  try {
    final response = await dio.download('https://example.com/videos/$videoId.mp4', tempFilePath);
    if (response.statusCode == 200) {
      return File(tempFilePath);
    } else {
      throw Exception('Failed to download video file');
    }
  } catch (e) {
    throw Exception('Failed to download video file: $e');
  }
}

Future<void> _shareVideo(videoId) async {
  try {
    final videoFile = await _getVideoFile(videoId);
    final url = Uri.file(videoFile.path).toString();
    await Share.shareFiles([url], text: 'Check out this video!');
  } catch (e) {
    print('Failed to share video: $e');
  }
}

  @override
  void didPopNext() {
    print("didPopNext");
    //_controller.play();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print("didPushNext");
    //_controller.pause();
    super.didPushNext();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
   // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var locale = AppLocalizations.of(context)!;
    if (widget.pageIndex == widget.currentPageIndex &&
        !widget.isPaused! &&
        initialized) {
      //_controller.play();
    } else {
      //_controller.pause();
    }
//    
// //    if (_controller.value.position == _controller.value.duration) {
// //      setState(() {
// //      });
// //    }
//     if (
//       widget.pageIndex == 2
//       ) 
    return _isVideoLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
      decoration: BoxDecoration(gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // _controller.value.isPlaying
                //     ? _controller.pause()
                //     : _controller.play();
              },
              child: Image.network(
          img,
          fit: BoxFit.cover, // adjust the image size to fit the container
        ),
              // child: _controller.value.isInitialized
              //     ? VideoPlayer(_controller)
              //     : SizedBox.shrink(),
            ),
            if (_isVideoLoading) CircularProgressIndicator(),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: -10.0,
              bottom: 80.0,
              child: Column(
                
                children: <Widget>[
                  
                  isFollowed
                      ? ProfilePageButton(locale.following, () {
                          setState(() {
                            isFollowed = false;
                          });
                        })
                      : ProfilePageButton(
                          locale.follow,
                          () {
                            setState(() {
                              isFollowed = true;
                              followUserApi();
                            });
                          },
                          color: mainColor,
                          textColor: secondaryColor,
                        ),
                  CustomButton(
                    GestureDetector(
                      onTap: () {
                        print("video id " + widget.videoId.toString());
                        likeApi(userId);
                      },
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    // like count
                    count == null ? '0' : count.toString(),
                    
                  ),
                  CustomButton(
                      ImageIcon(
                        AssetImage('assets/icons/ic_comment.png'),
                        color: secondaryColor,
                      ),
                      '287K', onPressed: () {
                        print("video iddddd"+widget.videoId.toString());
                    commentSheet(context,widget.videoId,userId);
                  }),
                  CustomButton(
                      ImageIcon(
                        AssetImage('assets/icons/ic_views.png'),
                        color: secondaryColor,
                      ),
                      'Share', onPressed: () {
                        _shareVideo('$videoId');
                    //commentSheet(context,widget.videoId,userId);
                  }),
                  CustomButton(
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                      ),
                      'Challenge', onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.view_challenge);
                    //commentSheet(context);
                  }),
                  CustomButton(
                      ImageIcon(
                        AssetImage('assets/icons/ic_explore.png'),
                        color: secondaryColor,
                      ),
                      'Explore', onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ExplorePage()));
                    //commentSheet(context,widget.videoId,userId);
                  }),
                ],
              ),
            ),
            widget.isFollowing!
                ? Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 27.0,
                    bottom: 320.0,
                    child: CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 8,
                        child: Icon(
                          Icons.add,
                          color: secondaryColor,
                          size: 12.0,
                        )),
                  )
                : SizedBox.shrink(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 60.0),
                  child: LinearProgressIndicator(
                      //minHeight: 1,
                      )),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              start: 12.0,
              bottom: 72.0,
              child: GestureDetector(
                onTap: () {
                  print("===>" +
                      widget.videosMainMap.keys
                          .elementAt(widget.currentPageIndex!));
                 // _controller.pause();
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfilePage()))
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileBody(
                              followerId: fId,
                              userId: userId.toString(),
                            )),
                  );
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '@${fId}\n',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5)),
                    TextSpan(text: locale.comment8),
                    TextSpan(
                        text: '  ${locale.seeMore}',
                        style: TextStyle(
                            color: secondaryColor.withOpacity(0.5),
                            fontStyle: FontStyle.italic))
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

