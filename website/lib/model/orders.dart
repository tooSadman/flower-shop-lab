class Order {

  //--- order id
  final int id;
  //--- FlowerName
  final String flowerName;
  //-- Customer
  final int customer;
  //--- price
  final int price;
  //--- CreateDate
  final String createDate;
  //--- Packing
  final String packing;
  //--- Delivery
  final String delivery;

  Order({this.id,this.flowerName,this.customer,this.price,this.createDate,this.packing,this.delivery});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['ID'],
      flowerName: json['FlowerName'],
      customer: json['Customer'],
      price: json['Price'],
      createDate: json['CreateDate'],
      packing: json['Packing'],
      delivery: json['Delivery'],
    );
  }
}
