import 'package:flutter/material.dart';

import 'src/widget/homepage.dart';
import 'src/widget/vertaal.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => new HomePage(),
      //   '/vertaal': (BuildContext context) => new VertaalPage(),
      // },
      home: new HomePage(),
    );
  }
}
