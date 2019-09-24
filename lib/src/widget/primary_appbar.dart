import 'dart:io';

import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/images_gallery.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar({
    @required BuildContext context,
    Function onClickBackButton,
  }) : super(
          iconTheme: IconThemeData(
            color: grey, //change your color here
          ),
          title: Image(
            image: AssetImage(imgLogoSymbol),
            fit: BoxFit.contain,
            height: 30,
          ),
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: grey,
            ),
            onPressed: () {
              onClickBackButton != null
                  ? onClickBackButton()
                  : Navigator.pop(context);
            },
          ),
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
        );
}
