from os import path
from struct import pack

import zmq
from zmq.eventloop import ioloop

from tornado import web
from tornadio2 import SocketConnection, TornadioRouter, SocketServer, event

context = zmq.Context()
publisher = context.socket(zmq.PUB)
publisher.bind("tcp://*:1337")

class IndexHandler(web.RequestHandler):
    def get(self):
        self.render('index.html')

class Connection(SocketConnection):
    @event
    def color(self, value):
        publisher.send(pack("!I", value))

def main():
    router = TornadioRouter(Connection)
    application = web.Application(
           router.apply_routes([(r"/", IndexHandler)]),
           static_path = path.join(path.dirname(__file__), "static")
           )

    SocketServer(application)

if __name__ == "__main__":
    main()

