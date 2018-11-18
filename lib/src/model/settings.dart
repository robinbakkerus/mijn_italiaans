import '../data/constants.dart';

class Settings {
  int id;
  LangEnum _nativeLang;
  LangEnum _targetLang;
  String _emailAdress;

  Settings(this._nativeLang, this._targetLang, this._emailAdress);

  Settings.map(dynamic obj) {
    this._nativeLang = obj["native_lang"];
    this._targetLang = obj["target_lang"];
    this._emailAdress = obj["email_address"];
  }

  LangEnum get nativeLang => _nativeLang;
  LangEnum get targetLang => _targetLang;
  String get emailAddress => _emailAdress;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["native_lang"] = Constants.toLangName(_nativeLang);
    map["target_lang"] = Constants.toLangName(_targetLang);
    map["email_address"] = _emailAdress;
    return map;
  }

  
}
