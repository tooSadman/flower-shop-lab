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
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: getCatalogPageBody(context)));
  }

  getCatalogPageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allFlowers.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
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
            width: 100.0,
          ),

          title: new Text(
            _allFlowers[index].name,
            style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_allFlowers[index].price,
                    style: new TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.normal)),
                new Text('events: ${_allFlowers[index].events}',
                    style: new TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.normal)),
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

  _showSnackBar(BuildContext context, Flower item) {
    final SnackBar objSnackbar = new SnackBar(
      content: new Text("${item.name} is a Flower in ${item.price}"),
      backgroundColor: Colors.amber,
    );
    Scaffold.of(context).showSnackBar(objSnackbar);
  }
}