import 'home_contract.dart';


class HomePresenter implements Presenter {
  Model _model;
  View _view;

  HomePresenter(this._model, this._view);

  @override
  void makeQodCall() {
    _model.fetchQuoteOfDay()
      .then((quote) => _view.showQuote(quote))
      .catchError((e) => _view.handleError());
  }


  @override
  void makeRandomQuoteCall(String author) {
    //    final quote = await _model.fetchRandomQuote(author);
    //    _view.showQuote(quote);

    _model.fetchRandomQuote(author)
        .then((quote) => _view.showQuote(quote))
        .catchError((e) => _view.handleError());
  }
}
