class Post {
  int id;
  String title;
  String description;
  String status;

  Post(
      {required this.id,
      required this.status,
      required this.description,
      required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        status: json['status'],
        description: json['description'],
        title: json['title']);
  }
}
