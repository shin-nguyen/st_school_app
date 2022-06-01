class License {
  String title;
  String text;

  License({
    required this.title,
    required this.text,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      title: json['title'],
      text: json['text'],
    );
  }
}
