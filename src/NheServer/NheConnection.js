/**
 * CONNECTION CLASS
 ****************************
 * Autor: Anderson Tavares
 * Updated: 16-06-2011
 * Description: Each socket will create a connection, which hill handle the current user
 * 				the list of projects for which the client has connected...
 */

// Importing the Database Package
var db = require('mysql-native');

/**
 * Constructor for Connection class
 * @param socketTmp the socket which is listening to the client
 * */
function NheConnection(socketTmp)
{
	/******
	 * Private Members
	 * */
	var socket = socketTmp; 		// The connection socket
	var opened_projects = array();	// The opened projects 
	var current_user;				// The current user
	
	this.getSocket = function(){return socket;};
	this.setSocket = function(vrl_socket){socket = vrl_socket;};
	
	this.getProjetosAbertos = function(){return opened_projects;};
	this.setProjetosAbertos = function(vrl_projetos_abertos){ opened_projects = vrl_projetos_abertos;};
	
	this.getUsuarioAtual = function(){return usuario_atual;};
	this.setUsuarioAtual = function(vro_usuario_atual){usuario_atual = vro_usuario_atual;};
	
	this.adicionarProjeto = function(id){};
}

NheConnection.prototype.runCommand = function(command, parameters)
{
	
};

NheConnection.prototype.runProcedure = function(procedure, parameters)
{
	
};