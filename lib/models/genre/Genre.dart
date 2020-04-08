class Genre{
  final int id;
  final String title;
  final String slug;

  Genre({this.id, this.title, this.slug});

  factory Genre.fromJson(Map<String, dynamic> json) {
    int _id = json["id"];
    String _slug = json["slug"];
    String _title = json["title"];

    return Genre(
        id: _id,
        slug: _slug,
        title: _title
    );
  }
}