class Blog {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String image;
  final String user;
  final String createdTime;
  final int view;
  int recordLove;
  bool love;
  final String topic;

  Blog({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.content,
    required this.user,
    required this.createdTime,
    required this.view,
    required this.love,
    required this.recordLove,
    required this.topic,
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
        love: false,
        recordLove: 0,
        topic: "All");
  }

  factory Blog.fromJson(
    Map<String, dynamic> json,
  ) {
    return Blog(
      id: json['id'] ?? -1,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      user: json['user']['firstName'] ?? '',
      createdTime: json['createdTime'] ?? '',
      content: json['content'] ?? '',
      view: json['view'] ?? 0,
      summary: json['summary'] ?? '',
      love: json['isLove'] ?? false,
      recordLove: json['recordLove'] ?? 0,
      topic: json['topic'] ?? "All",
    );
  }
}

// final dataBlogs = [
//   Blog(
//     id: 1,
//     image:
//         'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
//     title: 'Finding your ikigai in your middle age',
//     user: 'John Johny',
//     createdTime: '25 Mar 2020',
//     content: "Finding your ikigai in your middle age",
//     view: 0,
//     summary: "Finding your ikigai in your middle age",
//     love: true,
//     recordLove: 0,
//   ),
//   Blog(
//     id: 2,
//     image:
//         'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
//     title: 'Finding your ikigai in your middle age',
//     user: 'John Johny',
//     createdTime: '25 Mar 2020',
//     content: "Finding your ikigai in your middle age",
//     view: 0,
//     summary: "Finding your ikigai in your middle age",
//     love: true,
//     recordLove: 0,
//   ),
//   Blog(
//     id: 3,
//     image:
//         'https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png',
//     title: 'Finding your ikigai in your middle age',
//     user: 'John Johny',
//     createdTime: '25 Mar 2020',
//     content: "Finding your ikigai in your middle age",
//     view: 0,
//     summary: "Finding your ikigai in your middle age",
//     love: true,
//     recordLove: 0,
//   ),
// ];
