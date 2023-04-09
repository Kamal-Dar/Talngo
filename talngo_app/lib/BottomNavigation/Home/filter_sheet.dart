import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:talngo_app/Components/entry_field.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Theme/colors.dart';

class Filter {
  final String? name;
  final bool? selected;


  Filter({this.name,this.selected});
}

void FilterSheet(BuildContext context) async {
  var locale = AppLocalizations.of(context)!;
  final bool isSelectedFilter;

  List<Filter> filter = [
    Filter(
      name: 'All',
      selected: true
    ),
    Filter(
      name: 'Recent',
        selected: false
    ),
    Filter(
      name: 'Top Rated',
        selected: false
    ),
    Filter(
      name: 'Voting Open',
        selected: false
    ),
    Filter(
      name: 'Voting Closed',
        selected: false
    ),


  ];

  await
  showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          borderSide: BorderSide.none),
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Stack(
          children: <Widget>[
            FadedSlideAnimation(
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Expanded(
                    child:
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 10.0),
                        itemCount: filter.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[

                              ListTile(

                                title: Text(filter[index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        height: 2,
                                        color: disabledTextColor)),

                                trailing: filter[index].selected! ? Icon(Icons.check,color: Colors.white): SizedBox.shrink(),
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),

          ],
        ),
      ));
}
