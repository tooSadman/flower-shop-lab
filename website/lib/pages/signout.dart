import 'package:flutter/material.dart';
import 'package:myapp/pages/login_page.dart';

import 'home_page.dart';


class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                         "Ви впевнені, що хочете вийти з свого профілю?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 3),
                         Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text('Вийти з профілю'),
                     onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginSignupPage()),
                       );
                      },
                    )
                    ),
                      ])
                      );
  }
}

