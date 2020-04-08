import 'package:flutter/material.dart';

class MangaOnlineAppBar extends StatelessWidget {
  final String titleText;
  final bool backButton;
  final List<Widget> actions;
  final TextAlign textAlign;

  const MangaOnlineAppBar(
      {Key key,
      @required this.titleText,
      @required this.backButton,
      this.actions,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> view = <Widget>[];
    if (backButton != null && backButton != false)
      view.add(new Flexible(
        flex: (actions != null && actions.length >= 2) ? 4 : 2,
        child: Container(
          padding: new EdgeInsets.only(right: 20),
          child: new IconButton(
            iconSize: 25,
            alignment: Alignment.center,
            icon: new Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ));

    view.add(
      new Flexible(
        flex: (actions != null && actions.length > 1) ? 12 : 8,
        child: Container(
          child: new Text(
            titleText,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.title,
            textAlign: (textAlign != null) ? textAlign : TextAlign.center,
          ),
        ),
      ),
    );

    if (actions != null && actions.length > 0)
      view.add(new Flexible(
          flex: (actions.length > 1) ? 6 : 2,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          )));

    return new Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: MediaQuery.of(context).padding.top),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: new Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: (actions != null && actions.length > 0)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: view),
      ),
    );
  }
}
