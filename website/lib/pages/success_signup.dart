import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/login_page.dart';


class SuccessSignup extends StatefulWidget {

  @override
  _SuccessSignupState createState() => _SuccessSignupState();
}

class _SuccessSignupState extends State<SuccessSignup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ви успішно зареєструвались!'),
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
                      'Ви успішно зареєструвались!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Вітаємо, тепер ви можете замовляти найкращі букети на районі! Увійдіть, щоб переклянути наш каталог.'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text('Перейти на сторінку входу'),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginSignupPage()),
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