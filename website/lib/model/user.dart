class User {

  //-- id
  final int id;
  //--- Name Of User
  final String email;
  //-- password
  final String password;
  //--- username
  final String username;
   //--- card
  final String card;

  User({this.id,this.email,this.password,this.username,this.card});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'],
      email: json['Email'],
      password: json['EncryptedPassword'],
      username: json['Username'],
      card: json['Card'],
    );
  }
}
