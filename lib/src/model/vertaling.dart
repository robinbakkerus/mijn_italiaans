class Vertaling {

  int id;
  String _words;
  String _translated;
  String _lang;

  Vertaling(this._words, this._translated, this._lang);

  Vertaling.map(dynamic obj) {
    this._words = obj["words"];
    this._translated = obj["translation"];
    this._lang = obj["lang"];
  }

  String get words => _words;

  String get translated => _translated;

  String get lang => _lang;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["words"] = _words;
    map["translation"] = _translated;
    map["lang"] = _lang;
    return map;
  }
  void setId(int id) {
    this.id = id;
  }
}


