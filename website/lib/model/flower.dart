class Flower {

  //--- Name Of Flower
  final String name;
  //-- image
  final String image;
  //--- events
  final String events;
   //--- price
  final String price;

  Flower({this.name,this.price,this.events,this.image});

  static List<Flower> allFlowers()
  {
    var lstOfFlowers = new List<Flower>();

    lstOfFlowers.add(new Flower(name:"Букет Сихівського Угодніка",price: "600 грн.",events: "День Народження, Іменини, День Валентина",image: "ava.png"));
    lstOfFlowers.add(new Flower(name:"Рясне на виїзді",price: "250 грн.",events: "8 mill",image: "ava.png"));
    lstOfFlowers.add(new Flower(name:"Мамі найкращого друга",price: "9990 грн.",events: "2.4 mill",image: "ava.png"));
    lstOfFlowers.add(new Flower(name:"Весілля однокласниці",price: "600 грн.",events: "8.1 mill",image: "ava.png"));
    lstOfFlowers.add(new Flower(name:"Зелені свята",price: "600 грн.",events: "2.2 mill",image: "ava.png"));
    lstOfFlowers.add(new Flower(name:"Центровий стиль",price: "600 грн.",events: "3.7 mill",image: "ava.png"));
    return lstOfFlowers;
  }
}