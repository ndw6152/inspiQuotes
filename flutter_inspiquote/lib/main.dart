import 'package:flutter/material.dart';
import 'package:flutter_inspiquote/network.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new InspiquotePage(),
    );
  }
}

class InspiquotePage extends StatefulWidget  {

  @override
  State createState() => new InspiquoteState();
}


// main page widget
// will contain a view for the quote
// a qod button and a edittext to input authors
class InspiquoteState extends State<InspiquotePage> {
  final TextEditingController _textController = new TextEditingController();
  String quoteMessage = "Hello World. Welcome to InspiQuote!";
  String author = "Neil";


  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
          title: new Text("Inspi_quote")
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new Container(
                  padding: const EdgeInsets.all(32.0),
                    child:
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text(quoteMessage),
                        new Text(
                            "-" + author,
                            style: new TextStyle(
                              fontStyle: FontStyle.italic,
                            )
                        )
                      ],
                    ),
                ),
          ),
          new Divider(height: 1.0,),
          new Container(
            decoration: new BoxDecoration(
              color:  Theme.of(context).cardColor
            ),
            child: _buildUserControls()
            ),
        ],
      )
    );
  }

  // Function fetch the qod and when response receive
  // displays it in the app
  // TODO: need error handling
  void _getQuoteOfDay() {
    final future = fetchQuoteOfDay();
    future.then((quote) {
      _displayQuote(quote);
    });
  }

  Widget _buildUserControls() {
    return new Container(

      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: new Column(
        children: <Widget>[
          new RaisedButton(
              onPressed: _getQuoteOfDay,
              child: const Text('Get quote of the day')
          ),
          _buildTextComposer()
        ],
      ),
    );
  }


  void _displayQuote(Quote q) {
    setState(() {
      quoteMessage = q.quoteMessage;
      author = q.author;
    });
  }

  void _handleError() {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.blueAccent,
      content: new Text("Author does not exist"),
    ));
  }

  // Function call the GET REST api and wait for the response
  void _getRandomQuote(String text) {
    fetchRandomQuoteFrom(text)
        .then((news) => _displayQuote(news))
        .catchError((e) => _handleError());
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child:
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: (text) {_getRandomQuote(text);},
                  decoration: new InputDecoration(
                    hintText: "Author name"
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(

                    icon: new Icon(Icons.search),
                    onPressed: () {
                      _getRandomQuote(_textController.text);
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }
                ),
              )
            ],
          ),
        )
    );
  }
}




