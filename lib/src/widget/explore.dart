import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../service/dbs_service.dart';


class ExplorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExploreHomePage(title: 'Italiaans App'),
    );
  }
}

class ExploreHomePage extends StatefulWidget {
  ExploreHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExploreHomePageState createState() => new _ExploreHomePageState();
}

class _ExploreHomePageState extends State<ExploreHomePage> {
  bool _loaderIsActive = false;
  final myTextCtrl = TextEditingController();
  String _text = "...";

  @override
  void dispose() {
    myTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(context, 2),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              style: TextStyle(fontSize: 25.0, color: Colors.blue),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(0.0),
                    ),
                    borderSide: new BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  hintText: "Voer tekst in om te vertalen.."),
              controller: myTextCtrl,
            ),
            new Text(
              '$_text',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Vertaal',
        child: new Icon(Icons.add),
      ),
    );
  }
}
