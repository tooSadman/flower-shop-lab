class Order {

  //--- Name Of Order
  final String name;
  //-- image
  final String date;
   //--- price
  final String price;

  Order({this.name,this.price,this.date});

  static List<Order> allOrders()
  {
    var lstOfOrders = new List<Order>();
    lstOfOrders.add(new Order(name:"Букет Сихівського Угодніка",price: "600 грн.",date: "08.06.2020"));
    lstOfOrders.add(new Order(name:"Рясне на виїзді",price: "250 грн.",date: "06.06.2020"));
    return lstOfOrders;
  }
}