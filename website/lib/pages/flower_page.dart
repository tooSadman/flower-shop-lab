import 'package:flutter/material.dart';


class FlowerDetails extends StatefulWidget {

  @override
  _FlowerDetailsState createState() => _FlowerDetailsState();
}

class _FlowerDetailsState extends State<FlowerDetails> {
  get position => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Букет Сихівського Угодніка'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                "assets/logo.png",
                fit: BoxFit.cover,
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Букет для: День Народження, Іменини, День Валентина',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ціна: 600 грн.'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ціна зі знижкою -20% для вашої картки "Дамскій угоднік": 400 грн.'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                          items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                    );
                    }).toList(),
                    onChanged: (_) {},
                    )
                  )
                ],
              ),
            ],
          ),
        ));
  }
}