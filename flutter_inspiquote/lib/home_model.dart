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

  Quote currentQuote;
  HashMap<String, Quote> favoriteQuotes = new HashMap<String, Quote>();
  String hash;

  void setCurrentQuote(Quote quote) {
    this.currentQuote = quote;
    this.hash = generateMd5(currentQuote.quoteMessage + currentQuote.author);
  }
  Quote getCurrentQuote() {
    return this.currentQuote;
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
    if(favoriteQuotes.containsKey(hash)) {
      favoriteQuotes.remove(hash);
    }
    else {
      favoriteQuotes[hash] = currentQuote;
    }
    print(hash);
    return favoriteQuotes.containsKey(hash);
  }

  bool isFavorite() {
    return favoriteQuotes.containsKey(hash);
  }

}


