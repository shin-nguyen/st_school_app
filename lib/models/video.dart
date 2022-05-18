class Video {
  final int id;
  final String name;
  final String source;
  final String time;
  final int course;

  const Video(
      {required this.id,
      required this.name,
      required this.source,
      required this.time,
      required this.course});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      source: json['source'] ?? '',
      time: json['time'] ?? '',
      course: json['course']['id'] ?? '',
    );
  }

  factory Video.empty() {
    return const Video(
      id: -1,
      name: '',
      source: '',
      time: '',
      course: -1,
    );
  }
}
