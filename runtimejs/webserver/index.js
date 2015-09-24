'use strict';

const runtime = require('runtimejs');
const HttpResponse = require('eshttp').HttpResponse;
const HttpServer = require('eshttp').HttpServer;

const server = new HttpServer();
const response = new HttpResponse(200, { server: 'runtimejs' }, 'Hello StrangeLoop!');

server.onrequest = request => {
  request.respondWith(response);
};

server.listen(9000);
console.log('listening to port 9000');
