var http = require('http');

var server = http.createServer(tratar_request);

function tratar_request(request, response)
{
	response.writeHeader(200, {'Content-Type':'text/html'});
	response.write('hello');
	response.end();
}

server.listen(8080, '127.0.0.1');

console.log('Server listening at 127.0.0.1:8080');