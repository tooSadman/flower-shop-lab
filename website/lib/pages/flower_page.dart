import 'package:flutter/material.dart';
import 'package:myapp/pages/success_order.dart';
import 'package:myapp/model/flower.dart';
import 'package:myapp/model/userCard.dart';
import 'package:myapp/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FlowerDetails extends StatefulWidget {
  FlowerDetails({Key key, this.id, this.user}) : super(key: key);

  final int id;
  final User user;

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  String _packingText = "Упаковано в папір";
  String _deliveryText = "З доставкою";
  String _flowerName;
  int _finalPrice;
  Flower flower;
  UserCard card;

  Future<void> _getCard() async {
    final response = await http.get('http://localhost:9000/cards/${widget.user.card}');
    var parsedJson = json.decode(response.body);
    setState(() {
      card = UserCard.fromJson(parsedJson);
    });
  }

  Future<void> _getFlower() async {
    final response = await http.get('http://localhost:9000/flowers/${widget.id}');
    var parsedJson = json.decode(response.body);
    setState(() {
      flower = Flower.fromJson(parsedJson);
      _flowerName = flower.name;
      _finalPrice = (flower.price.toDouble() * card.discount).toInt();
    });
  }

  Future<void> _postOrder() async {
    final response = await http.post('http://localhost:9000/orders/create?flowerName=${flower.name}&customer=${widget.user.id}&price=${_finalPrice}&packing=${_packingText}&delivery=${_deliveryText}');
  }

  @override
  void initState() {
    super.initState();
    _getCard();
    _getFlower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(_flowerName),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network(
                flower.image,
                height: 200,
                width: 200,
                ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      flower.price.toString() + " грн",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Букет для: День Народження, Іменини, День Валентина'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ціна зі знижкою -20% при використанні картки "Gold": $_finalPrice грн.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.orange),
                    ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                          hint: Text("Status"),
                          value: _packingText,
                          items: <String>['Упаковано в папір', 'З бантиком', 'Зі стрічкою', 'Без упаковки'].map((String value) {
                          return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                    );
                    }).toList(),
                    onChanged: (String val) {
                    _packingText = val;
                    setState(() {
                    _packingText = val;
                     });
                    },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                          hint: Text("Status"),
                          value: _deliveryText,
                          items: <String>['З доставкою', 'Самовивіз'].map((String value) {
                          return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                    );
                    }).toList(),
                    onChanged: (String val) {
                    _deliveryText = val;
                    setState(() {
                    _deliveryText = val;
                     });
                    },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Замовити'),
                      onPressed: () {
                        _postOrder();
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuccessOrder()),
                       );
                      },
                    )),
                ],
              ),
            ],
          ),
        ));
  }
}
