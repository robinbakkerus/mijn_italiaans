class Settings {

  int id;
  String _nativeLang;
  String _targetLang;
  String _emailAdress;

  Settings(this._nativeLang, this._targetLang, this._emailAdress);

  Settings.map(dynamic obj) {
    this._nativeLang = obj["native_lang"];
    this._targetLang = obj["target_lang"];
    this._emailAdress = obj["email_address"];
  }

  String get nativeLang => _nativeLang;

  String get targetLang => _targetLang;

  String get emailAddress => _emailAdress;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["native_lang"] = _nativeLang;
    map["target_lang"] = _targetLang;
    map["email_address"] = _emailAdress;
    return map;
  }

  static Settings current = new Settings("nl", "it", "");
}
