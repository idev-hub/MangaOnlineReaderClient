class Chapter {
  final int id;
  final int tom;
  final String slug;
  final String uri;
  final String title;
  final String label;
  final int isFull;
  final int isSponsored;
  final int isIndexing;
  final int viewsCount;
  final String availabilityStatus;
  final String updateTime;
  final String publishTime;
  final List<ImageChapter> images;
  final Chapter prevChapter;
  final Chapter nextChapter;

  Chapter({this.id, this.tom, this.slug, this.uri, this.title, this.label, this.isFull, this.isSponsored, this.isIndexing, this.viewsCount, this.availabilityStatus, this.updateTime, this.publishTime, this.images, this.prevChapter, this.nextChapter});


  factory Chapter.fromJson(Map<String, dynamic> json) {
    if(json != null){
      int _id = json["id"];
      int _tom = json["tom"];
      String _slug = json["slug"];
      String _uri = json["url"];
      String _title = json["title"];
      String _label = json["numberLabel"];
      int _isFull = json["isFull"];
      int _isSponsored = json["isSponsored"];
      int _isIndexing = json["isIndexing"];
      int _viewsCount = json["viewsCount"];
      String _availabilityStatus = json["availabilityStatus"];
      String _updateTime = json["updateTime"];
      String _publishTime = json["publishTime"];

      List _img = json.containsKey('images')?(json["images"] as List):[];

      List<ImageChapter> _images = (_img != null && _img.length > 0)?_img.map((image) {
        return ImageChapter.fromJson(image);
      }).toList():[];

      Chapter _prevChapter = json.containsKey('prevChapter')?Chapter.fromJson(json['prevChapter']):null;
      Chapter _nextChapter = json.containsKey('nextChapter')?Chapter.fromJson(json['nextChapter']):null;

      return Chapter(
          id: _id,
          tom: _tom,
          slug: _slug,
          uri: _uri,
          title: _title,
          label: _label,
          isFull: _isFull,
          isSponsored: _isSponsored,
          isIndexing: _isIndexing,
          viewsCount: _viewsCount,
          availabilityStatus: _availabilityStatus,
          updateTime: _updateTime,
          publishTime: _publishTime,
          images: _images,
          nextChapter: _nextChapter,
          prevChapter: _prevChapter
      );
    } else return null;
  }
}

class ImageChapter {
  final int id;
  final String uri;
  final int width;
  final int height;

  ImageChapter({this.id, this.uri, this.width, this.height});

  factory ImageChapter.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;

    String _uri = (json["url"]).toString().replaceAll('медиа.манга.онлайн', 'xn--80ahcnr.xn--80aai8ag.xn--80asehdb');
    int _id = json["id"];
    int _width = json["width"];
    int _height = json["height"];

    return ImageChapter(uri: _uri, id: _id, width: _width, height: _height);
  }
}
