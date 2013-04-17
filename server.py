from os import path
from tornado import web
from tornadio2 import SocketConnection, TornadioRouter, SocketServer, event

ROOT = path.normpath(path.dirname(__file__))

class IndexHandler(web.RequestHandler):
    def get(self):
        self.render('index.html')

class Connection(SocketConnection):
    @event
    def color(self, value):
        print value

router = TornadioRouter(Connection, dict(enabled_protocols=['websocket', 'xhr-polling', 'jsonp-polling', 'htmlfile']))

application = web.Application(
        router.apply_routes([
            (r"/", IndexHandler),
            (r'/static/(.*)', web.StaticFileHandler, {'path': path.join(ROOT, 'static')}),
            ]),
        flash_policy_port = 843,
        flash_policy_file = path.join(ROOT, 'flashpolicy.xml'),
        socket_io_port = 8001
    )

if __name__ == "__main__":
    SocketServer(application)

