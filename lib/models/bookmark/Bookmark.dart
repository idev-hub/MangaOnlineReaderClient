import 'package:mangaonline/models/book/Book.dart';
import 'package:mangaonline/models/chapter/Chapter.dart';

class Bookmark{
  final int id;
  final Book book;
  final Chapter chapter;
  final Chapter lastAvailableChapter;

  Bookmark({this.id, this.book, this.chapter, this.lastAvailableChapter});

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    int _id = json["id"];
    Book _book = (json["book"]!=null)?Book.fromJson(json["book"]):null;
    Chapter _chapter = (json["chapter"]!=null)?Chapter.fromJson(json["chapter"]):null;
    Chapter lastAvailableChapter = (json["lastAvailableChapter"]!=null)?Chapter.fromJson(json["lastAvailableChapter"]):null;

    return Bookmark(
        id: _id,
        book: _book,
        chapter: _chapter,
        lastAvailableChapter: lastAvailableChapter
    );
  }
}