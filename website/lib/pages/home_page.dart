import 'package:flutter/material.dart';
import 'package:myapp/pages/catalog.dart';
import 'package:myapp/pages/profile.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
      ),
      home: DefaultTabController(
        length: 4,
        
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.message)),
                Tab(icon: Icon(Icons.exit_to_app)),
              ],
            ),
           
            title: Text('Марійчина квіточка'),
          ),
          body: TabBarView(
            children: [
              new CatalogPage(),
              new ProfileScreen(),
              Icon(Icons.message),
              Icon(Icons.message),
            ],
          ),
        ),
      ),
    );
  }
}