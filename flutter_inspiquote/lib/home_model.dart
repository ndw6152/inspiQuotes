import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home_contract.dart';


const String base_uri = "https://flask-inspiquote.herokuapp.com";

class Quote {
  final String quoteMessage;
  final String author;

  Quote({this.quoteMessage, this.author,});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return new Quote(
      quoteMessage: json['quote'],
      author: json['author'],
    );
  }
}

class HomeModel implements Model {
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
}


