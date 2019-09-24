import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import 'metrics.dart';

class CustomModal extends PageRouteBuilder {
  CustomModal({
    @required BuildContext context,
    @required Widget modalContent,
    double overlayHeight = 50.0,
  }) : super(
          opaque: false,
          //Slide animation
          // transitionsBuilder: (BuildContext context,
          //     Animation<double> animation,
          //     Animation<double> secondaryAnimation,
          //     Widget child) {
          //   return new SlideTransition(
          //     position: new Tween<Offset>(
          //       begin: const Offset(-1.0, 0.0),
          //       end: Offset.zero,
          //     ).animate(animation),
          //     child: child,
          //   );
          // },

          //Scale Animation
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new ScaleTransition(
              scale: new Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    0.50,
                    curve: Curves.linear,
                  ),
                ),
              ),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 1.5,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                      0.50,
                      1.00,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: child,
              ),
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
                        Container(
                          margin: EdgeInsets.only(
                            top: Metrics.size(context, 10.0),
                          ),
                          width: Metrics.size(context, 40.0),
                          height: Metrics.size(context, 4.0),
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
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
