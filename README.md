# inspiQuotes
Python endpoint hosted on heroku to get quotes from WikiQuotes

Using [wikiquotes-python-api](https://github.com/FranDepascuali/wikiquotes-python-api)

## Installation
```sh
pip install wikiquotes
```

## REST endpoints
| REST call |                uri               |               Action               |
|:---------:|:--------------------------------:|:----------------------------------:|
|    GET    | http://[hostname]/quote          |      Get the quote of the day      |
|    GET    | http://[hostname]/quote/\<author> | Get a random quote from the author |
|           |                                  |                                    |

## Deployed on Heroku
```sh
git subtree push --prefix InspiQuoteServer/ heroku master
```
*https://flask-inspiquote.herokuapp.com*

## Android app
InspiQuote app provides a button to GET the quote of the day as well as random quotes from an author


Quote of the day             |  Quote
:-------------------------:|:-------------------------:
![qod](captures/qod.png)|  ![quote](captures/quote.png)

