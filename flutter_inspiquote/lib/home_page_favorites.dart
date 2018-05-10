import 'dart:collection';
import 'package:flutter/material.dart';
import 'home_model.dart';

class HomePageFavorites extends StatefulWidget {
  final HashMap<String, Quote> favoriteQuotes;

  HomePageFavorites({Key key, this.favoriteQuotes}) : super(key: key);

  @override
  _HomeFavoritesState createState() => new _HomeFavoritesState(favoriteQuotes);
}

class _HomeFavoritesState extends State<HomePageFavorites> {
  HashMap<String, Quote> favoriteQuotes;
  final _biggerFont = const TextStyle(fontSize: 16.0);

  _HomeFavoritesState(favoriteQuotes) {
    this.favoriteQuotes = favoriteQuotes;
  }

  void removeQuoteFromFavorite(String hash) {
    setState(() {
      favoriteQuotes.remove(hash);
    });
  }

  void showAlertDialog(String hash) {
    Quote quote = favoriteQuotes[hash];
    AlertDialog dialog = new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text('-' + favoriteQuotes[hash].author,
              style: new TextStyle(
                fontStyle: FontStyle.italic,
              )),
          new Text(
            '"' + quote.quoteMessage + '"',
            style: new TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );

    showDialog(context: context, child: dialog);
  }

  Widget _buildRow(String hash) {
    return new ListTile(
        title: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text('-' + favoriteQuotes[hash].author,
                style: new TextStyle(
                  fontStyle: FontStyle.italic,
                )),
            new Text(
              favoriteQuotes[hash].quoteMessage,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
        trailing: new IconButton(
            icon: new Icon(
              Icons.close,
              color: null,
            ),
            onPressed: () {
              removeQuoteFromFavorite(hash);
            }),
        onTap: () {
          showAlertDialog(hash);
        });
  }

  Widget _buildSuggestions() {
    List quotesList = favoriteQuotes.keys.toList();

    return new ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quotesList.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(quotesList.elementAt(index));
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Favorite quotes"),
      ),
      body: _buildSuggestions(),
    );
  }
}
