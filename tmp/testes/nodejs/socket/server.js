var net = require('net');
var sys = require('sys');
var socket_list = new Array();

var server = net.createServer(function(socket)
{
	socket.on('data', on_data);
	socket.on('connect', on_connect);
	socket.on('error', on_error);
	socket.on('end', on_end);
	socket.on('timeout', on_timeout);
	
	function policy()
	{
		var xml = '<?xml version="1.0"?>'+
		          '<!DOCTYPE cross-domain-policy SYSTEM '+
				  '"http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">'+
				  '<cross-domain-policy>'+
				  '<allow-access-from domain="*" to-ports="7000"/>'+
				  '</cross-domain-policy>';
		
		return xml;
	}
	
	function on_data(data)
	{
		sys.puts('on_data: '+ data);
		sys.puts(String(data).indexOf('<policy-file-request/>'));
		if(String(data).indexOf('<policy-file-request/>') != -1)
		{
			sys.puts(policy());
			socket.write(policy() + '\0');
		}
		else
		{
			for(var i = 0; i < socket_list.length; i++)
			{
				socket_list[i].write(data + '\0');
				sys.puts("sent: " + data);
			}
		}
	}
	
	function on_connect()
	{
		sys.puts('on_connect');
		for(var i = 0; i < socket_list.length; i++)
		{
			if(socket_list[i] == socket)
				return;
		}
		socket_list.push(socket);
		sys.puts('connected');
	}
	
	function on_end()
	{
		sys.puts('on_end');
		disconnect();
	}
	
	function disconnect()
	{
		sys.puts('disconnect');
		for(var i = 0; i < socket_list.length; i++)
		{
			if(socket_list[i] == socket)
			{
				socket_list.splice(i, 1);
				socket.end();
				return;
			}
		}
	}
	
	function on_timeout()
	{
		sys.puts('on_timeout');
		disconnect();
	}
	
	function on_error()
	{
		sys.puts('on_error');
		disconnect();
	}
	
	
});

server.listen(7000, '192.168.1.8');
console.log('Server listening at 192.168.1.8:7000');