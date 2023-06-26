class User {
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.location,
    required this.mobile,
  });

  final int? userId;
  final String? username;
  final String? email;
  final String? location;
  final String? mobile;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      username: json["username"],
      email: json["email"],
      location: json["location"],
      mobile: json["mobile"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "username": username,
      "email": email,
      "location": location,
      "mobile": mobile,
    };
  }
}
