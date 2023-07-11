class User {
  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.location,
    required this.profile,
  });

  final int? userId;
  final String? username;
  final String? email;
  final String? password;
  final String? mobile;
  final String? location;
  final String? profile;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json["userId"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      mobile: json["mobile"],
      location: json["location"],
      profile: json["profile"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "password": password,
    "mobile": mobile,
    "location": location,
    "profile": profile,
  };

  @override
  String toString(){
    return "$userId, $username, $email, $password, $mobile, $location, $profile, ";
  }
}
