import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/model/user.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
//  User user; 
//
//  Future<void> _getUser() async {
//    final response = await http.get('http://localhost:9000/users');
//    setState(() {
//      _allFlowers = (json.decode(response.body) as List).map((i) =>
//              Flower.fromJson(i)).toList();
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _updateList();
//  }
//
//

  @override
  Widget build(BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/ava.png'),
                          radius: 60,
                        ),
                        SizedBox(height: 10),
                        Text(
                         widget.user.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                         "Тип картки: " + widget.user.card,
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                         "Контакти:",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                         widget.user.email,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ])
                      );
  }
}
