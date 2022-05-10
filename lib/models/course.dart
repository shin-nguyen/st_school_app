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
    );
  }
}
