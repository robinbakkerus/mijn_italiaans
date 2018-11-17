import 'languages.dart';

class Settings {

  int id;
  LangEnum _nativeLang;
  LangEnum _targetLang;
  String _emailAdress;
  bool _speaker;

  Settings(this._nativeLang, this._targetLang, this._emailAdress, this._speaker);

  Settings.map(dynamic obj) {
    this._nativeLang = obj["native_lang"];
    this._targetLang = obj["target_lang"];
    this._emailAdress = obj["email_address"];
  }

  LangEnum get nativeLang => _nativeLang;
  LangEnum get targetLang => _targetLang;
  String get emailAddress => _emailAdress;
  bool get speaker => _speaker;
  set speaker(bool value) => _speaker = !_speaker;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["native_lang"] = Languages.name(_nativeLang);
    map["target_lang"] = Languages.name(_targetLang);
    map["email_address"] = _emailAdress;
    return map;
  }

  //TODO uit dbs halen.
  static Settings current = new Settings(LangEnum.NL, LangEnum.IT, "", true);
}
