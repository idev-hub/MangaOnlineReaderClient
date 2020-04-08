import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCircularProgressIndicator.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: (MediaQuery.of(context).size.height / 2) - 20,
              left: (MediaQuery.of(context).size.width / 2) - 20,
              child: new MangaOnlineCircularProgressIndicator(),
            ),
            Positioned(
                top: 80,
                left: (MediaQuery.of(context).size.width / 2) - 75,
                child: new ExtendedImage.asset('assets/images/logo.png',
                    width: 150))
          ],
        ),
      ),
    );
  }
}
