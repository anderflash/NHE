package br.poli.ecomp.geav.nhe.model.server;

import org.red5.server.api.IConnection;

import br.poli.ecomp.geav.nhe.model.db.usr.User;

public class ConnectedUser
{
	public User user;
	public IConnection connection;
	public Room current_room;
}
