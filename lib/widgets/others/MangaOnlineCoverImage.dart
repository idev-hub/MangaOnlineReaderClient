import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'MangaOnlineCircularProgressIndicator.dart';

class MangaOnlineCoverImage extends StatelessWidget {
  final String imageUri;
  final double radius;
  final double heightIndicator;

  const MangaOnlineCoverImage(
      {Key key, this.imageUri, this.radius, this.heightIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          color: Colors.black12,
          child: ExtendedImage.network(
            imageUri,
            width: 120,
            fit: BoxFit.cover,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return Container(
                  height: heightIndicator != null ? heightIndicator : null,
                  width: 120,
                  child: new Center(
                    child: MangaOnlineCircularProgressIndicator(),
                  ),
                );
              } else {
                return state.completedWidget;
              }
            },
          ),
        ));
  }
}