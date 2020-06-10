import 'package:flutter/material.dart';
import 'package:myapp/model/flower.dart';
import 'package:myapp/pages/flower_page.dart';

class CatalogPage extends StatelessWidget {
  final List<Flower> _allFlowers = Flower.allFlowers();

  CatalogPage() {}

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
          leading: new Image.asset(
            "assets/" + _allFlowers[index].image,
            fit: BoxFit.cover,
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
                new Text(_allFlowers[index].price,
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.normal)),
                new SizedBox(height: 5),
                new Text('Ідеально підходить для: ${_allFlowers[index].events}',
                    style: new TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal)),
                new SizedBox(height: 10),        
              ]),
          onTap: () => _onTapItem(context),
        )
      ],
    ));
  }

void _onTapItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => FlowerDetails()));
  }
}