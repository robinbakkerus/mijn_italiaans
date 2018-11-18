import 'package:flutter/material.dart';
import '../service/vertaal_service.dart';
import '../widget/main_appbar.dart';
import '../service/dbs_service.dart';
import '../service/flutter_tts_service.dart';
import '../model/vertaling.dart';
import '../data/constants.dart';

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

//------------------------------------------------------------

class _VertaalHomePageState extends State<VertaalHomePage> {
  final _myTextCtrl = TextEditingController();
  String _translation = "...";
  String _lastWords = "";
  final TextToSpeech tts = new TextToSpeech();
  DatabaseHelper _db = new DatabaseHelper();
  FocusNode _focusNode = new FocusNode();
  bool _loaderIsActive = false;
  bool _showUndo = false;
  bool _showSend = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusChanged);
    _myTextCtrl.addListener(_myTextCtrlListener);
  }

  void _focusChanged() {
    if (_focusNode.hasFocus) {
      _myTextCtrl.text = "";
      _translation = "";
      if (Constants.speaker) _showUndo = true;
      _screenUpdate();
    }
  }

  void _myTextCtrlListener() {
    if (_myTextCtrl.text.length > 0 && !_showSend) {
        _showSend = true;
         _screenUpdate();
    } else if (_myTextCtrl.text.length == 0 && _showSend) {
        _showSend = false;
        _showUndo = false;
        _screenUpdate();
    }
  }

  void _vertaal() async {
    _translation = "";
    _loaderIsActive = true;
    _showSend = false;
    if (Constants.speaker) _showUndo = true;
    _screenUpdate();
    _focusNode.unfocus();
    _lastWords = _myTextCtrl.text;
    String txt = _myTextCtrl.text.trim();
    var response = VertaalService.vertaal(txt);
    response.then((response) => _handleVertaling(response));
  }

  void _restoreTextOrReplaySound() {
    if (_translation.length > 0) {
      _doTextToSpeach();
    } else {
      _myTextCtrl.text = _lastWords;
    }
  }

  void _handleVertaling(var response) {
    _translation = response.toString();
    _loaderIsActive = false;

    _doTextToSpeach();

    // save to dbs
    Vertaling v = new Vertaling(_myTextCtrl.text.trim(), _translation,
        Constants.toLangName(Constants.current.targetLang));
    _db.saveVertaling(v);
    _screenUpdate();
  }

  @override
  void dispose() {
    _myTextCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _screenUpdate() {
    setState(() {});
  }

  void _toggleSpeaker() {
      Constants.speaker = !Constants.speaker;
      _showUndo = Constants.speaker;
      _screenUpdate();
  }

  void _doTextToSpeach() {
    if (Constants.speaker) {
      tts.speak(_translation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(context, 1),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _textField(),
            _actionButtons(context),
            _loaderIsActive == true
                ? CircularProgressIndicator()
                : _buildTranslatedText(context),
          ],
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     new FloatingActionButton(
      //       onPressed: _restoreText,
      //       tooltip: 'Restore text',
      //       child: new Icon(Icons.undo),
      //       heroTag: null,
      //     ),
      //     new Container(
      //       width: 20,
      //     ),
      //     new FloatingActionButton(
      //       onPressed: _vertaal,
      //       tooltip: 'Vertaal',
      //       child: new Icon(Icons.send),
      //       heroTag: null,
      //     ),
      // ],
      // ),
    );
  }

  Row _actionButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      // IconButton(
      //   icon: Icon(Constants.speaker ? Icons.surround_sound : null),
      //   onPressed: _doTextToSpeach,
      //   color: Colors.lightBlue,
      // ),
      Container(
        width: 20,
      ),
      IconButton(
        icon: Icon(
          Constants.speaker ? Icons.volume_up : Icons.volume_off,
        ),
        onPressed: _toggleSpeaker,
        color: Colors.lightBlue,
      ),
      Container(
        width: 20,
      ),
      IconButton(
        icon: Icon(Icons.undo),
        onPressed: _showUndo ? _restoreTextOrReplaySound : null,
        color: Colors.lightBlue,
      ),
      Container(
        width: 20,
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: _showSend ? _vertaal : null,
        color: Colors.lightBlue,
      ),
    ]);
  }

  Text _buildTranslatedText(BuildContext context) {
    return new Text(
      '$_translation',
      maxLines: 4,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.display1,
    );
  }

  TextField _textField() {
    return new TextField(
      focusNode: _focusNode,
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
