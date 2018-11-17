import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../model/vertaling.dart';
import '../model/settings.dart';
import '../model/sort_order.dart';
import '../service/dbs_service.dart';
import '../service/email_service.dart';

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
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  Map<SortOrder, String> kv;
  SortOrder _selcSortOrder = SortOrder.ID_ASC;

  @override
  void initState() {
    super.initState();

    _dropDownMenuItems = _getDropDownMenuItems();

    var futList = _db.getVertalingen(SortOrder.ID_DESC);
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
      floatingActionButton: _actionButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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

  Row _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new FloatingActionButton(
          onPressed: _sendEmail,
          child: new Icon(Icons.email),
          backgroundColor: Colors.amberAccent,
          heroTag: null,
        ),
        new Container(
          width: 20,
        ),
        new FloatingActionButton(
          onPressed: _askSortOrder,
          child: new Icon(Icons.send),
          heroTag: null,
        ),
      ],
    );
  }

  void _sendEmail() {
    EmailService.sendEmail( "robin.bakkerus@gmail.com", "italy", _emailBodyText());
  }

  void _deleteVertaling(int index) {
    _db.deleteUsers(_vertalingen[index]);
    _vertalingen.remove(_vertalingen[index]);
    _screenUpdate();
  }

  void _screenUpdate() {
    print(Settings.current.targetLang);
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

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    SortUtils.SORTORDER_CB.forEach((k, v) =>
        items.add(new DropdownMenuItem(value: v, child: new Text(v))));
    return items;
  }

  void _askSortOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            new Text(''),
            new DropdownButton<String>(
              hint: new Text("Hoe te sorteren"),
              value: SortUtils.SORTORDER_CB[_selcSortOrder],
              onChanged: (String newVal) {
                setState(() {
                  _selcSortOrder = SortUtils.fromValue(newVal);
                });
              },
              items: _dropDownMenuItems,
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                _doSort();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _doSort() {
    var futList = _db.getVertalingen(_selcSortOrder);
    print(_selcSortOrder.toString());
    futList.then((r) {
      print("gevonden " + _vertalingen.length.toString());
      setState(() {
        _vertalingen = r;
      });
    });
  }

  String _emailBodyText() {
    StringBuffer sb = new StringBuffer();
    _vertalingen.forEach((f) => sb.write(f.words + ";" + f.translated + "\n"));
    return sb.toString();
  }
}
