import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../model/vertaling.dart';
import '../service/dbs_service.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new _ExploreHomePage(title: 'Italiaans App'),
    );
  }
}

class _ExploreHomePage extends StatefulWidget {
  _ExploreHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExploreHomePageState createState() => new _ExploreHomePageState();
}

class _ExploreHomePageState extends State<_ExploreHomePage> {
  List<Vertaling> _vertalingen;
  DatabaseHelper _db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    var futList = _db.getVertalingen();
    futList.then((r) {
      _vertalingen = r;
      print("gevonden " + _vertalingen.length.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(context, 2),
      body: new ListView.builder(
          itemCount: _vertalingen == null ? 0 : _vertalingen.length,
          itemBuilder: (BuildContext context, int index) {
            return _newCard(index);
          }),
    );
  }

  Card _newCard(int index) {
    return new Card(
      child: new Container(
          child: new Center(
            child: GestureDetector(
              onTap: () {
                _showTranslation(index);
              },
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            _vertalingen[index].words,
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.lightBlueAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: const Color(0xFF167F67)),
                        onPressed: () => _deleteVertaling(index),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );
  }

  _deleteVertaling(int index) {
    _db.deleteUsers(_vertalingen[index]);
    _vertalingen.remove(_vertalingen[index]);
    screenUpdate();
  }

  void screenUpdate() {
    setState(() {});
  }

  void _showTranslation(int index) {
    String str = _vertalingen[index].translated;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(str),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
