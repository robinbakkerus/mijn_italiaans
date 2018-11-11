import 'package:flutter/material.dart';
import 'home_page.dart';
import 'vertaal_page.dart';
import 'explore_page.dart';
import 'admin_page.dart';
import '../model/settings.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '/home', icon: Icons.home),
  const Choice(title: '/vertaal', icon: Icons.input),
  const Choice(title: '/explore', icon: Icons.format_list_bulleted),
  const Choice(title: '/admin', icon: Icons.settings),
];

AppBar buildMainAppBar(BuildContext context, int disableButton) {
  void _select(Choice choice) {
    print("** " + choice.title);

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    if (choice.title == '/vertaal') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VertaalPage()));
    } else if (choice.title == '/explore') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ExplorePage()));
    } else if (choice.title == '/admin') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StartPage()));
    }
  }

  bool _isButtonDisabled(int n) => n==disableButton;

  IconButton _buildButton(int n) {
      return new  IconButton(
        icon: Icon(choices[n].icon),
        onPressed: _isButtonDisabled(n) ? null : () {
          _select(choices[n]);
        } ,
      );
  }

  return new AppBar(
    title: new Text(Settings.current.nativeLang + "->" + Settings.current.targetLang),
    actions: <Widget>[
      _buildButton(0),
      _buildButton(1),
      _buildButton(2),
      _buildButton(3),
      PopupMenuButton<Choice>(
        onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.skip(2).map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      ),
    ],
  );
}
