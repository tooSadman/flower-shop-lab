import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SuccessOrder extends StatefulWidget {
  SuccessOrder({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _SuccessOrderState createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Замовлення успішне!'),
        ),
body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                "assets/done.png",
                height: 200,
                width: 200,
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Замовлення успішне!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ми отримали ваше замовлення і протягом 10 хв. з вами звяжеться наш консультат для підвтердження замовлення! Дякуємо, що обрали нас!'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Переглянути інші букети'),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(email: widget.user.email, pass: widget.user.password)),
                       );
                      },
                    )
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}
