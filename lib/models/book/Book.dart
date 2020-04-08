import 'package:mangaonline/models/chapter/Chapter.dart';
import 'package:mangaonline/models/genre/Genre.dart';
import 'package:mangaonline/utils/statics.dart';

class Book {
  final int id;
  final String title;
  final String fullTitle;
  final String uri;
  final CoverBook cover;
  final int viewsCount;
  final int likesCount;
  final int dislikesCount;
  final int readersCount;
  final DateTime updateTime;
  final DateTime createTime;
  final DateTime lastChapterPublishTime;
  final String description;
  final List<Chapter> lastChapters;

  final List<Genre> genres;
  final String status;
  final String titleEn;
  final List<Chapter> chapters;
  final Chapter userReadingChapter;

  Book(
      {this.id,
      this.title,
      this.fullTitle,
      this.uri,
      this.cover,
      this.viewsCount,
      this.likesCount,
      this.dislikesCount,
      this.readersCount,
      this.updateTime,
      this.createTime,
      this.lastChapterPublishTime,
      this.description,
      this.lastChapters,
      this.status,
      this.titleEn,
      this.genres,
      this.chapters,
      this.userReadingChapter});

  factory Book.fromJson(Map<String, dynamic> json) {
    int _id = json["id"];
    String _title = json["title"];
    String _fullTitle = json["fullTitle"];
    String _uri = json["url"];

    CoverBook _cover = CoverBook.fromJson(json["images"][0]);

    int _viewsCount = json["viewsCount"];
    int _likesCount = json["likesCount"];
    int _dislikesCount = json["dislikesCount"];
    int _readersCount = json["readersCount"];
    DateTime _updateTime = json.containsKey('updateTime')
        ? DateTime.parse(json["updateTime"])
        : null;
    DateTime _createTime = json.containsKey('createTime')
        ? DateTime.parse(json["createTime"])
        : null;




    DateTime _lastChapterPublishTime = json.containsKey('lastChapterPublishTime')
        ? DateTime.parse(json["lastChapterPublishTime"])
        : null;

    String _description = json["description"];

    List<Chapter> _lastChapters = json.containsKey('lastChapters')
        ? (json["lastChapters"] as List).map((chapter) {
            return Chapter.fromJson(chapter);
          }).toList()
        : null;

    String _status = json["status"];
    String _titleEn = json["titleEn"];

    List<Genre> _genres = json.containsKey('genres')
        ? (json["genres"] as List).map((genre) {
            return Genre.fromJson(genre);
          }).toList()
        : null;

    List<Chapter> _chapters = json.containsKey('chapters')
        ? (json["chapters"] as List).map((chapter) {
            return Chapter.fromJson(chapter);
          }).toList()
        : null;

    Chapter _userReadingChapter = json.containsKey('userReadingChapter')
        ? (json['userReadingChapter'] != null)
            ? Chapter.fromJson(json['userReadingChapter'])
            : null
        : null;

    return Book(
        id: _id,
        title: _title,
        fullTitle: _fullTitle,
        uri: _uri,
        cover: _cover,
        viewsCount: _viewsCount,
        likesCount: _likesCount,
        dislikesCount: _dislikesCount,
        readersCount: _readersCount,
        updateTime: _updateTime,
        createTime: _createTime,
        lastChapterPublishTime: _lastChapterPublishTime,
        description: _description,
        lastChapters: _lastChapters,
        status: _status,
        titleEn: _titleEn,
        genres: _genres,
        chapters: _chapters,
        userReadingChapter: _userReadingChapter);
  }
}

class MoreBooks {
  final int total;
  final List<Book> books;

  MoreBooks({this.total, this.books});

  factory MoreBooks.fromJson(Map<String, dynamic> json) {
    int _total = json["total"];

    List<Book> _books = json.containsKey('items')
        ? (json["items"] as List).map((book) {
            return Book.fromJson(book);
          }).toList()
        : null;

    return MoreBooks(
      total: _total,
      books: _books,
    );
  }
}

class CoverBook {
  final String uri;
  final String svg;
  final int width;
  final int height;

  CoverBook({this.uri, this.width, this.height, this.svg});

  factory CoverBook.fromJson(Map<String, dynamic> json) {
    String _uri = json.containsKey('url') ? staticUri + json["url"] : null;
    String _svg = json.containsKey('svg') ? staticUri + json["svg"] : null;
    int _width = json["width"];
    int _height = json["height"];

    return CoverBook(uri: _uri, svg: _svg, width: _width, height: _height);
  }
}
