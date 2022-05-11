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
  final int progress;
  final int video;
  final String category;

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
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      lecturer: json['lecturer'] ?? 'Cheng',
      language: json['English'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      subTotal: json['videoTotal'] ?? 0,
      videoTotal: json['videoTotal'] ?? 0,
      subPrice: json['subPrice'] ?? 0,
      category: json['category'] ?? '',
      progress: 0,
      video: 0,
    );
  }

  factory Course.fromOrder(Map<String, dynamic> json, int progress, int video) {
    return Course(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        lecturer: json['lecturer'] ?? 'Cheng',
        language: json['English'] ?? '',
        price: json['price'] ?? '',
        image: json['image'] ?? '',
        subTotal: json['videoTotal'] ?? 0,
        videoTotal: json['videoTotal'] ?? 0,
        subPrice: json['subPrice'] ?? 0,
        category: json['category'] ?? '',
        progress: progress,
        video: video);
  }
}
