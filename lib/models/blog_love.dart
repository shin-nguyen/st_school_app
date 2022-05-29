class BlogLove {
  final int id;
  BlogLove({
    required this.id,
  });

  factory BlogLove.empty() {
    return BlogLove(
      id: -1,
    );
  }

  factory BlogLove.fromJson(Map<String, dynamic> json) {
    return BlogLove(
      id: json['id'] ?? -1,
    );
  }
}
