import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../themes/spacing/linear_scale.dart';
import 'card_shadow.dart';

class ContentCard extends StatelessWidget {
  final String photo;
  final String title;

  const ContentCard({
    Key key,
    this.photo = '',
    this.title = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardShadow(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          percentageRow(context),
          percentageIdeal(context),
        ],
      ),
    );
  }

  Container percentageRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: space_spring_green,
      ),
      child: Center(
        child: photo.isEmpty
            ? Container(
                width: space_scooter,
                height: space_scooter,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image,
                ),
              )
            : Container(
                padding: EdgeInsets.only(
                  left: space_carmine,
                  right: space_carmine,
                ),
                child: CachedNetworkImage(
                  imageUrl: photo,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, photo) => Container(
                    width: space_scooter,
                    height: space_scooter,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image,
                    ),
                  ),
                  errorWidget: (context, photo, error) => Container(
                    width: space_scooter,
                    height: space_scooter,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Container percentageIdeal(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: space_carmine,
        bottom: space_spring_green,
      ),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: Theme.of(context).accentTextTheme.button,
      ),
    );
  }
}
