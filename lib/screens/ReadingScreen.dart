import 'package:flutter/material.dart';
import 'package:mangaonline/models/chapter/Chapter.dart';
import 'package:mangaonline/screens/status/ErrorScreen.dart';
import 'package:mangaonline/screens/status/LoadingScreen.dart';
import 'package:mangaonline/services/chapters/ChapterService.dart';
import 'package:mangaonline/services/handbooks/BookmarkService.dart';
import 'package:mangaonline/widgets/others/MangaOnlineAppBar.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCoverImage.dart';

class ReadingScreen extends StatefulWidget {
  final int idChapter;
  final int idBook;

  const ReadingScreen({Key key, this.idChapter, this.idBook}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _ReadingScreenState();
  }
}

class _ReadingScreenState extends State<ReadingScreen> {
  int idChapter;
  int idBook;

  @override
  void initState() {
    super.initState();
    idChapter = this.widget.idChapter;
    idBook = this.widget.idBook;
  }

  void next(Chapter next) {
    addBookmark(next.id, idBook);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            ReadingScreen(idChapter: next.id, idBook: idBook)));
  }

  void prev(Chapter prev) async {
    addBookmark(prev.id, idBook);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            ReadingScreen(idChapter: prev.id, idBook: idBook)));
  }

  Widget render(BuildContext context, Chapter data) {
    List<Widget> content = [
      MangaOnlineAppBar(
        titleText: data.title,
        backButton: false,
        actions: <Widget>[],
      )
    ];

    if (data.prevChapter != null) {
      content.add(FlatButton(
        onPressed: () => prev(data.prevChapter),
        child: Row(
          children: <Widget>[
            Icon(Icons.chevron_left),
            Text('Предыдущая глава')
          ],
        ),
      ));
    }

    if(data.images.length > 0){
      content.addAll(data.images.map((image){
        return MangaOnlineCoverImage(
          imageUri: image.uri,
          radius: 0,
          heightIndicator: 600,
        );
      }).toList());
    } else {
      //NOT RESULT
    }

    if (data.nextChapter != null) {
      content.add(FlatButton(
        onPressed: () => next(data.nextChapter),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.chevron_right),
            Text('Следующая глава')
          ],
        ),
      ));
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: content,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
      future: getChapter(idChapter, idBook),
      builder: (BuildContext context, AsyncSnapshot<Chapter> snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.waiting):
            return LoadingScreen();
            break;
          default:
            if (snapshot.hasError) {
              return ErrorScreen(
                errorTitle: "Упс... Что-то пошло не так",
                errorText: "Ошибка получения данных. Пожалуйста проверьте сетевое подключение",
                errorImage: "assets/images/icons/9.webp",
              );
            } else {
              return render(context, snapshot.data);
            }
        }
      },
    );
  }
}
