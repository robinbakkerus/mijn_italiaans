import 'package:flutter/material.dart';
import '../service/vertaal_service.dart';
import '../widget/main_appbar.dart';

class VertaalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Italiaans App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loaderIsActive = false;
  final myTextCtrl = TextEditingController();
  String _text = "...";

  void _vertaal() async {
    setState(() {
      _loaderIsActive = true;
    });
    var response = vertaal(myTextCtrl.text);
    response.then((response) => _text = response.toString());

    setState(() {
      _loaderIsActive = false;
    });
  }

 void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      //_selectedChoice = choice;
      print(choice.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(_select),
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
        onPressed: _vertaal,
        tooltip: 'Vertaal',
        child: new Icon(Icons.add),
      ),
    );

    @override
    void dispose() {
      myTextCtrl.dispose();
      super.dispose();
    }
  }
}

/*
https://translate.googleapis.com/translate_a/single?client=gtx&sl=nl&tl=it&dt=t&q=goedemorgen" 
            + sourceLang + "&tl=" + targetLang + "&dt=t&q=" + encodeURI(sourceText);
*/
