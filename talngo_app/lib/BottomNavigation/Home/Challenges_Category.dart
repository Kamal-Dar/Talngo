import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:talngo_app/Extension/extensions.dart';

import '../../Components/tab_grid.dart';
import '../../Components/thumb_list.dart';
import '../../Locale/locale.dart';
import '../../Routes/routes.dart';
import '../../Theme/colors.dart';
import '../Explore/explore_page.dart';
import '../Explore/more_page.dart';

List<String> dance = [
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
  'assets/thumbnails/dance/Layer 951.png',
  'assets/thumbnails/dance/Layer 952.png',
  'assets/thumbnails/dance/Layer 953.png',
  'assets/thumbnails/dance/Layer 954.png',
];
List<String> lol = [
  'assets/thumbnails/lol/Layer 978.png',
  'assets/thumbnails/lol/Layer 979.png',
  'assets/thumbnails/lol/Layer 980.png',
  'assets/thumbnails/lol/Layer 981.png',
];
List<String> food = [
  'assets/thumbnails/food/Layer 783.png',
  'assets/thumbnails/food/Layer 784.png',
  'assets/thumbnails/food/Layer 785.png',
  'assets/thumbnails/food/Layer 786.png',
  'assets/thumbnails/food/Layer 787.png',
  'assets/thumbnails/food/Layer 788.png',
];

List<String> carouselImages = [
  "assets/images/banner 1.png",
  "assets/images/banner 2.png",
//  "assets/images/banner 1.png",
//  "assets/images/banner 2.png",
];
class User {
  User(this.name, this.id, this.img);
  String name;
  String id;
  String img;
}
class Challenges_Category extends StatefulWidget {
  const Challenges_Category({Key? key}) : super(key: key);

  @override
  State<Challenges_Category> createState() => _Challenges_CategoryState();
}

class _Challenges_CategoryState extends State<Challenges_Category> {
  final List<ThumbList> thumbLists = [
    ThumbList(dance),
    ThumbList(lol),
    ThumbList(food),
    ThumbList(dance),
    ThumbList(lol),
    ThumbList(food),
  ];

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<TitleRow> titleRows = [
      TitleRow("Challenges by User", '159.8k', dance),
      TitleRow("Hashtag Challenges", '108.9k', lol),
      TitleRow(locale.followUr, '159.8k', food),

    ];

    var _controller = TextEditingController();
    List<User> names = [
      User("Food Master", "@georgesmith", "assets/user/user1.png"),
      User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
      User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
      User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
      User("Opus Labs", "@opuslabs", "assets/user/user1.png"),
      User("Ling Tong", "@lingtong", "assets/user/user2.png"),
      User("Tosh Williamson", "@toshwilliamson", "assets/user/user3.png"),
      User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
      User("Food Master", "@georgesmith", "assets/user/user1.png"),
      User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
      User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
      User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
    ];

    return DefaultTabController(
      length: 3,
      child: Container(
        decoration:  BoxDecoration(
          gradient: lGradient),
        child: Scaffold(
          backgroundColor: transparentColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(66.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    decoration: BoxDecoration(
                      color: darkColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          icon: IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: secondaryColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            color: secondaryColor,
                            onPressed: () {
                              _controller.clear();
                            },
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child:
                    TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Colors.white, width: 2),
      
                      ),
                      isScrollable: true,
                      labelColor: Colors.white,
                      unselectedLabelColor: disabledTextColor,
                      tabs: <Widget>[
                        Tab(text: "All"),
                        Tab(text: "Challenges by User"),
                        Tab(text: "Hashtag Challenges"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              FadedSlideAnimation(
               child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Stack(
                      children: [
                        CarouselSlider(
                          items: carouselImages.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      child: FadedScaleAnimation(child: Image.asset(i))),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              aspectRatio: 3,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          end: 20.0,
                          bottom: 0.0,
                          child: Row(
                            children: carouselImages.map((i) {
                              int index = carouselImages.indexOf(i);
      
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Color.fromRGBO(0, 0, 0, 0.9)
                                      : disabledTextColor.withOpacity(0.5),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: titleRows.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              titleRows[index],
                              thumbLists[index],
                            ],
                          );
                        }),
                  ],
                ),
                beginOffset: Offset(0, 0.3),
                endOffset: Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
              ),
              FadedSlideAnimation(
               child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: names.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Divider(
                            color: darkColor,
                            height: 1.0,
                            thickness: 1,
                          ),
                          ListTile(
                            leading: FadedScaleAnimation(
                             child: CircleAvatar(
                                backgroundColor: darkColor,
                                backgroundImage: AssetImage(names[index].img),
                              ),
                            ),
                            title: Text(
                              names[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(names[index].id),
                            onTap: () => Navigator.pushNamed(
                                context, PageRoutes.userProfilePage),
                          ),
                        ],
                      );
                    }),
                beginOffset: Offset(0, 0.3),
                endOffset: Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
              ),
              FadedSlideAnimation(
               child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: names.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Divider(
                            color: darkColor,
                            height: 1.0,
                            thickness: 1,
                          ),
                          ListTile(
                            leading: FadedScaleAnimation(
                             child: CircleAvatar(
                                backgroundColor: darkColor,
                                backgroundImage: AssetImage(names[index].img),
                              ),
                            ),
                            title: Text(
                              names[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(names[index].id),
                            onTap: () => Navigator.pushNamed(
                                context, PageRoutes.userProfilePage),
                          ),
                        ],
                      );
                    }),
                beginOffset: Offset(0, 0.3),
                endOffset: Offset(0, 0),
                slideCurve: Curves.linearToEaseOut,
              )
            ],
          ),
        ),
      ),
    );

  }
}

class TitleRow extends StatelessWidget {
  final String? title;
  final String subTitle;
  final List list;

  TitleRow(this.title, this.subTitle, this.list);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: darkColor,
          child: Text(
            '#',
            style: TextStyle(color: mainColor),
          ),
        ),
        title: Text(
          title!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Row(
          children: <Widget>[
            Text(
              subTitle + ' ' + AppLocalizations.of(context)!.video!,
              style: Theme.of(context).textTheme.caption,
            ),
            Spacer(),
            Text(
              "${AppLocalizations.of(context)!.viewAll}",
              style: Theme.of(context).textTheme.caption,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: secondaryColor,
              size: 10,
            ),
          ],
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MorePage(
                title: title,
                list: list,
              )),
        ));
  }
}
