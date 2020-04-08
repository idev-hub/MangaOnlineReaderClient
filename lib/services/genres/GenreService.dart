import 'package:http/http.dart' as http;
import 'package:mangaonline/models/genre/Genre.dart';
import 'dart:convert';

import 'package:mangaonline/utils/statics.dart';

Future<List<Genre>> getGenres() async {
  final response = await http.get('$apiUri/genres');

  var _genres = (jsonDecode(response.body) as List);

  List<Genre> _result = _genres.length > 0
      ? _genres.map((genre) {
          return Genre.fromJson(genre);
        }).toList()
      : null;

  return _result;
}
