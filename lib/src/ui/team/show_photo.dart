import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../util/metrics.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/empty_appbar.dart';

class ShowPhoto extends StatelessWidget {
  final String photoLink;
  const ShowPhoto({Key key, this.photoLink}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: Metrics.ph(context, 80),
              child: PhotoView(
                loadingChild: Center(
                  child: CustomProgressIndicator(
                    bg: Colors.black,
                    width: 50,
                    height: 50,
                  ),
                ),
                imageProvider: NetworkImage(
                  photoLink,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.0, right: space_geraldine),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: white,
                      size: space_portage,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
