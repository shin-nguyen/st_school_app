class Notifications {
  String title;
  String meseage;
  String token;

  Notifications({
    required this.title,
    required this.meseage,
    required this.token,
  });

  factory Notifications.empty() {
    return Notifications(
      title: '',
      meseage: '',
      token: '',
    );
  }

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      title: json['title'],
      token: json['token'],
      meseage: json['meseage'] ?? '',
    );
  }
}
