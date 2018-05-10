import 'package:flutter/material.dart';
import 'home_page_favorites.dart';
import 'home_contract.dart';
import 'home_model.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements View {
  HomePresenter _presenter;
  BuildContext _scaffoldContext;
  final TextEditingController _textController = new TextEditingController();
  String quoteMessage = "Hello World. Welcome to InspiQuote!";
  String author = "Neil";

  bool contained = false;

  @override
  void initState() {
    super.initState();
    _presenter = new HomePresenter(new HomeModel(), this);
  }

  void searchButtonPressed(String author) {
    _presenter.makeRandomQuoteCall(author);
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: (author) {
                    searchButtonPressed(author);
                  },
                  decoration: new InputDecoration(hintText: "Author name"),
                ),
              ),
              new IconButton(
                  icon: new Icon(Icons.search),
                  tooltip: "Search quote from author",
                  onPressed: () {
                    searchButtonPressed(_textController.text);
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }),
            ],
          ),
        ));
  }

  Widget _buildBottomBar() {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      onPressed: _presenter.makeQodCall,
                      child: const Text('Get quote of the day')),
                ],
              )),
              new IconButton(
                  icon: new Icon(
                    contained ? Icons.favorite : Icons.favorite_border,
                    color: contained ? Colors.red : null,
                  ),
                  onPressed: _saveQuote),
            ],
          ),
          _buildTextComposer()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = new Column(
      children: <Widget>[
        new Flexible(
          child: new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Text(quoteMessage),
                new Text("-" + author,
                    style: new TextStyle(
                      fontStyle: FontStyle.italic,
                    ))
              ],
            ),
          ),
        ),
        new Divider(
          height: 1.0,
        ),
        new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildBottomBar()),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("InspiQuote"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _getFavoriteQuotes,
          ),
        ],
      ),
      body: new Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return body;
      }),
    );
  }

  /// Called by the presenter once data is available
  void showQuote(Quote quote) {
    setState(() {
      quoteMessage = quote.quoteMessage;
      author = quote.author;
    });
  }

  @override
  void handleWrongAuthor() {
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
          backgroundColor: Colors.deepPurple,
          content: new Text("Invalid author"),
          duration: new Duration(seconds: 3),
        ));
  }

  void _saveQuote() {
    _presenter.saveQuote();
  }

  void toggleHeart(contained) {
    setState(() {
      this.contained = contained;
    });
  }

  void _getFavoriteQuotes() {
    _presenter.getFavoriteQuotesCall();
  }

  void displayFavoriteQuotes(mapOfQuotes) {
    Navigator.of(context).push(new MaterialPageRoute (
      builder: (BuildContext context) {
        return new HomePageFavorites(favoriteQuotes: mapOfQuotes);
      },
    ));
  }
}
