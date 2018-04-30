import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

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

Future<Quote> getQuoteOfDay() async {
  final response =
  await http.get('https://flask-inspiquote.herokuapp.com/');
  final responseJson = json.decode(response.body);

  return new Quote.fromJson(responseJson);
}
