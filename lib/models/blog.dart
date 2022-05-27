class Blog {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String image;
  final String user;
  final String createdTime;
  final int view;

  Blog({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.content,
    required this.user,
    required this.createdTime,
    required this.view,
  });

  factory Blog.empty() {
    return Blog(
      id: -1,
      image: '',
      title: '',
      user: '',
      createdTime: '',
      content: "",
      view: 0,
      summary: "",
    );
  }

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      user: json['user']['firstName'] ?? '',
      createdTime: json['createdTime'] ?? '',
      content: json['content'] ?? '',
      view: json['view'] ?? 0,
      summary: json['summary'] ?? '',
    );
  }
}

final dataBlogs = [
  Blog(
      id: 1,
      image:
          'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
      title: 'Finding your ikigai in your middle age',
      user: 'John Johny',
      createdTime: '25 Mar 2020',
      content: "Finding your ikigai in your middle age",
      view: 0,
      summary: "Finding your ikigai in your middle age"),
  Blog(
      id: 2,
      image:
          'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
      title: 'Finding your ikigai in your middle age',
      user: 'John Johny',
      createdTime: '25 Mar 2020',
      content: "Finding your ikigai in your middle age",
      view: 0,
      summary: "Finding your ikigai in your middle age"),
  Blog(
      id: 3,
      image:
          'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
      title: 'Finding your ikigai in your middle age',
      user: 'John Johny',
      createdTime: '25 Mar 2020',
      content: "Finding your ikigai in your middle age",
      view: 0,
      summary: "Finding your ikigai in your middle age"),
];
