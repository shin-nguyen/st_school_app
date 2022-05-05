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
      name: 'HTML Course',
      description:
          'HTML is the standard markup language for Web pages. With HTML you can create your own Website.',
      lecturer: 'Kari Noman',
      language: 'English',
      price: 122,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png",
      subTotal: 1,
      videoTotal: 20),
  Course(
      id: 1,
      name: 'Learn CSS | Self-paced',
      description:
          'CSS is the language we use to style an HTML document. CSS describes how HTML elements should be displayed.',
      lecturer: 'Human Lily',
      language: 'English',
      price: 90,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1635049169/st-school/images/css.png.png",
      subTotal: 1,
      videoTotal: 12),
  Course(
      id: 1,
      name: 'Learn SQL',
      description:
          'SQL is a standard language for storing, manipulating and retrieving data in databases.',
      lecturer: 'Kai Akatsuki',
      language: 'Japan',
      price: 200,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632236549/st-school/images/sql.png.png",
      subTotal: 1,
      videoTotal: 12),
  Course(
      id: 1,
      name: 'Learn Java',
      description:
          'Java is used to develop mobile apps, web apps, desktop apps, games and much more.',
      lecturer: 'Hoang Minh Long',
      language: 'Vietnamese',
      price: 99,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
      subTotal: 1,
      videoTotal: 53),
  Course(
      id: 1,
      name: 'Learn Bootstrap 3',
      description:
          'Bootstrap is the most popular HTML, CSS, and JavaScript framework for developing responsive, mobile-first websites.',
      lecturer: 'ST Team',
      language: 'English',
      price: 50,
      image:
          "https://res.cloudinary.com/qscloud/image/upload/v1638544101/st-school/images/bootrap3.png.png",
      subTotal: 1,
      videoTotal: 4),
];
