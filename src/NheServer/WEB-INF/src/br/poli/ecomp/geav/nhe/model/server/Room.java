package br.poli.ecomp.geav.nhe.model.server;

import java.util.ArrayList;
import java.util.List;

import org.red5.server.api.IConnection;

import br.poli.ecomp.geav.nhe.model.db.pro.Project;
import br.poli.ecomp.geav.nhe.model.db.usr.User;

public class Room
{
	public List<ConnectedUser> connected_users;
	public Project current_project;
	public ConnectedUser owner;
	
	public Room()
	{
		connected_users = new ArrayList<ConnectedUser>();
	}
	
	public void remove_user(String username)
	{
		for(int i = 0; i < connected_users.size(); i++)
		{
			if(connected_users.get(i).user.get_usr_login() == username)
			{
				connected_users.get(i).current_room = null;
				connected_users.remove(i);
				return;
			}
		}
	}
	
	
	
	public void add_user(String username, IConnection connection)
	{
		for(int i = 0; i < connected_users.size(); i++)
		{
			if(connected_users.get(i).user.get_usr_login() == username)
			{
				return;
			}
		}
		User user = new User();
		user.set_usr_login(username);
		ConnectedUser connectedUser = new ConnectedUser();
		connectedUser.user = user;
		connectedUser.connection = connection;
		connectedUser.current_room = this;
		connected_users.add(connectedUser);
	}
}
