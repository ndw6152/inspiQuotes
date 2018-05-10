import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter_inspiquote/utils.dart';
import 'package:http/http.dart' as http;
import 'home_contract.dart';


const String base_uri = "https://flask-inspiquote.herokuapp.com";

class Quote {
  final String quoteMessage;
  final String author;

  Quote({this.quoteMessage, this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return new Quote(
      quoteMessage: json['quote'],
      author: json['author'],
    );
  }
}

class HomeModel implements Model {

  Quote _currentQuote;
  HashMap<String, Quote> _favoriteQuotes = new HashMap<String, Quote>();
  String _hash;

  void setCurrentQuote(Quote quote) {
    this._currentQuote = quote;
    this._hash = generateMd5(_currentQuote.quoteMessage + _currentQuote.author);
  }

  Quote getCurrentQuote() {
    return this._currentQuote;
  }

  HashMap<String, Quote> getFavoriteQuotes() {
    return _favoriteQuotes;
  }

  @override
  Future<Quote> fetchQuoteOfDay() async {
    final response = await http.get(base_uri);
    final responseJson = json.decode(response.body);
    return new Quote.fromJson(responseJson);
  }

  @override
  Future<Quote> fetchRandomQuote(String author) async {
    final response = await http.get(base_uri + '/quote/' + author);
    final responseJson = json.decode(response.body);

    return new Quote.fromJson(responseJson);
  }

  @override
  Future addQuoteToFavorites() async {
    if(_favoriteQuotes.containsKey(_hash)) {
      _favoriteQuotes.remove(_hash);
    }
    else {
      _favoriteQuotes[_hash] = _currentQuote;
    }
    print(_hash);
    return _favoriteQuotes.containsKey(_hash);
  }

  bool isFavorite() {
    return _favoriteQuotes.containsKey(_hash);
  }

}


