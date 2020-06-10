import 'package:flutter/material.dart';
import 'package:myapp/model/Orders.dart';


class OrdersPage extends StatelessWidget {
  final List<Order> _allOrders = Order.allOrders();

  OrdersPage();

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
            'Ви замовляли букет "${_allOrders[index].name}"',
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
                new Text('Дата замовлення: ${_allOrders[index].date}',
                    style: new TextStyle(
                        fontSize: 14.0, fontStyle: FontStyle.italic)),     
              ]),
        )
      ],
    ));
  }


}