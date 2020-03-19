class User {
  final String email;
  final String avatar;

  User(this.email, this.avatar);

  factory User.fromMap(Map<String, dynamic> json) {
    return User(json['email'], json['avatar']);
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}
