var db = require('mysql-native');

function NheConnection(socketTmp)
{
	var socket = socketTmp;
	var projetos_abertos = array();
	var usuario_atual;
	
	this.getSocket = function(){return socket;}
	this.setSocket = function(vrl_socket){socket = vrl_socket;)
	
	this.getProjetosAbertos = function(){return projetos_abertos;}
	this.setProjetosAbertos = function(vrl_projetos_abertos){ projetos_abertos = vrl_projetos_abertos;}
	
	this.getUsuarioAtual = function(){return usuario_atual);}
	this.setUsuarioAtual = function(vro_usuario_atual){usuario_atual = vro_usuario_atual}
	
	this.adicionarProjeto = function(id)
}

NheConnection.prototype.runCommand = function(command, parameters)
{
	
}

NheConnection.prototype.runProcedure = function(procedure, parameters)
{
	
}