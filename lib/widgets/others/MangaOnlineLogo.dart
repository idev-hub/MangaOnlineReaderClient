import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MangaOnlineLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40, bottom: 60),
          child: ExtendedImage.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
