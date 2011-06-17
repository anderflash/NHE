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
var EventEmitter = require('events').EventEmitter();

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
	
	this.adicionarProjeto = function(pro_identificador){opened_projects.push(pro_identificador);};
}
NheConnection.prototype = new EventEmitter();

NheConnection.prototype.runCommand = function(command, parameters)
{
	switch(command)
	{
		case '1':// Run Procedure
			break;
		case '3':// Send Chat
			break;
		case '3':// Move Project
			break;
		case '4':// Add Component
			break;
		case '5':// Remove Component
			break;
		case '6':// Move Component
			break;
		case '7':// Undo Project
			break;
		case '8':// Reject Owner
			break;
		case '9':// Accept Owner
			break;
		case '10':// Set Current State of the Project
			break;
		case '11':// Finish Project
			break;
		case '12':// Ban User
			break;
		case '13':// Set role of the user
			break;
		case '14':// User connected to the system
			break;
		case '15':// User disconnected to the system
			break;
		
	}
};

NheConnection.prototype.runProcedure = function(procedure, parameters)
{
	
};

NheConnection.prototype.enterProject = function()
{
	
};

NheConnection.prototype.exitProject = function()
{
	
};

