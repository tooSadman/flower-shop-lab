import 'package:flutter/material.dart';
import 'package:myapp/model/orders.dart';
import 'package:myapp/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _allOrders = []; 

  Future<void> _getOrders() async {
    final response = await http.get('http://161.35.64.191:9000/orders/${widget.user.id}');
    setState(() {
      _allOrders = (json.decode(response.body) as List).map((i) =>
              Order.fromJson(i)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: getOrdersPageBody(context)));
  }

  getOrdersPageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allOrders.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(10.0),
    );
  }


  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          title: new Text(
            'Ви замовляли букет "${_allOrders[index].flowerName}"',
            style: new TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new SizedBox(height: 5),
                new Text('Загальна ціна замовлення: ${_allOrders[index].price}',
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.normal)),
                new SizedBox(height: 5),
                new Text('Дата замовлення: ${_allOrders[index].createDate}',
                    style: new TextStyle(
                        fontSize: 14.0, fontStyle: FontStyle.italic)),     
              ]),
        )
      ],
    ));
  }


}
