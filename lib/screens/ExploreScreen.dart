import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangaonline/models/bookmark/Bookmark.dart';
import 'package:mangaonline/screens/BookScreen.dart';
import 'package:mangaonline/screens/CatalogScreen.dart';
import 'package:mangaonline/screens/FavoritesScreen.dart';
import 'package:mangaonline/screens/LoginScreen.dart';
import 'package:mangaonline/screens/ProfileScreen.dart';
import 'package:mangaonline/screens/ReadingScreen.dart';
import 'package:mangaonline/screens/SettingsScreen.dart';
import 'package:mangaonline/services/handbooks/BookmarkService.dart';
import 'package:mangaonline/services/users/UserService.dart';
import 'package:mangaonline/widgets/others/MangaOnlineBigButtonIcon.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCircularProgressIndicator.dart';
import 'package:mangaonline/widgets/others/MangaOnlineCoverImage.dart';
import 'package:mangaonline/widgets/others/MangaOnlineLogo.dart';
import 'package:mangaonline/widgets/others/MangaOnlineSectionTitle.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _ExploreScreenState();
  }
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {

    List<Widget> _loginContents(bool boolean){

      Widget itemList(Bookmark _bookmark){
        return FlatButton(
          onLongPress: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ReadingScreen(
                  idBook: _bookmark.book.id,
                  idChapter: _bookmark.chapter.id,
                )));
          },
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BookScreen(
                  idBook: _bookmark.book.id,
                )));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 170,
                margin: EdgeInsets.only(bottom: 10),
                child: MangaOnlineCoverImage(
                  imageUri: _bookmark.book.cover.uri,
                  radius: 8,
                  heightIndicator: 170,
                ),
              ),
              Text(_bookmark.chapter.label)
            ],
          ),
        );
      }

      List<Widget> _list = [];
      if(boolean == true){
        _list.addAll([
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MangaOnlineSectionTitle(
                isAction: true,
                titleText: "Моя история",
                iconData: Icons.chevron_right,
                action: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FavoritesScreen()));
                }),
          ),
          FutureBuilder(
              future: getBookmarks(),
              builder: (BuildContext context, AsyncSnapshot<List<Bookmark>> snapshot){
                switch (snapshot.connectionState){
                  case (ConnectionState.waiting):
                    return Container(
                      height: 220,
                      child: Center(
                        child: MangaOnlineCircularProgressIndicator(),
                      ),
                    );
                    break;
                  default :
                    if(snapshot.hasError){
                      return Container(
                        padding: EdgeInsets.only(left: 30, right: 40),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: ExtendedImage.asset('assets/images/icons/9.webp'),
                              ),
                            ),
                            Flexible(
                              flex: 8,
                              child: Text("Упс... Ошибка получения данных. Пожалуйста проверьте сетевое подключение"),
                            )
                          ],
                        )
                      );
                    } else {
                      return Container(
                        height: 220,
                        child: ListView(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data.map((_bookmark){
                            return itemList(_bookmark);
                          }).toList(),
                        ),
                      );
                    }
                }
              }
          )
        ]);
      } else {
        _list.addAll([
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MangaOnlineSectionTitle(
                isAction: true,
                titleText: "Авторизация",
                iconData: Icons.chevron_right,
                action: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text(
                'Войдите в приложение и получите возможность сохранять прогресс чтения манги'),
          ),
        ]);
      }
      return _list;
    }


    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          MangaOnlineLogo(),
          Container(
            child: FutureBuilder(
              future: isLogin(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                return Column(
                  children: _loginContents(snapshot.data),
                );
              },
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20, top: 60),
            child: MangaOnlineSectionTitle(
                isAction: true,
                titleText: "Каталог",
                iconData: Icons.chevron_right,
                action: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CatalogScreen()));
                }),
          ),
          MangaOnlineBigButtonIcon(
            textButton: "Сейчас популярно",
            icon: Icons.collections_bookmark,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CatalogScreen(
                    title: "Популярное",
                  )));
            },
          ),
          MangaOnlineBigButtonIcon(
            textButton: "Последние обновления",
            icon: Icons.update,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CatalogScreen(
                    title: "Обновления",
                    order: "last_published_chapter",
                  )));
            },
          ),
          MangaOnlineBigButtonIcon(
            textButton: "Недавно добавленое",
            icon: Icons.new_releases,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CatalogScreen(
                    title: "Новое",
                    order: "new",
                  )));
            },
          ),

          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: MangaOnlineSectionTitle(
                isAction: true,
                titleText: "Настройки",
                iconData: Icons.settings,
                action: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsScreen()));
                }),
          ),
        ],
      ),
    );
  }
}
