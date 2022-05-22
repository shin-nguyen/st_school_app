class Course {
  final int id;
  final String name;
  final String description;
  final String lecturer;
  final String language;
  final int price;
  final int subPrice;
  final String image;
  final int subTotal;
  final int videoTotal;
  final double progress;
  final int video;
  final String topic;

  const Course({
    required this.id,
    required this.name,
    required this.description,
    required this.lecturer,
    required this.language,
    required this.price,
    required this.image,
    required this.subTotal,
    required this.videoTotal,
    required this.subPrice,
    required this.progress,
    required this.video,
    required this.topic,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      lecturer: json['lecturer'] ?? 'Cheng',
      language: json['language'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      subTotal: json['subTotal'] ?? 0,
      videoTotal: json['videoTotal'] ?? 0,
      subPrice: json['subPrice'] ?? 0,
      topic: json['topic'] ?? '',
      progress: 0,
      video: 0,
    );
  }

  factory Course.fromOrder(
      Map<String, dynamic> json, double progress, int video) {
    return Course(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        lecturer: json['lecturer'] ?? 'Cheng',
        language: json['language'] ?? '',
        price: json['price'] ?? '',
        image: json['image'] ?? '',
        subTotal: json['subTotal'] ?? 0,
        videoTotal: json['videoTotal'] ?? 0,
        subPrice: json['subPrice'] ?? 0,
        topic: json['topic'] ?? '',
        progress: progress,
        video: video);
  }

  factory Course.empty() {
    return const Course(
        id: -1,
        name: '',
        description: '',
        lecturer: '',
        language: '',
        price: 0,
        image: "",
        subTotal: 0,
        videoTotal: 0,
        topic: "",
        progress: 0,
        subPrice: 0,
        video: 0);
  }
}
