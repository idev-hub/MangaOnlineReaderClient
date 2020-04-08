import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mangaonline/models/chapter/Chapter.dart';
import 'dart:convert';

import 'package:mangaonline/utils/statics.dart';

import '../../main.dart';

Future<Chapter> getChapter(int chapterId, int bookId) async {
  String token = await storage.read(key: 'token');

  Object headers;
  if (token != null)
    headers = {HttpHeaders.authorizationHeader: 'Bearer ' + token};

  final response = await http.get('$apiUri/books/$bookId/chapters/$chapterId',
      headers: headers);

  return Chapter.fromJson(jsonDecode(response.body));
}
