import 'package:flutter/material.dart';
import '../service/vertaal_service.dart';
import '../widget/main_appbar.dart';
import '../service/dbs_service.dart';
import '../model/vertaling.dart';

class VertaalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new VertaalHomePage(title: 'Italiaans App'),
    );
  }
}

class VertaalHomePage extends StatefulWidget {
  VertaalHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VertaalHomePageState createState() => new _VertaalHomePageState();
}

class _VertaalHomePageState extends State<VertaalHomePage> {
  bool _loaderIsActive = false;
  final _myTextCtrl = TextEditingController();
  String _text = "...";
  // final TextToSpeech tts = new TextToSpeech();
  DatabaseHelper _db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _myTextCtrl.addListener(_watchInput);
  }

  void _watchInput() {
    if (_myTextCtrl.text.indexOf(".") > 0) {
      _vertaal();
    }
  }

  void _vertaal() async {
    _text = "";
    _loaderIsActive = true;
    _screenUpdate();

    var response = VertaalService.vertaal(_myTextCtrl.text);
    response.then((response) => _handleVertaling(response));
  }

  void _handleVertaling(var response) {
    _text = response.toString();
    _loaderIsActive = false;
    // tts.speak(_text);
    Vertaling v = new Vertaling(_myTextCtrl.text, _text, 'it');
    _db.saveVertaling(v);
    _screenUpdate();
  }

  @override
  void dispose() {
    _myTextCtrl.dispose();
    super.dispose();
  }

  void _screenUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(context, 1),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _textField(),
            _loaderIsActive == true
                ? CircularProgressIndicator()
                : _buildText(context),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _vertaal,
        tooltip: 'Vertaal',
        
        child: new Icon(Icons.send),
      ),
    );
  }

  Text _buildText(BuildContext context) {
    return new Text(
      '$_text',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.display1,
    );
  }

  TextField _textField() {
    return new TextField(
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
      controller: _myTextCtrl,
    );
  }
}
