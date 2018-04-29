from flask import Flask
from flask_restful import Api
import waitress
import os

from api.quote import QuoteOfDay, RandomQuote


def init_app():
    app = Flask(__name__)
    api = Api(app)
    api.add_resource(QuoteOfDay, '/', '/quote/')
    api.add_resource(RandomQuote, '/quote/<author>')
    api.init_app(app)

    return app


if __name__ == '__main__':
    app = init_app()
    waitress.serve(app, host='0.0.0.0', port=os.environ.get('PORT', 5000), cleanup_interval=100)
