import 'package:flutter/material.dart';
import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/models/bookmark/Bookmark.dart';
import 'package:mangaonline/models/chapter/Chapter.dart';
import 'package:mangaonline/screens/status/ErrorScreen.dart';
import 'package:mangaonline/screens/status/LoadingScreen.dart';
import 'package:mangaonline/services/handbooks/BookmarkService.dart';
import 'package:mangaonline/widgets/others/MangaOnlineAppBar.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCoverImage.dart';

import 'BookScreen.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class FavoritesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _FavoritesScreenState();
  }
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
      future: getBookmarks(),
      builder: (BuildContext context, AsyncSnapshot<List<Bookmark>> snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.waiting):
            return LoadingScreen();
            break;
          default:
            if (snapshot.hasError) {
              return ErrorScreen(
                errorTitle: "Упс... Что-то пошло не так",
                errorText:
                    "Ошибка получения данных. Пожалуйста проверьте сетевое подключение",
                errorImage: "assets/images/icons/9.webp",
              );
            } else {
              return updateList(context, snapshot.data);
            }
        }
      },
    );
  }

  Widget updateList(BuildContext context, List<Bookmark> data) {
    List<Widget> items = [
      MangaOnlineAppBar(
        backButton: true,
        titleText: "История",
      )
    ];

    if (data.length > 0) {
      items.addAll(data.map((bookmark) {
        return FavoriteCard(
          idBookmark: bookmark.id,
          book: bookmark.book,
          chapter: bookmark.chapter,
          lastAvailableChapter: bookmark.lastAvailableChapter,
        );
      }).toList());
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: items,
        ));
  }
}

class FavoriteCard extends StatelessWidget {
  final int idBookmark;
  final Book book;
  final Chapter chapter;
  final Chapter lastAvailableChapter;

  const FavoriteCard(
      {Key key,
      this.book,
      this.chapter,
      this.lastAvailableChapter,
      this.idBookmark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
          (book.title != null) ? book.title : 'Название не найдено',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle,
        ),
      )
    ];

    if (lastAvailableChapter != null) {
      items.add(CatalogCardIconListItem(
          label: lastAvailableChapter.label, icon: Icons.update));
    }

    if (chapter != null) {
      items
          .add(CatalogCardIconListItem(label: chapter.label, icon: Icons.book));
    }

    print(book.lastChapterPublishTime);

    if(book.updateTime != null){
      Duration date = DateTime.now().difference(book.updateTime);
      String currentDate;
      Color _color;

      if(date.inMinutes < 60){
        currentDate = date.inMinutes.toString() + "мин. назад";
        _color = Theme.of(context).primaryColor;
      } else if(date.inHours < 24) {
        currentDate = date.inHours.toString() + "ч. назад";
        _color = Color.fromRGBO(0, 255, 0, 1);
      } else if(date.inDays < 31) {
        currentDate = date.inDays.toString() + "дн. назад";
      } else currentDate = "${book.updateTime.day<10?'0'+book.updateTime.day.toString():book.updateTime.day.toString()}.${book.updateTime.month<10?'0'+book.updateTime.month.toString():book.updateTime.month.toString()}.${book.updateTime.year.toString()}";

      items.add(CatalogCardIconListItem(
          label: currentDate, icon: Icons.access_time, color: _color));
    }

    // TODO: implement build
    return FlatButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BookScreen(idBook: book.id)));
      },
      onLongPress: () async {
        final result = await _asyncConfirmDialog(context, idBookmark);
        if (result == ConfirmAction.ACCEPT) {
          await deleteBookmark(idBookmark);
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => FavoritesScreen()));
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  height: 100,
                  child: MangaOnlineCoverImage(
                    imageUri: book.cover.uri,
                    radius: 4,
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
  final bool isTitle;
  final Color color;

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


Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, int idBookmark) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Удалить из истории?"),
        content: const Text("Это действие будет невозможно отменить"),
        actions: <Widget>[
          FlatButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('Удалить'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
