import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MangaOnlineSectionTitle extends StatelessWidget {
  final String titleText;
  final IconData iconData;
  final Function action;
  final bool isAction;

  const MangaOnlineSectionTitle(
      {Key key, this.titleText, this.action, this.isAction, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> contents = [
      Text((titleText != null) ? titleText : "",
          style: Theme.of(context).textTheme.title)
    ];

    if(iconData!=null){
      contents.add(Icon(iconData, size: 25,));
    }

    Widget widget = Container(
      padding: EdgeInsets.only(bottom: 10, left: 30, right: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: contents,
      ),
    );

    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      child: (isAction != null && isAction == true)
          ? FlatButton(
              padding: EdgeInsets.zero,
              child: widget,
              onPressed: () => action(),
            )
          : Container(
              child: widget,
            ),
    );
  }
}
