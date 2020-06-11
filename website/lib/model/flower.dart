class Flower {

  //-- id
  final int id;
  //--- Name Of Flower
  final String name;
  //-- image
  final String image;
  //--- events
  final String events;
   //--- price
  final int price;

  Flower({this.id,this.name,this.price,this.events,this.image});

  factory Flower.fromJson(Map<String, dynamic> json) {
    return Flower(
      id: json['ID'],
      name: json['Name'],
      image: json['Picture'],
      price: json['Price'],
    );
  }
}
