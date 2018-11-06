import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: buildMainAppBar(context, -1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/italy.jpg'),
          ],
        ));
  }
}
