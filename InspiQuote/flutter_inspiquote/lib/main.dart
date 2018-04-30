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
  String quoteMessage = "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.";
  String author = "Neil";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      setState(() {
        quoteMessage = quote.quoteMessage;
        author = quote.author;
      });
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

  // Function call the GET REST api and wait for the response
  // TODO: need error handling
  void _getRandomQuote(String text) {
    final future = fetchRandomQuoteFrom(text);
    future.then((quote) {
      setState(() {
        quoteMessage = quote.quoteMessage;
        author = quote.author;
      });
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _getRandomQuote(text);
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
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration(
                    hintText: "Author name"
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(

                    icon: new Icon(Icons.search),
                    onPressed: () => _handleSubmitted(_textController.text)
                ),
              )
            ],
          ),
        )
    );
  }
}




