import 'package:flutter/material.dart';
import 'package:myapp/pages/success_order.dart';
import 'package:myapp/model/flower.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FlowerDetails extends StatefulWidget {
  FlowerDetails({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  String _packingText = "Упаковано в папір";
  String _deliveryText = "З доставкою";
  String _flowerName;
  int _finalPrice;
  Flower flower;

  Future<void> _getFlower(int i) async {
    final response = await http.get('http://localhost:9000/flowers/${widget.id}');
    var parsedJson = json.decode(response.body);
    setState(() {
      flower = Flower.fromJson(parsedJson);
      _flowerName = flower.name;
      _finalPrice = (flower.price.toDouble() * 0.8).toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    _getFlower(widget.id);
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
