import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p4.dart';
import '../../util/metrics.dart';
import '../../widget/primary_button.dart';

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

  List<Color> colors = [Colors.orange];

  final IndexController controller = IndexController();
  @override
  Widget build(BuildContext context) {
    TransformerPageView transformerPageView = TransformerPageView(
      pageSnapping: true,
      onPageChanged: (index) {
        setState(() {
          this._slideIndex = index;
        });
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
      body: transformerPageView,
    );
  }

  Column buildColumn(TransformInfo info) {
    return Column(
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
                  height: Metrics.ph(context, 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
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
                                placeholder: (context, photo) => Container(
                                  width: space_purple_rain,
                                  height: space_purple_rain,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.image,
                                    size: space_conifer,
                                  ),
                                ),
                                errorWidget: (context, photo, error) =>
                                    Container(
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
                      PrimaryButton(
                        label: "Start mentoring",
                        onPress: () {},
                      )
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
