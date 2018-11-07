import 'package:flutter/material.dart';
import '../widget/main_appbar.dart';
import '../service/vertaling_presenter.dart';
import '../model/vertaling.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Italiaans APP',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new _ExploreHomePage(title: 'Italiaans App'),
    );
  }
}

class _ExploreHomePage extends StatefulWidget {
  _ExploreHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExploreHomePageState createState() => new _ExploreHomePageState();
}

class _ExploreHomePageState extends State<_ExploreHomePage>
    implements HomeContract {
  List<Vertaling> vertalingen;
  HomePresenter homePresenter;

  @override
  State<StatefulWidget> createState() {
    super.initState();
    homePresenter = new HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildMainAppBar(context, 1),
      body: new ListView.builder(
          itemCount: vertalingen == null ? 0 : vertalingen.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                  child: new Center(
                    child: new Row(
                      children: <Widget>[
                        new CircleAvatar(
                          radius: 30.0,
                          child: new Text('todo'),
                          backgroundColor: const Color(0xFF20283e),
                        ),
                        new Expanded(
                          child: new Padding(
                            padding: EdgeInsets.all(10.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  vertalingen[index].words +
                                      " " +
                                      vertalingen[index].translated,
                                  // set some style to text
                                  style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.lightBlueAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new IconButton(
                              icon: const Icon(Icons.delete_forever,
                                  color: const Color(0xFF167F67)),
                              onPressed: () =>
                                  homePresenter.delete(vertalingen[index]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
            );
          }),
    );
  }

  displayRecord() {
    homePresenter.updateScreen();
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
