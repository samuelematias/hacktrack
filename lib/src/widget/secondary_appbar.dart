import 'dart:io';

import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class SecondaryAppBar extends AppBar {
  SecondaryAppBar({
    @required BuildContext context,
    @required String pageTitle,
    bool hideHeaderLeft = false,
    bool customHeaderLeft = false,
    bool showHeaderRight = false,
    Function onClickBackButton,
    Function onClickCustomHeaderLeft,
    Function onClickHeaderRight,
    IconData iconHeaderLeft = Icons.highlight_off,
    IconData iconHeaderRight = Icons.refresh,
    Color iconHeaderRightColor = const Color(0xff3071ff),
  }) : super(
          iconTheme: IconThemeData(
            color: grey, //change your color here
          ),
          title: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).accentTextTheme.headline,
          ),
          leading: !hideHeaderLeft
              ? Row(
                  children: <Widget>[
                    customHeaderLeft
                        ? IconButton(
                            icon: Icon(
                              iconHeaderLeft,
                              color: red,
                            ),
                            onPressed: () => onClickCustomHeaderLeft(),
                          )
                        : IconButton(
                            icon: Icon(
                              Platform.isIOS
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_back,
                              color: grey,
                            ),
                            onPressed: () {
                              onClickBackButton != null
                                  ? onClickBackButton()
                                  : Navigator.pop(context);
                            },
                          )
                  ],
                )
              : Container(),
          centerTitle: true,
          brightness: Brightness.light,
          backgroundColor: white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(
              color: grey,
              height: 2,
              alignment: Alignment.center,
            ),
          ),
          actions: [
            showHeaderRight
                ? IconButton(
                    icon: Icon(
                      iconHeaderRight,
                      color: iconHeaderRightColor,
                    ),
                    onPressed: () {
                      onClickHeaderRight != null
                          ? onClickHeaderRight()
                          : Navigator.pop(context);
                    },
                  )
                : Container(),
          ],
        );
}
