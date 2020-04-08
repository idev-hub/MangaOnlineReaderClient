import 'package:flutter/material.dart';

class MangaOnlinePagination extends StatefulWidget {
  final int page;
  final int pageCounts;
  final Function actionNext;
  final Function actionPrev;

  const MangaOnlinePagination(
      {Key key, this.page, this.pageCounts, this.actionNext, this.actionPrev})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MangaOnlinePaginationState();
  }
}

class _MangaOnlinePaginationState extends State<MangaOnlinePagination> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 120,
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.chevron_left),
              onPressed: (this.widget.page > 1) ? this.widget.actionPrev : null,
              disabledColor: Colors.black54,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Flexible(
            child: Text(
              '${this.widget.page.toString()} / ${this.widget.pageCounts.toString()}',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Flexible(
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.chevron_right),
              onPressed: (this.widget.page < this.widget.pageCounts)
                  ? this.widget.actionNext
                  : null,
              disabledColor: Colors.black54,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
