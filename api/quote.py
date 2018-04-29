from flask_restful import Resource
import wikiquotes
from wikiquotes.managers import custom_exceptions


class QuoteOfDay(Resource):
    def get(self):
        quote = wikiquotes.quote_of_the_day("english")
        json_string = {"quote": quote[0], "author": quote[1]}
        return json_string


class RandomQuote(Resource):
    def get(self, author):
        count = 0
        while True:
            try:
                quote = wikiquotes.random_quote(author, "english")
                count += 1
                if count == 10:
                    return "404 Error"
                if len(quote) <= 300:
                    json_string = {"quote": quote, "author": author}
                    return json_string
            except custom_exceptions.TitleNotFound:
                return 500