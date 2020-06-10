import 'package:flutter/material.dart';
import 'package:myapp/model/messages.dart';


class MessagesPage extends StatelessWidget {
  final List<Message> _allMessages = Message.allMessages();

  MessagesPage();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: getMessagesPageBody(context)));
  }

  getMessagesPageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allMessages.length,
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
            _allMessages[index].title,
            style: new TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
          ),
          subtitle: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new SizedBox(height: 5),
                new Text(_allMessages[index].text,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal)),
                new SizedBox(height: 5),
                new Text('Дата повідомлення: ${_allMessages[index].date}',
                    style: new TextStyle(
                        fontSize: 14.0, fontStyle: FontStyle.italic)),     
              ]),
        )
      ],
    ));
  }


}