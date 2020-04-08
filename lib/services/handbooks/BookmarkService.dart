import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangaonline/main.dart';

import 'package:mangaonline/models/bookmark/Bookmark.dart';
import 'package:mangaonline/utils/statics.dart';

Future<List<Bookmark>> getBookmarks() async {
  String token = await storage.read(key: 'token');

  if (token != null) {
    final response = await http.get(apiUri + '/bookmarks',
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
    dynamic items = jsonDecode(response.body)['items'];

    if (items.length > 0 && items != null) {
      return (items as List).map((bookmark) {
        return Bookmark.fromJson(bookmark);
      }).toList();
    } else {
      throw ("Упс... Кажется список пуст");
    }
  } else {
    throw ("Ошибка... Доступно только авторизованым пользователям");
  }
}

addBookmark(int chapter, int book) async {
  String token = await storage.read(key: 'token');
  if (token != null) {
    await http.post(apiUri + '/bookmarks',
        body: {"chapterId": chapter.toString(), "bookId": book.toString()},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  } else
    throw ("Ошибка... Доступно только авторизованым пользователям");
}

deleteBookmark(int bookmark) async{
  String token = await storage.read(key: 'token');
  if (token != null) {
    await http.delete(apiUri + '/bookmarks/' + bookmark.toString(),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  } else
    throw ("Ошибка... Доступно только авторизованым пользователям");
}