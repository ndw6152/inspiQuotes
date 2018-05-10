import 'dart:async';

import 'home_contract.dart';

class HomePresenter implements Presenter {
  Model _model;
  View _view;

  HomePresenter(this._model, this._view);


  void _showAndUpdateCurQuote(quote) {
    _view.showQuote(quote);
    _model.setCurrentQuote(quote);
    _view.toggleHeart(_model.isFavorite());
  }

  @override
  void makeQodCall() {
    Future futureQuote = _model.fetchQuoteOfDay();
    futureQuote
        .then((quote) => _showAndUpdateCurQuote(quote))
        .catchError((e) => _view.handleWrongAuthor());
  }

  @override
  void makeRandomQuoteCall(String author) {
    //    final quote = await _model.fetchRandomQuote(author);
    //    _view.showQuote(quote);
    _model
        .fetchRandomQuote(author)
        .then((quote) => _showAndUpdateCurQuote(quote))
        .catchError((e) => _view.handleWrongAuthor());
  }

  @override
  void saveQuote() {
    _model.addQuoteToFavorites()
        .then((contain) => _view.toggleHeart(contain));
  }
}
