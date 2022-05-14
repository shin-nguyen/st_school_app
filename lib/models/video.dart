class Video {
  final int id;
  final String name;
  final String source;

  const Video({
    required this.id,
    required this.name,
    required this.source,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      source: json['source'] ?? '',
    );
  }

  factory Video.empty() {
    return const Video(
      id: -1,
      name: '',
      source: '',
    );
  }
}
