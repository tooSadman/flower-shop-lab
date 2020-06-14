import 'package:flutter/material.dart';
import 'package:myapp/model/user.dart';
import 'package:myapp/pages/catalog.dart';
import 'package:myapp/pages/messages_page.dart';
import 'package:myapp/pages/profile_page.dart';
import 'package:myapp/pages/signout.dart';
import 'orders_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.email, this.pass}) : super(key: key);

  final String email;
  final String pass;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _userId;
  User user;

  Future<void> _getUser() async {
    final response = await http.get('http://localhost:9000/users/${widget.email}');
    var parsedJson = json.decode(response.body);
    setState(() {
      user = User.fromJson(parsedJson);
      _userId = user.id;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.archive)),
                Tab(icon: Icon(Icons.message)),
                Tab(icon: Icon(Icons.exit_to_app)),
              ],
            ),
           
            title: Text('Марійчина квіточка'),
          ),
          body: TabBarView(
            children: [
              new CatalogPage(user: user),
              new ProfileScreen(user: user),
              new OrdersPage(user: user),
              new MessagesPage(),
              new SignOut(),
            ],
          ),
        ),
      ),
    );
  }
}
