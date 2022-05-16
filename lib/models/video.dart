class Video {
  final int id;
  final String name;
  final String source;
  final String time;

  const Video({
    required this.id,
    required this.name,
    required this.source,
    required this.time,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      source: json['source'] ?? '',
      time: json['time'] ?? '',
    );
  }

  factory Video.empty() {
    return const Video(
      id: -1,
      name: '',
      source: '',
      time: '',
    );
  }
}
