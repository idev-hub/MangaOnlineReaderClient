import 'package:flutter/material.dart';

class MangaOnlineBigButtonIcon extends StatelessWidget {
  final IconData icon;
  final String textButton;
  final Function onPressed;

  const MangaOnlineBigButtonIcon({Key key, this.icon, this.textButton, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: OutlineButton(
        onPressed: onPressed,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(icon, color: Theme.of(context).primaryColor),
            ),
            Text(textButton, style: Theme.of(context).textTheme.body1)
          ],
        ),
      ),
    );
  }
}
