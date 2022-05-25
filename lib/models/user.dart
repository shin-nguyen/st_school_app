class User {
  String firstName;
  String lastName;
  String phone;
  String address;
  String email;
  String avatar;
  String about;

  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.email,
    required this.avatar,
    required this.about,
  });

  factory User.empty() {
    return User(
      firstName: '',
      lastName: '',
      phone: '',
      address: '',
      email: '',
      avatar: '',
      about: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      about: json['about'] ?? '',
    );
  }
}
