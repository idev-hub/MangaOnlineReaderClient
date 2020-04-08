import 'package:flutter/material.dart';
import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/models/genre/Genre.dart';
import 'package:mangaonline/screens/status/ErrorScreen.dart';
import 'package:mangaonline/screens/status/LoadingScreen.dart';
import 'package:mangaonline/services/books/BookService.dart';
import 'package:mangaonline/utils/statics.dart';
import 'package:mangaonline/widgets/cards/CatalogCard.dart';
import 'package:mangaonline/widgets/others/MangaOnlineAppBar.dart';
import 'package:mangaonline/widgets/others/MangaOnlinePagination.dart';

class CatalogScreen extends StatefulWidget {
  final int page;
  final int pageSize;
  final String order;
  final String title;
  final List<Genre> genres;

  const CatalogScreen(
      {Key key, this.page, this.pageSize, this.order, this.title, this.genres})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _CatalogScreenState();
  }
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _page = 1;
  int _pageSize = pageViews;
  String _order = 'popular';
  String _title = 'Каталог';
  List<Genre> _genres = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (this.widget.page != null) _page = this.widget.page;
    if (this.widget.pageSize != null) _pageSize = this.widget.pageSize;
    if (this.widget.order != null) _order = this.widget.order;
    if (this.widget.title != null) _title = this.widget.title;
    if (this.widget.genres != null) _genres = this.widget.genres;
  }

  Widget updateList(BuildContext context, MoreBooks morebooks) {
    List<Widget> items = [
      MangaOnlineAppBar(
        backButton: true,
        titleText: _title,
      )
    ];

    if (morebooks.books.length > 0) {
      items.addAll(morebooks.books.map((book) {
        return CatalogCard(book: book);
      }).toList());
    }

    items.add(MangaOnlinePagination(
      page: _page,
      pageCounts: (morebooks.total / _pageSize).round(),
      actionNext: () {
        setState(() {
          _page = _page + 1;
        });
      },
      actionPrev: () {
        setState(() {
          _page = _page - 1;
        });
      },
    ));

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FutureBuilder(
      future: getBooks(_page, _pageSize, _order, _genres, 0),
      builder: (BuildContext context, AsyncSnapshot<MoreBooks> snapshot) {
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
              return updateList(context, snapshot.data);
            }
        }
      },
    );
  }
}
