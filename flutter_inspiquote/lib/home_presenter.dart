import 'dart:async';

import 'home_contract.dart';
import 'package:flutter_inspiquote/home_model.dart';


class HomePresenter implements Presenter {
  Model _model;
  View _view;

  HomePresenter(this._model, this._view);

  @override
  void makeQodCall() {
    Future futureQuote = _model.fetchQuoteOfDay();
    futureQuote
        .then((quote) => _view.showQuote(quote))
        .catchError((e) => _view.handleWrongAuthor());
  }

  @override
  void makeRandomQuoteCall(String author) {
    //    final quote = await _model.fetchRandomQuote(author);
    //    _view.showQuote(quote);

    _model
        .fetchRandomQuote(author)
        .then((quote) => _view.showQuote(quote))
        .catchError((e) => _view.handleWrongAuthor());
  }

  @override
  void saveQuote(Quote quote) {
    // TODO: implement saveQuote
  }
}
