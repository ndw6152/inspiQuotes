import 'dart:async';
import 'home_model.dart';


/// The UI layer. Displays the data and notifies the Presenter about user actions.
abstract class View {
  void showQuote(Quote quote);
  void handleError();
}


/// The data layer. Responsible for handling the business logic and communication with the network and database layers.
abstract class Model {
  Future fetchQuoteOfDay();
  Future fetchRandomQuote(String author);
}

/// Retrieves the data from the Model, applies the UI logic and manages the state of the View, decides what to display and reacts to user input notifications from the View.
abstract class Presenter {
  void makeQodCall();
  void makeRandomQuoteCall(String author);
}