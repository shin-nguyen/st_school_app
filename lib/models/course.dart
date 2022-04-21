class Course {
  final int id;
  final String name;
  final String description;
  final String lecturer;
  final String language;
  final int price;
  final String image;
  final int subTotal;
  final int videoTotal;

  const Course({
    this.id,
    this.name,
    this.description,
    this.lecturer,
    this.language,
    this.price,
    this.image,
    this.subTotal,
    this.videoTotal,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      lecturer: json['lecture'],
      language: json['language'],
      price: json['price'],
      image: json['image'],
      subTotal: json['subTotal'],
      videoTotal: json['videoTotal'],
    );
  }
}
