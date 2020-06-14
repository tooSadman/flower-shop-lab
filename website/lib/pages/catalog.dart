import 'package:flutter/material.dart';
import 'package:myapp/model/flower.dart';
import 'package:myapp/pages/flower_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogPage extends StatefulWidget{
  
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List<Flower> _allFlowers = []; 

  Future<void> _updateList() async {
    final response = await http.get('http://localhost:9000/flowers');
    setState(() {
      _allFlowers = (json.decode(response.body) as List).map((i) =>
              Flower.fromJson(i)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: getCatalogPageBody(context)));
  }

  getCatalogPageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allFlowers.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(10.0),
    );
  }


  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Image.network(
              _allFlowers[index].image,
              fit: BoxFit.cover,
              height: 60,
               width: 60,
          ),
          title: new Text(
            _allFlowers[index].name,
            style: new TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new SizedBox(height: 5),
                new Text("Ціна: " + _allFlowers[index].price.toString() + " грн.",
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                new SizedBox(height: 5),
                new Text('Ідеально підходить для: ${_allFlowers[index].events}',
                    style: new TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal)),
                new SizedBox(height: 10),        
              ]),
          onTap: () => _onTapItem(context, index),
        )
      ],
    ));
  }

void _onTapItem(BuildContext context, int index) {
  Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => FlowerDetails(id: _allFlowers[index].id)));
  }
}
