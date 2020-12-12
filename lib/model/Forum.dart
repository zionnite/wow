class Forum {
  int id;
  String title;
  String desc;
  String image_name;
  String time_ago;
  String author;
  String author_image;

  Forum({
    this.id,
    this.title,
    this.desc,
    this.image_name,
    this.time_ago,
    this.author,
    this.author_image,
  });

  Forum.fromJson(Map<String, dynamic> json) {
    Forum(
      id: json['id'],
      title: json['title'],
      image_name: json['image_name'],
      time_ago: json['time_ago'],
      author: json['author'],
      author_image: json['author_image'],
    );
  }

}
