import 'package:flutter/material.dart';
import 'homepage.dart';
import 'vertaal.dart';

AppBar buildMainAppBar(BuildContext context) {
  void _select(Choice choice) {
    print("** " + choice.title);

    if (choice.title == '/home') {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else if (choice.title == '/vertaal') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VertaalPage()),
      );
    }
  }

  var onPressed0 =  _select(choices[0]);
  var onPressed1 =  _select(choices[1]);
  var onPressed2 =  _select(choices[2]);

  return new AppBar(
    title: new Text("Mi Italia"),
    actions: <Widget>[
      IconButton(
        icon: Icon(choices[0].icon),
        onPressed: () {
          _select(choices[0]);
        },
      ),
      IconButton(
        
        icon: Icon(choices[1].icon),
        onPressed: () {
          _select(choices[1]);
        },
      ),
      IconButton(
        icon: Icon(choices[2].icon),
        onPressed : null,
        // onPressed: () {
        //   _select(choices[2]);
        // },
      ),
      // overflow menu
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '/home', icon: Icons.home),
  const Choice(title: '/vertaal', icon: Icons.input),
  const Choice(title: 'explore', icon: Icons.explore),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];
