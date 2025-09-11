class UserModel {
  String? email;
  String? password;
  String? userName;
  String? id;
  String? signUpDate;

  UserModel({this.email, this.password, this.userName, this.id,this.signUpDate});

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        email: json['email'],
        password: json['password'],
        userName: json['useName'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'useName': userName,
    'id': id,
  };
}
