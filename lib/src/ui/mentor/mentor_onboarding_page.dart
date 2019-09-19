import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p4.dart';

class MentorOnboardingPage extends StatefulWidget {
  final String title;

  MentorOnboardingPage({this.title});

  @override
  MentorOnboardingPageState createState() {
    return MentorOnboardingPageState();
  }
}

class MentorOnboardingPageState extends State<MentorOnboardingPage> {
  int _slideIndex = 0;

  final List<String> images = [
    "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
    "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
  ];

  List<Color> colors = [Colors.orange];

  // final List<String> text0 = [
  //   "Hello mentor!",
  //   "Update their status",
  // ];

  // final List<String> text1 = [
  //   "App for food lovers, satisfy your taste",
  //   "Find best meals in your area, simply",
  // ];

  final IndexController controller = IndexController();
  @override
  Widget build(BuildContext context) {
    TransformerPageView transformerPageView = TransformerPageView(
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          this._slideIndex = index;
        });
        // switch (index) {
        //   case 2:
        //     {
        //       print('Last slide :$_slideIndex');
        //     }
        // }
      },
      loop: false,
      controller: controller,
      transformer:
          PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
        return Material(
          color: white,
          elevation: 8.0,
          textStyle: TextStyle(
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: space_golden_dream,
              vertical: space_heliotrope,
            ),
            // child: buildColumn(info),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: buildColumn(info),
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 0.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: space_dodger_blue,
                            height: space_dodger_blue,
                            decoration: BoxDecoration(
                              color: _slideIndex == 0 ? purple : grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: space_spring_green,
                            ),
                            child: Container(
                              width: space_dodger_blue,
                              height: space_dodger_blue,
                              decoration: BoxDecoration(
                                color: _slideIndex == 0 ? grey : purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
      itemCount: 2,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: SecondaryAppBar(
      //   pageTitle: "Shawee",
      //   context: context,
      //   onClickBackButton: () {
      //     FocusScope.of(context).requestFocus(FocusNode());
      //     Navigator.pop(context);
      //   },
      // ),
      body: transformerPageView,
    );
  }

  Column buildColumn(TransformInfo info) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _slideIndex == 0
            ? ParallaxContainer(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: H1(
                        text: "Hello mentor! ",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: P4(
                        text:
                            "This platform is focused on keeping an eye on teams participating in your hackathon. Watch and help them!",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
                          fit: BoxFit.fitWidth,
                          height: space_purple_rain,
                          placeholder: (context, photo) => Container(
                            width: space_purple_rain,
                            height: space_purple_rain,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image,
                              size: space_conifer,
                            ),
                          ),
                          errorWidget: (context, photo, error) => Container(
                            width: space_purple_rain,
                            height: space_purple_rain,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image,
                              size: space_conifer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: P4(
                        text: "Look for teams with problems",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
                          fit: BoxFit.fitWidth,
                          height: space_purple_rain,
                          placeholder: (context, photo) => Container(
                            width: space_purple_rain,
                            height: space_purple_rain,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image,
                              size: space_conifer,
                            ),
                          ),
                          errorWidget: (context, photo, error) => Container(
                            width: space_purple_rain,
                            height: space_purple_rain,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.image,
                              size: space_conifer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(space_spring_green),
                      child: P4(
                        text: "and see the ones that are going great",
                      ),
                    ),
                  ],
                ),
                position: info.position,
                opacityFactor: .8,
                translationFactor: 400.0,
              )
            : Container(),
        _slideIndex == 1
            ? ParallaxContainer(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(space_spring_green),
                        child: H1(
                          text: "Update their status",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(space_spring_green),
                        child: P4(
                          text:
                              "After mentoring a group, you can update their status, whether thei are killin'it or needing help",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(space_spring_green),
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
                            fit: BoxFit.fitWidth,
                            // width: space_magic_mint,
                            // height: space_magic_mint,
                            placeholder: (context, photo) => Container(
                              width: space_purple_rain,
                              height: space_purple_rain,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image,
                                size: space_conifer,
                              ),
                            ),
                            errorWidget: (context, photo, error) => Container(
                              width: space_purple_rain,
                              height: space_purple_rain,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image,
                                size: space_conifer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                position: info.position,
                opacityFactor: .8,
                translationFactor: 400.0,
              )
            : Container(),
      ],
    );
  }
}
