class Forum {
  int _id;
  String _title;
  String _desc;
  String _image_name;
  String _time_ago;
  String _author;
  String _author_image;

  Forum(this._id, this._title, this._desc, this._image_name, this._time_ago,
      this._author, this._author_image);

  String get author_image => _author_image;

  set author_image(String value) {
    _author_image = value;
  }

  String get author => _author;

  set author(String value) {
    _author = value;
  }

  String get time_ago => _time_ago;

  set time_ago(String value) {
    _time_ago = value;
  }

  String get image_name => _image_name;

  set image_name(String value) {
    _image_name = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
