class Video {
  final int id;
  final String name;
  final String source;
  final int duration;
  final int course;

  const Video({
    required this.id,
    required this.name,
    required this.source,
    required this.duration,
    required this.course,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      source: json['source'] ?? '',
      duration: json['duration'] ?? 0,
      course: json['course']['id'] ?? '',
    );
  }

  factory Video.empty() {
    return const Video(
      id: -1,
      name: '',
      source: '',
      duration: 0,
      course: -1,
    );
  }
}
