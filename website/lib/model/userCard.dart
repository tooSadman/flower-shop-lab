class UserCard {

  //-- id
  final int id;
  //--- Name Of Card
  final String cardName;
   //--- discount
  final double discount;

  UserCard({this.id,this.cardName,this.discount});

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      id: json['ID'],
      cardName: json['CardName'],
      discount: json['Discount'],
    );
  }
}
