import 'package:flutter/material.dart';
import 'package:talngo_app/Auth/login_navigator.dart';
import 'package:talngo_app/BottomNavigation/Home/comment_sheet.dart';
import 'package:talngo_app/Components/custom_button.dart';
import 'package:talngo_app/Components/rotated_image.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';
import 'package:video_player/video_player.dart';

import '../Explore/explore_page.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RecomendedTabPage extends StatelessWidget {
  final List<String> videos;
  final List<String> images;
  final bool isFollowing;

  final int? variable;

  RecomendedTabPage(this.videos, this.images, this.isFollowing, {this.variable});

  @override
  Widget build(BuildContext context) {
    return RecomendedTabBody(videos, images, isFollowing, variable);
  }
}

class RecomendedTabBody extends StatefulWidget {
  final List<String> videos;
  final List<String> images;

  final bool isFollowing;
  final int? variable;

  RecomendedTabBody(this.videos, this.images, this.isFollowing, this.variable);

  @override
  _FollowingTabBodyState createState() => _FollowingTabBodyState();
}

class _FollowingTabBodyState extends State<RecomendedTabBody> {
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
    } else if (!isOnPageTurning && current.toDouble() != _pageController!.page) {
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
     print("videos are"+widget.videos.toString());
    _pageController = PageController();
    _pageController!.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemBuilder: (context, position) {
        return VideoPage(
          widget.videos[position],
          widget.images[position],
          pageIndex: position,
          currentPageIndex: current,
          isPaused: isOnPageTurning,
          isFollowing: widget.isFollowing,
        );
      },
      onPageChanged: widget.variable == null
          ? (i) async {
        if (i == 2) {
          await showModalBottomSheet(
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: transparentColor),
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(16.0))),
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.width * 1.2,
                  child: LoginNavigator());
            },
          );
        }
      }
          : null,
      itemCount: widget.videos.length,
    );
  }
}

class VideoPage extends StatefulWidget {
  final String video;
  final String image;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final bool? isFollowing;

  VideoPage(this.video, this.image,
      {this.pageIndex, this.currentPageIndex, this.isPaused, this.isFollowing});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with RouteAware {
  late VideoPlayerController _controller;
  bool initialized = false;
  bool isLiked = false;
   int? videoId;
  int userId = 0;

  @override
  void initState() {
    super.initState();
   
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((value) {
        setState(() {
          _controller.setLooping(true);
          initialized = true;
        });
      });
  }

  @override
  void didPopNext() {
    print("didPopNext");
    _controller.play();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print("didPushNext");
    _controller.pause();
    super.didPushNext();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>); //Subscribe it here
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex &&
        !widget.isPaused! &&
        initialized) {
      _controller.play();
    } else {
      _controller.pause();
    }
    var locale = AppLocalizations.of(context)!;
//    if (_controller.value.position == _controller.value.duration) {
//      setState(() {
//      });
//    }
    if (widget.pageIndex == 2) _controller.pause();
    return Container(
      decoration:  BoxDecoration(
          gradient: lGradient),
      child: Scaffold(
        backgroundColor: transparentColor,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              },
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : SizedBox.shrink(),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: -10.0,
              bottom: 80.0,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _controller.pause();
                      Navigator.pushNamed(context, PageRoutes.userProfilePage);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/disk.png'),
                    ),
    
                  ),
                  CustomButton(
                    Icon(Icons.star_border_outlined,color: Colors.white, ),
                    '1.2k',
                  ),
                  CustomButton(
                      ImageIcon(
                        AssetImage('assets/icons/ic_comment.png'),
                        color: secondaryColor,
                      ),
                      '287K', onPressed: () {
                    commentSheet(context,videoId,userId);
                  }),
                  CustomButton(
                      ImageIcon(
                        AssetImage('assets/icons/ic_views.png'),
                        color: secondaryColor,
                      ),
                      'Share', onPressed: () {
                    commentSheet(context,videoId,userId);
                  }),
                  CustomButton(
                      Icon(Icons.flash_on,color: Colors.white, ),
                      'Challenge', onPressed: () {
    
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
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '@username\n',
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
            )
          ],
        ),
      ),
    );
  }
}
