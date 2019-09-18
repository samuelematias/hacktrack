import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import 'auto_resize_text.dart';
import 'card_shadow.dart';

class CardTrack extends StatelessWidget {
  final String photo;
  final String stage;
  final String status;
  final String updatedAt;
  final String about;
  final Color aboutColor;

  const CardTrack({
    Key key,
    this.photo = '',
    this.stage = '',
    this.status = '',
    this.updatedAt = '',
    this.about = '',
    this.aboutColor = const Color(0xff293845),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardShadow(
      width: 300,
      child: Padding(
        padding: EdgeInsets.only(
          left: space_golden_dream,
          top: space_golden_dream,
          right: space_golden_dream,
          bottom: space_golden_dream,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoResizeText(
                  text: stage,
                  containerTextWidth: 80,
                ),
                AutoResizeText(
                  text: updatedAt,
                  containerTextWidth: 185,
                  textAlign: TextAlign.right,
                  textColor: lightGrey,
                  fontSize: space_dodger_blue,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: space_golden_dream,
                // bottom: space_golden_dream,
              ),
              child: AutoResizeText(
                text: about,
                containerTextWidth: 300,
                textAlign: TextAlign.left,
                textColor: aboutColor,
                maxLines: 3,
              ),
            ),
            photo.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(
                      left: space_carmine,
                      right: space_carmine,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: photo,
                      fit: BoxFit.fitWidth,
                      width: space_purple_rain,
                      height: space_purple_rain,
                      placeholder: (context, photo) => Container(
                        width: space_portage,
                        height: space_portage,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                      errorWidget: (context, photo, error) => Container(
                        width: space_portage,
                        height: space_portage,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
