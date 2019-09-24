import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import '../ui/team/show_photo.dart';
import '../util/metrics.dart';
import '../util/scale_route_transition.dart';
import 'auto_resize_text.dart';
import 'card_shadow.dart';
import 'custom_progress_indicator.dart';

class CardTrack extends StatelessWidget {
  final String photo;
  final String stage;
  final String status;
  final String updatedAt;
  final String about;
  final Color aboutColor;
  final List photos;

  const CardTrack({
    Key key,
    this.photo = '',
    this.stage = '',
    this.status = '',
    this.updatedAt = '',
    this.about = '',
    this.aboutColor = const Color(0xff293845),
    this.photos,
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
                  maxLines: 2,
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
              ),
              child: AutoResizeText(
                text: about,
                containerTextWidth: 300,
                textAlign: TextAlign.left,
                textColor: aboutColor,
                maxLines: 3,
                fontWeight: FontWeight.normal,
              ),
            ),
            photos.length > 0
                ? GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 5.0,
                    children: _buildContentList(photos, context),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContentList(List photos, BuildContext context) {
    return photos.map((data) => _buildContentListItem(data, context)).toList();
  }

  Widget _buildContentListItem(String photo, BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          top: space_dodger_blue,
        ),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            ScaleRoute(
                widget: ShowPhoto(
              photoLink: photo.toString(),
            )),
          ),
          child: photo != null
              ? Container(
                  padding: EdgeInsets.all(space_carmine),
                  child: CachedNetworkImage(
                    imageUrl: photo.toString(),
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
        ),
      ),
    );
  }

  Widget modalPhotoView(String photo, BuildContext context) {
    return Container(
      height: Metrics.ph(context, 50),
      child: PhotoView(
        loadingChild: CustomProgressIndicator(),
        imageProvider: NetworkImage(photo.toString()),
        // backgroundDecoration: Bpx,
      ),
    );
  }
}
