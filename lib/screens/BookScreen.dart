import 'package:flutter/material.dart';
import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/screens/ReadingScreen.dart';
import 'package:mangaonline/screens/status/ErrorScreen.dart';
import 'package:mangaonline/screens/status/LoadingScreen.dart';
import 'package:mangaonline/services/books/BookService.dart';
import 'package:mangaonline/services/handbooks/BookmarkService.dart';
import 'package:mangaonline/widgets/cards/CatalogCard.dart';
import 'package:mangaonline/widgets/others/MangaOnlineAppBar.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCoverImage.dart';

import 'CatalogScreen.dart';

class BookScreen extends StatefulWidget {

  final int idBook;

  const BookScreen({Key key, this.idBook}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _BookScreenState();
  }
}

class _BookScreenState extends State<BookScreen> {

  int idBook;

  @override
  void initState() {
    super.initState();

    setState(() {
      idBook = this.widget.idBook;
    });
  }

  void showChaptersBottomSheet(context, Book book) {
    List<Widget> views = [
      Container(
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 30, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Содержание',
              style: Theme.of(context).textTheme.title,
            ),
            (book.userReadingChapter!=null)?OutlineButton(
              child: Text('Продолжить читать'),
              onPressed: (){
                addBookmark(book.userReadingChapter.id, book.id);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReadingScreen(
                      idChapter: book.userReadingChapter.id,
                      idBook: book.id,
                    )));
              },
            ):OutlineButton(
              child: Text('Начать читать'),
              onPressed: (){
                addBookmark(book.chapters.last.id, book.id);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReadingScreen(
                      idChapter: book.chapters.last.id,
                      idBook: book.id,
                    )));
              },
            )
          ],
        ),
      )
    ];

    views.addAll(book.chapters.reversed.map((chapter) {
      return ListTile(
          leading: Icon(
            Icons.book,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(chapter.label),
          onTap: () {
            addBookmark(chapter.id, book.id);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReadingScreen(
                  idChapter: chapter.id,
                  idBook: book.id,
                )));
          });
    }).toList());

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: ListView(
              children: views,
            ),
          );
        });
  }

  Widget render(BuildContext context, Book book) {
    String currentDate;
    Color _color;

    if(book.updateTime != null){
      Duration date = DateTime.now().difference(book.updateTime);
      if(date.inMinutes < 60){
        currentDate = date.inMinutes.toString() + "мин. назад";
        _color = Theme.of(context).primaryColor;
      } else if(date.inHours < 24) {
        currentDate = date.inHours.toString() + "ч. назад";
        _color = Color.fromRGBO(0, 255, 0, 0.6);
      } else if(date.inDays < 31) {
        currentDate = date.inDays.toString() + "дн. назад";
      } else currentDate = "${book.updateTime.day<10?'0'+book.updateTime.day.toString():book.updateTime.day.toString()}.${book.updateTime.month<10?'0'+book.updateTime.month.toString():book.updateTime.month.toString()}.${book.updateTime.year.toString()}";
    }



    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: MangaOnlineAppBar(
                  titleText: book.title,
                  backButton: true,
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(left: 20, top: 25, bottom: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Container(
                              height: 260,
                              child: MangaOnlineCoverImage(
                                  imageUri: book.cover.uri, radius: 12),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 260,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          CatalogCardIconListItem(
                                            label:
                                            '${book.viewsCount.toString()} чел.',
                                            color: Theme.of(context).accentColor,
                                            icon: Icons.remove_red_eye,
                                            isTitle: true,
                                          ),
                                          CatalogCardIconListItem(
                                            label: '${book.likesCount} чел.',
                                            color: Theme.of(context).accentColor,
                                            icon: Icons.thumb_up,
                                            isTitle: true,
                                          ),
                                          CatalogCardIconListItem(
                                            label: '${book.dislikesCount} чел.',
                                            color: Theme.of(context).accentColor,
                                            icon: Icons.thumb_down,
                                            isTitle: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          CatalogCardIconListItem(
                                            label:
                                            '${book.chapters.first.label}',
                                            color: Theme.of(context).accentColor,
                                            icon: Icons.book,
                                            isTitle: true,
                                          ),
                                          CatalogCardIconListItem(
                                            label: currentDate,
                                            color: _color,
                                            icon: Icons.update,
                                            isTitle: true,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(book.fullTitle,
                          style: Theme.of(context).textTheme.caption),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Описание: ",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          Text(
                            (book.description!=null&&book.description!="")?book.description:'Нет описания',
                            style: Theme.of(context).textTheme.body2,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Жанры: ",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 20,
                            runSpacing: 10,
                            children: (book.genres.length>0)?book.genres.map((genre) {
                              return OutlineButton(
                                child: Text(genre.title),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => CatalogScreen(
                                        title: "Жанр: ${genre.title}",
                                        genres: [genre],
                                      )));
                                },
                              );
                            }).toList():[Text('Ничего не найдено...', style: Theme.of(context).textTheme.caption,)],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showChaptersBottomSheet(context, book);
        },
        child: Icon(
          Icons.collections_bookmark,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
      future: getBook(idBook),
      builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
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
