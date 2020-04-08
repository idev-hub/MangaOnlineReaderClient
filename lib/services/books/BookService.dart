import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/models/genre/Genre.dart';
import 'dart:convert';

import 'package:mangaonline/utils/statics.dart';

import '../../main.dart';

Future<MoreBooks> getBooks(int page, int pageSize, String order, List<Genre> genres, int onlyCompleted) async {
  String token = await storage.read(key: 'token');

  Object headers;
  if (token != null && token != ""){
    headers = {HttpHeaders.authorizationHeader: 'Bearer ' + token};
  }


  String _genres = "";

  if (genres.length > 0)
    _genres = "&genres=" +
        genres
            .map((genre) {
              return genre.id;
            })
            .toList()
            .join(',');

  final response = await http.get(
      '$apiUri/books?pageSize=$pageSize&page=$page&order=$order$_genres&onlyCompleted=$onlyCompleted',
      headers: headers);

  MoreBooks _result = MoreBooks.fromJson(jsonDecode(response.body));

  return _result;
}

Future<Book> getBook(int id) async {
  String token = await storage.read(key: 'token');

  Object headers;
  if (token != null)
    headers = {HttpHeaders.authorizationHeader: 'Bearer ' + token};

  final response = await http.get('$apiUri/books/$id', headers: headers);

  Book _result = Book.fromJson(jsonDecode(response.body));

  return _result;
}
