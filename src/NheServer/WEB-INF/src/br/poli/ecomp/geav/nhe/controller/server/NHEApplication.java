package br.poli.ecomp.geav.nhe.controller.server;

import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;

import br.poli.ecomp.geav.nhe.controller.db.DBConnection;
import br.poli.ecomp.geav.nhe.model.db.Procedures;
import br.poli.ecomp.geav.nhe.model.db.usr.User;
import br.poli.ecomp.geav.nhe.model.server.ConnectedUser;
import br.poli.ecomp.geav.nhe.model.server.LoginStatus;
import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
import br.poli.ecomp.geav.nhe.model.server.Room;

public class NHEApplication extends ApplicationAdapter
{
	private List<Room> rooms_opened;
	private List<ConnectedUser> users_connected;
	
	public LoginStatus login(String user, String password)
	{
		Red5.getConnectionLocal();
		LoginStatus status = new LoginStatus();
		
		try {
			DBConnection.get_connection().begin();
			Vector<String> parameters = new Vector<String>();
			parameters.add("'" + user + "'");
			parameters.add("'" + password + "'");
			ProcedureResponse response = DBConnection.get_connection().run_procedure(Procedures.USR_LOGIN, parameters);
			status.pao_user = response;
			if(!response.data.isEmpty())
			{
				Boolean hasUser = false;
				for(int i = 0; i < users_connected.size(); i++)
				{
					if(users_connected.get(i).user.get_usr_login().equals(user))
					{
						hasUser = true;
					}
				}
				
				if(!hasUser)
				{
					ConnectedUser connectedUser = new ConnectedUser();
					connectedUser.connection = Red5.getConnectionLocal();
					connectedUser.current_room = null;
					connectedUser.user = new User();
					connectedUser.user.set_usr_login(user);
				}
				status.pab_logged = true;
			}
			else
				status.pab_logged = false;
		} catch (SQLException e) {
			status.pab_logged = false;
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			status.pab_logged = false;
			e.printStackTrace();
		}
		
		return status;
	}
	
	@Override
	public void appDisconnect(IConnection conn) {
		super.appDisconnect(conn);
		
		ConnectedUser userRemoved = null;
		for(int i = 0; i < users_connected.size(); i++)
		{
			if(users_connected.get(i).connection.equals(conn))
			{
				userRemoved = users_connected.remove(i);
			}
		}
		
		for(int i = 0; i < rooms_opened.size(); i++)
		{
			rooms_opened.get(i).connected_users.remove(userRemoved);
		}
		
	}
	
	public Boolean logout(String user)
	{
		ConnectedUser userRemoved = null;
		for(int i = 0; i < users_connected.size(); i++)
		{
			if(users_connected.get(i).user.equals(user))
			{
				userRemoved = users_connected.remove(i);
			}
		}
		
		for(int i = 0; i < rooms_opened.size(); i++)
		{
			rooms_opened.get(i).connected_users.remove(userRemoved);
		}
		return true;
	}
	
	public int createProject(String title, String description, String model, List<String> participants, int usr_id)
	{
		Vector<String> parameters = new Vector<String>();
		parameters.add("'" + title + "'");
		parameters.add("'" + description + "'");
		parameters.add(Integer.toString(usr_id));
		parameters.add("'" + model + "'");
		ProcedureResponse response;
		try {
			DBConnection.get_connection().begin();
			response = DBConnection.get_connection().run_procedure(Procedures.PRO_CREATE, parameters);
			for(int i = 0; i < participants.size(); i++)
			{
				Vector<String> paramPtc = new Vector<String>();
				paramPtc.add("'" + participants.get(i) + "'");
				paramPtc.add("'" + response.data.get(0).get(0) + "'");
				DBConnection.get_connection().run_procedure(Procedures.PTC_CREATE, parameters);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return Integer.parseInt((String) response.data.get(0).get(0));
	}
	
	public Boolean listProjects()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean enterProject()
	{
		// TODO: fazer a entrada da sala
		return true;
	}
	
	public Boolean exitProject()
	{
		// TODO: fazer a saída da sala
		return true;
	}
	
	public Boolean listParticipants()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean changeUserName()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean changeUserRole()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean loadModel()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean addModule()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean moveModule()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean removeModule()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean undoState()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean setCurrentState()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean removeState()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
	public Boolean simulateModel()
	{
		// TODO: fazer a remoção do módulo
		return true;
	}
	
}


