from flask_restful import Resource
import wikiquotes


class QuoteOfDay(Resource):
    def get(self):
        return wikiquotes.quote_of_the_day("english")


class RandomQuote(Resource):
    def get(self, author):
        while True:
            quote = wikiquotes.random_quote(author, "english")
            if len(quote) <= 300:
                return quote

