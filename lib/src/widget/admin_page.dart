import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';

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

  List _languages = ["nl", "en", "it", "es", "de"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentNativeLang;
  String _currentTargetLang;
  final _myTextCtrl = TextEditingController();

  @override
  void initState() {
    _dropDownMenuItems = _getDropDownMenuItems();
    _currentNativeLang = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _languages) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void _onNativeLanguageChange(String selectedCity) {
    // setState(() {
    //   _currentNativeLang = selectedCity;
    // });
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
              DropdownButton(
                value: _currentNativeLang,
                items: _dropDownMenuItems,
                onChanged: _onNativeLanguageChange,
              )
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 20.0),
              Container(width: 100.0, child: new Text("Naar taal: ")),
              DropdownButton(
                value: _currentNativeLang,
                items: _dropDownMenuItems,
                onChanged: _onNativeLanguageChange,
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
              //Uncomment this stmt will crash the program: new TextField(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
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
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(0.0),
            ),
            borderSide: new BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          hintText: "Geef email adres.."),
      controller: _myTextCtrl,
    );
  }
}
