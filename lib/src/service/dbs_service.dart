import 'dart:async';

import '../model/vertaling.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    String path = join(databasesPath, 'vertalingen.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Vertaling(id INTEGER PRIMARY KEY, words TEXT, translation TEXT, lang TEXT)");
  }

  Future<int> saveVertaling(Vertaling vertaling) async {
    var dbClient = await db;
    int res = await dbClient.insert("Vertaling", vertaling.toMap());
    return res;
  }

  Future<List<Vertaling>> getVertalingen() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Vertaling');
    List<Vertaling> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var vertaling =
          new Vertaling(list[i]["firstname"], list[i]["lastname"], list[i]["dob"]);
      vertaling.setUserId(list[i]["id"]);
      employees.add(vertaling);
    }
    print(employees.length);
    return employees;
  }

  Future<int> deleteUsers(Vertaling vertaling) async {
    var dbClient = await db;

    int res =
        await dbClient.rawDelete('DELETE FROM Vertaling WHERE id = ?', [vertaling.id]);
    return res;
  }

  Future<bool> update(Vertaling vertaling) async {
    var dbClient = await db;
    int res =   await dbClient.update("Vertaling", vertaling.toMap(),
        where: "id = ?", whereArgs: <int>[vertaling.id]);
    return res > 0 ? true : false;
  }
}