import 'package:flutter/material.dart';

import 'metrics.dart';

class CustomModal extends PageRouteBuilder {
  CustomModal({
    @required BuildContext context,
    @required Widget modalContent,
    double overlayHeight = 50.0,
  }) : super(
          opaque: false,
          // Slide animation
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 2.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Scaffold(
                backgroundColor: Colors.black45,
                body: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(4),
                        topRight: const Radius.circular(4),
                      ),
                    ),
                    margin: EdgeInsetsDirectional.only(
                      top: Metrics.ph(context, overlayHeight),
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        modalContent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
