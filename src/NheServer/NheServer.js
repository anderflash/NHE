/**
 * SERVER CLASS
 ****************************
 * Autor: Anderson Tavares
 * Updated: 16-06-2011
 */

// Import net package
var net = require('net');

/*
	Server Class Constructor
*/
var Server = function()
{
	this.connection_list = array();
	var serv = net.createServer(function(socket)
	{
		
	
		socket.on('data', on_data);
		socket.on('connect', on_connect);
		socket.on('error', on_error);
		socket.on('end', on_end);
		socket.on('timeout', on_timeout);
		
		/**
		* Return the xml file policy
		*/
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
		
		/**
		* Executed when a client has sent data 
		*/
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
		
		/**
		* Executed when a client has connected 
		*/
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
			
			// Create Connection
			
		}
		
		/**
		* EVENT: Executed when a client has ended a connection
		*/
		function on_end()
		{
			sys.puts('on_end');
			disconnect();
		}
		
		/**
		* Disconnect the client
		* Remove-it from the list
		* Warn others that he left (TODO)
		*/
		function disconnect()
		{
			sys.puts('disconnect');
			for(var i = 0; i < this.connection_lis.length; i++)
			{
				if(this.connection_list[i].getSocket == socket)
				{
					this.connection_list.splice(i, 1);
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
};

Server.prototype.getInstance = function()
{
	return new Server();
};

Server.prototype.setAddress = function(host, port)
{
	this.host = host;
	this.port = port;
};

Server.prototype.startServer = function()
{
	
};

var server = Server.getInstance();
server.setAddress('127.0.0.1', 7000);
server.startServer();