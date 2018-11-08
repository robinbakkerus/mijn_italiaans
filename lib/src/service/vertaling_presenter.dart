import 'dbs_service.dart';
import '../model/vertaling.dart';
import 'dart:async';

abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {
  HomeContract _view;
  var db = new DatabaseHelper();
  HomePresenter(this._view);
  
  delete(Vertaling user) {
    var db = new DatabaseHelper();
    db.deleteUsers(user);
    updateScreen();
  }

  Future<List<Vertaling>> getUser() {
    return db.getVertalingen();
  }

  updateScreen() {
    _view.screenUpdate();

  }
}