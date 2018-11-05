import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(_select),
      body: new Text('Todo'),
    );
  }

  void _select(Choice choice) {
    print(choice.title);
  }
}
