import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mangaonline/screens/ExploreScreen.dart';

class ErrorScreen extends StatelessWidget {
  final String errorTitle;
  final String errorText;
  final String errorImage;

  const ErrorScreen({Key key, this.errorTitle, this.errorText, this.errorImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: ExtendedImage.asset(
                    errorImage,
                    width: MediaQuery.of(context).size.width * 0.4,
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    errorTitle,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: Text(
                    errorText,
                    style: Theme.of(context).textTheme.body1,
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => ExploreScreen()),
              (Route<dynamic> route) => false);
        },
      ),
    );
  }
}
