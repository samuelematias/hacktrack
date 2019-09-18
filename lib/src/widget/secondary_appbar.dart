import 'dart:io';

import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class SecondaryAppBar extends AppBar {
  SecondaryAppBar({
    @required BuildContext context,
    @required String pageTitle,
    bool hideHeaderRight = false,
    bool showHeaderLeft = false,
    Function onClickBackButton,
    Function onClickLeftButton,
  }) : super(
          iconTheme: IconThemeData(
            color: grey, //change your color here
          ),
          title: Text(
            pageTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).accentTextTheme.headline,
          ),
          leading: !hideHeaderRight
              ? IconButton(
                  icon: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    color: grey,
                  ),
                  onPressed: () {
                    onClickBackButton != null
                        ? onClickBackButton()
                        : Navigator.pop(context);
                  },
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
            showHeaderLeft
                ? IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: purple,
                    ),
                    onPressed: () {
                      onClickLeftButton != null
                          ? onClickLeftButton()
                          : Navigator.pop(context);
                    },
                  )
                : Container(),
          ],
        );
}
