import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../model/settings.dart';
import '../service/dbs_service.dart';
import '../data/constants.dart';


class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: buildMainAppBar(context, 3),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new _AdminForm(),
          ],
        ));
  }
}

class _AdminForm extends StatefulWidget {
  @override
  _AdminFormState createState() {
    return _AdminFormState();
  }
}

class _AdminFormState extends State<_AdminForm> {
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<LangEnum>> _dropDownMenuItems;
  LangEnum _nativeLang;
  LangEnum _targetLang;
  final _myTextCtrl = TextEditingController();
  final DatabaseHelper _db = new DatabaseHelper();

  @override
  void initState() {
    _dropDownMenuItems = _getDropDownMenuItems();
    _nativeLang = Constants.current.nativeLang;
    _targetLang = Constants.current.targetLang;
    super.initState();
  }

  List<DropdownMenuItem<LangEnum>> _getDropDownMenuItems() {
     List<DropdownMenuItem<LangEnum>> items = new List();
    Constants.LANG_SELECT_CB.forEach((k, v) =>
        items.add(new DropdownMenuItem(value: k, child: new Text(v))));
    return items;
  }

  void _onNativeLangChange(LangEnum selectedLang) {
    setState(() {
      _nativeLang = selectedLang;
    });
  }

  void _onTargetLangChange(LangEnum selectedLang) {
    setState(() {
      _targetLang = selectedLang;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Container(width: 20.0),
              Container(width: 100.0, child: new Text("Moedertaal: ")),
              DropdownButton<LangEnum>(
                value: _nativeLang,
                items: _dropDownMenuItems,
                onChanged: _onNativeLangChange,
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 20.0),
              Container(width: 100.0, child: new Text("Naar taal: ")),
              DropdownButton<LangEnum>(
                value: _targetLang,
                items: _dropDownMenuItems,
                onChanged: _onTargetLangChange,
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 20.0),
              Container(width: 100.0, child: new Text("Email address: ")),
            ],
          ),
          new Row(
            children: <Widget>[
              Container(width: 20.0),
              Expanded(
                child: _textField())
              ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Settings settings =
                      new Settings(_nativeLang, _targetLang, "");
                  _db.saveSettings(settings);
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  TextField _textField() {
    return new TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
      //     border: new OutlineInputBorder(
      //       borderRadius: const BorderRadius.all(
      //         const Radius.circular(0.0),
      //       ),
      //       borderSide: new BorderSide(
      //         color: Colors.black,
      //         width: 1.0,
      //       ),
      //     ),
          hintText: "Geef email adres.."),
      controller: _myTextCtrl,
    );
  }
}
