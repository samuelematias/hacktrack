import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/metrics.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';

class StatusUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Team Fire",
        context: context,
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    double leftOverFlow = -5.0;
    double rightOverFlow = -5.0;
    double bottomOverFlow = 0.0;
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                width: Metrics.fullWidth(context),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: space_conifer,
                        top: space_golden_dream,
                        right: space_conifer,
                      ),
                      child: H4(
                        text: "Update your status",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showPicker(context),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: space_golden_dream,
                          top: space_golden_dream,
                          right: space_golden_dream,
                        ),
                        height: space_portage,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: space_dodger_blue,
                                    ),
                                    child: H4(
                                      text: "Problem",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: space_dodger_blue,
                                    ),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  left: leftOverFlow,
                  right: rightOverFlow,
                  bottom: bottomOverFlow,
                  child: PrimaryButton(
                    label: "Update",
                    onPress: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _showPicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            children: <Widget>[
              H4(
                text: "Ideation",
              ),
              H4(
                text: "Problem Definition",
              ),
            ],
            itemExtent: 30, //height of each item
            looping: false,
            onSelectedItemChanged: (int index) {
              // selectitem = index;
            },
          ),
        );
      },
    );
  }
}
