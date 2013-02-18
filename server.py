import os
import zmq
from bottle import run, route, static_file, template
import signal

context = zmq.Context().instance()
socket = context.socket(zmq.PUB)
socket.bind('tcp://*:7777')

@route('/')
def index():
    return template('index')

@route('/color/:param')
def color(param):
    socket.send(param)

@route('/static/:filename#.*#')
def server_static(filename):
    return static_file(filename, root=os.path.join(os.path.dirname(__file__), 'static'))

run(host='0.0.0.0', port=80)

