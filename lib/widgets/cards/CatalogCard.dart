import 'package:flutter/material.dart';
import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/screens/BookScreen.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCoverImage.dart';

class CatalogCard extends StatelessWidget {
  final Book book;

  const CatalogCard({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          (book.title!=null)?book.title:'Название не найдено',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle,
        ),
      )
    ];

    if(book.lastChapters != null){
      items.add(CatalogCardIconListItem(
          label: book.lastChapters.first.label,
          icon: Icons.book));
    }

    if(book.updateTime != null){
      Duration date = DateTime.now().difference(book.updateTime);
      String currentDate;
      Color _color;

      if(date.inMinutes < 60){
        currentDate = date.inMinutes.toString() + "мин. назад";
        _color = Theme.of(context).primaryColor;
      } else if(date.inHours < 24) {
        currentDate = date.inHours.toString() + "ч. назад";
        _color = Color.fromRGBO(0, 255, 0, 0.6);
      } else if(date.inDays < 31) {
        currentDate = date.inDays.toString() + "дн. назад";
      } else currentDate = "${book.updateTime.day<10?'0'+book.updateTime.day.toString():book.updateTime.day.toString()}.${book.updateTime.month<10?'0'+book.updateTime.month.toString():book.updateTime.month.toString()}.${book.updateTime.year.toString()}";

      items.add(CatalogCardIconListItem(
          label: currentDate, icon: Icons.access_time, color: _color));
    }



    items.add(Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        (book.description != null && book.description != "")?book.description:'Нет описания',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.body1,
      ),
    ));


    // TODO: implement build
    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BookScreen(idBook: book.id)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                  height: 160,
                  child: MangaOnlineCoverImage(
                    imageUri: book.cover.uri,
                    radius: 8,
                  )),
            ),
            Expanded(
              flex: 12,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogCardIconListItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isTitle;

  const CatalogCardIconListItem({Key key, this.label, this.icon, this.isTitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: (isTitle != null && isTitle == true) ? 25 : 20,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Text(label,
                  style: TextStyle(
                    color: (color != null)?color:Theme.of(context).primaryColorLight,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Nunito"
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2),
            )
          ]),
    );
  }
}
