import 'package:flutter/material.dart';
import 'package:myapp/pages/success_order.dart';


class FlowerDetails extends StatefulWidget {

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  String _selectedText = "Упаковано в папір";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Букет Сихівського Угодніка'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                "assets/ava.png",
                height: 200,
                width: 200,
                ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '600 грн.',
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
                      'Ціна зі знижкою -20% при використанні картки "Gold": 480 грн.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.orange),
                    ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                          hint: Text("Status"),
                          value: _selectedText,
                          items: <String>['Упаковано в папір', 'З бантиком', 'Зі стрічкою', 'Без упаковки'].map((String value) {
                          return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                    );
                    }).toList(),
                    onChanged: (String val) {
                    _selectedText = val;
                    setState(() {
                    _selectedText = val;
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