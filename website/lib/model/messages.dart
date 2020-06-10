class Message {

  //--- Name Of Message
  final String title;
  //-- image
  final String text;
  //--- events
    final String date;
  //--- events


  Message({this.title,this.text,this.date});

  static List<Message> allMessages()
  {
    var lstOfMessages = new List<Message>();
    lstOfMessages.add(new Message(title:"Всі букети на 20% дешевше у вівторок!",text: "Замовляй будь-який букет у вівторок і отримуй знижку 20%",date: "10.06.2020"));
    lstOfMessages.add(new Message(title:"1+1=3",text: "Замволяй 2 букети і отримуй третій в подарунок",date: "07.06.2020"));
    lstOfMessages.add(new Message(title:"Знижки до Дня Матері",text: "Привітай маму красиво. Чудові знижки на букети на день матері!",date: "26.05.2020"));
    return lstOfMessages;
  }
}