import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class Metrics {
  static double pw(BuildContext context, double w) {
    var queryData = MediaQuery.of(context);
    double width = queryData.size.width;
    double vw = width / 100;

    return w * vw; // percent width
  }

  static double ph(BuildContext context, double h) {
    var queryData = MediaQuery.of(context);
    double height = queryData.size.height;
    double vh = height / 100;

    return h * vh; // percent height
  }

  static double size(BuildContext context, double s) {
    var queryData = MediaQuery.of(context);
    double pixelRatio = queryData.devicePixelRatio;
    double width = queryData.size.width;
    double vw = width / 100;

    double returnSize;
    if (Platform.isIOS) {
      if (pixelRatio == 2 && vw == 3.2) {
        // 5, SE
        returnSize = s * 1;
      } else if (pixelRatio == 2 && vw == 3.75) {
        // 6, 7, 8
        returnSize = s * 1.1;
      } else if (pixelRatio == 2 && vw == 4.14) {
        // XR
        returnSize = s * 1.2;
      } else if (pixelRatio == 3 && vw == 4.14) {
        // 6, 7, 8 plus
        returnSize = s * 1.2;
      } else if (pixelRatio == 3 && vw == 3.75) {
        // X, XS
        returnSize = s * 1.2;
      } else if (pixelRatio == 3 && vw == 4.14) {
        // XS Max
        returnSize = s * 1.3;
      } else {
        returnSize = s * 1;
      }
    }
    if (Platform.isAndroid) {
      if (pixelRatio <= 1) {
        returnSize = s * 0.9;
      } else if (pixelRatio <= 1.5) {
        returnSize = s * 1;
      } else if (pixelRatio <= 2) {
        returnSize = s * 1.1;
      } else if (pixelRatio <= 3) {
        returnSize = s * 1.2;
      } else if (pixelRatio <= 3.5) {
        returnSize = s * 1.3;
      } else {
        returnSize = s * 1.1;
      }
    }
    return returnSize;
  }
}
