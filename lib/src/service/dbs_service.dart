import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/vertaling.dart';
import '../model/settings.dart';
import '../model/sort_order.dart';
import '../model/languages.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_translations.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Vertaling (id INTEGER PRIMARY KEY, words TEXT, translation TEXT, lang TEXT)");
    await db.execute(
        "CREATE TABLE Vertaling_Settings (native_lang TEXT, target_lang TEXT, email_address TEXT)");
  }

  Future<int> saveVertaling(Vertaling vertaling) async {
    var dbClient = await db;
    List<Vertaling> list = await getVertalingById(vertaling.id);
    if (list.length == 0) {
      int res = await dbClient.insert("Vertaling", vertaling.toMap());
      return res;
    } else {
      return 0;
    }
  }

  Future<List<Vertaling>> getVertalingen(SortOrder sortOrder) async {
    var dbClient = await db;
    String qry = 'SELECT * FROM Vertaling ' + SortUtils.SORTORDER_SQL[sortOrder];
    print(qry);
    List<Map> list = await dbClient.rawQuery(qry);
    List<Vertaling> vertalingen = new List();
    for (int i = 0; i < list.length; i++) {
      var vertaling = new Vertaling(
          list[i]["words"], list[i]["translation"], list[i]["lang"]);
      vertaling.setId(list[i]["id"]);
      vertalingen.add(vertaling);
    }
    print(vertalingen.length);
    return vertalingen;
  }

  Future<List<Vertaling>> getVertalingById(int id) async {
    var dbClient = await db;
    String qry = 'SELECT * FROM Vertaling WHERE id=\'' +
        id.toString() +
        '\'' +
        ' AND lang=\'' +
        Languages.name(Settings.current.targetLang) +
        '\'';
    print(qry);
    List<Map> list = await dbClient.rawQuery(qry);
    List<Vertaling> vertalingen = new List();
    for (int i = 0; i < list.length; i++) {
      var vertaling = new Vertaling(
          list[i]["words"], list[i]["translation"], list[i]["lang"]);
      vertaling.setId(list[i]["id"]);
      vertalingen.add(vertaling);
    }

    print(vertalingen.length);
    return vertalingen;
  }

  Future<int> deleteUsers(Vertaling vertaling) async {
    var dbClient = await db;

    int res = await dbClient
        .rawDelete('DELETE FROM Vertaling WHERE id = ?', [vertaling.id]);
    return res;
  }

  Future<bool> updateVertaling(Vertaling vertaling) async {
    var dbClient = await db;
    int res = await dbClient.update("Vertaling", vertaling.toMap(),
        where: "id = ?", whereArgs: <int>[vertaling.id]);
    return res > 0 ? true : false;
  }

  //-- setting --

  Future<int> saveSettings(Settings settings) async {
    var dbClient = await db;
    int res = await dbClient.insert("Vertaling_Settings", settings.toMap());
    Settings.current = settings;
    return res;
  }

  Future<Settings> getSettings() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM Vertaling_Settings');
    if (list.length > 0) {
      Settings settings = new Settings(list[0]["native_lang"],
          list[0]["target_lang"], list[0]["email_address"]);
      print(settings);
      return settings;
    } else {
      return new Settings(LangEnum.NL, LangEnum.IT, "robin.bakkerus@gmail.com");
    }
  }
}
