class User {
  String email;
  String avatar;

  User(this.email, this.avatar);

  User.fromMap(Map<String, dynamic> json) {
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
  }
}
