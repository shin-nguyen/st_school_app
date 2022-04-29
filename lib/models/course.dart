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
    required this.id,
    required this.name,
    required this.description,
    required this.lecturer,
    required this.language,
    required this.price,
    required this.image,
    required this.subTotal,
    required this.videoTotal,
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

List<Course> courses = [
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1638543961/st-school/images/js.png.png",
      subTotal: 1,
      videoTotal: 1),
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1638543915/st-school/images/py.png.png",
      subTotal: 1,
      videoTotal: 1),
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
      subTotal: 1,
      videoTotal: 1),
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
      subTotal: 1,
      videoTotal: 1),
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
      subTotal: 1,
      videoTotal: 1),
  Course(
      id: 1,
      name: 'name',
      description: 'description',
      lecturer: 'lecturer',
      language: 'language',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
      subTotal: 1,
      videoTotal: 1)
];
