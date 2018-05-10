import 'dart:async';
import 'home_model.dart';


/// The UI layer. Displays the data and notifies the Presenter about user actions.
abstract class View {
  void showQuote(Quote quote);
  void handleWrongAuthor();

  void showFavorites();
  void toggleHeart(contained);
}

/// Retrieves the data from the Model, applies the UI logic and manages the state of the View, decides what to display and reacts to user input notifications from the View.
abstract class Presenter {
  void makeQodCall();
  void makeRandomQuoteCall(String author);

  void saveQuote();  // cur quote is already in model
}

/// The data layer. Responsible for handling the business logic and communication with the network and database layers.
abstract class Model {
  void getCurrentQuote();
  void setCurrentQuote(Quote quote);

  Future fetchQuoteOfDay();
  Future fetchRandomQuote(String author);

  bool isFavorite();
  Future addQuoteToFavorites();
}

