import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../model/settings.dart';


class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new _HomePage(title: 'Italiaans App'),
    );
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<_HomePage> {

  String _image = 'images/logo_' + Settings.current.targetLang + ".jpg";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildMainAppBar(context, -1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(_image),
          ],
        ));
  }
}
