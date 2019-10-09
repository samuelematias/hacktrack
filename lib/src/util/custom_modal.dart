import 'package:flutter/material.dart';

import 'metrics.dart';

class CustomModal extends PageRouteBuilder {
  CustomModal({
    @required BuildContext context,
    @required Widget modalContent,
    double overlayHeight = 50.0,
    double modalContentHeight,
    double modalContentWidth,
    double modalContentBottomLeft = 0.0,
    double modalContentBottomRight = 0.0,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useFade = false,
  }) : super(
          opaque: false,
          transitionDuration: transitionDuration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            if (useFade) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            } else {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 2.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            }
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
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(modalContentBottomLeft),
                            bottomRight:
                                Radius.circular(modalContentBottomRight),
                          ),
                        ),
                        margin: EdgeInsetsDirectional.only(
                          top: Metrics.ph(context, overlayHeight),
                        ),
                        height: modalContentHeight != null
                            ? modalContentHeight
                            : MediaQuery.of(context).size.height,
                        width: modalContentWidth != null
                            ? modalContentWidth
                            : MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            modalContent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
