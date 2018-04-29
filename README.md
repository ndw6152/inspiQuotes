# inspiQuotes
Python endpoint hosted on heroku to get quotes from WikiQuotes

Using [wikiquotes-python-api](https://github.com/FranDepascuali/wikiquotes-python-api)

## Installation
```sh
pip install wikiquotes
```

| REST call |                uri               |               Action               |
|:---------:|:--------------------------------:|:----------------------------------:|
|    GET    | http://[hostname]/quote          |      Get the quote of the day      |
|    GET    | http://[hostname]/quote/\<author> | Get a random quote from the author |
|           |                                  |                                    |