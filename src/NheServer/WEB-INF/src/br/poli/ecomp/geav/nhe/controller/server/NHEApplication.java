package br.poli.ecomp.geav.nhe.controller.server;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;

import br.poli.ecomp.geav.nhe.controller.db.DBConnection;
import br.poli.ecomp.geav.nhe.model.db.Procedures;
import br.poli.ecomp.geav.nhe.model.db.pro.Project;
import br.poli.ecomp.geav.nhe.model.db.usr.User; 
import br.poli.ecomp.geav.nhe.model.server.ConnectedUser;
import br.poli.ecomp.geav.nhe.model.server.LoginStatus;
import br.poli.ecomp.geav.nhe.model.server.ProcedureResponse;
import br.poli.ecomp.geav.nhe.model.server.Room;

public class NHEApplication extends ApplicationAdapter
{
	private List<Room> rooms_opened = new ArrayList<Room>();
	private List<ConnectedUser> users_connected = new ArrayList<ConnectedUser>();
	
	
	public static void getInstance()
	{
		 
	}
	
	public LoginStatus login(String user, String password)
	{
		
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
					Integer id = (Integer) response.data.get(0).get(response.fields.indexOf("usr_identificador"));
					connectedUser.user.set_usr_identificador(id.intValue());
					users_connected.add(connectedUser);
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
		
		logout();
	}
	
	public LoginStatus logout()
	{
		ConnectedUser userRemoved = null;
		for(int i = 0; i < users_connected.size(); i++)
		{
			if(users_connected.get(i).connection.equals(Red5.getConnectionLocal()))
			{
				userRemoved = users_connected.remove(i);
			}
		}
		
		for(int i = 0; i < rooms_opened.size(); i++)
		{
			rooms_opened.get(i).connected_users.remove(userRemoved);
		}
		LoginStatus loginStatus = new LoginStatus();
		loginStatus.pab_logged = false;
		return loginStatus;
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
			DBConnection.get_connection().commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		Long valor = (Long) response.data.get(0).get(0);
		return valor.intValue();
	}
	
	public ProcedureResponse listProjects()
	{
		Vector<String> parameters = new Vector<String>();
		Integer id = new Integer(getUser().user.get_usr_identificador());
		parameters.add(id.toString());
		
		ProcedureResponse response = new ProcedureResponse();
		try {
			response = DBConnection.get_connection().run_procedure(Procedures.PRO_SEARCH_USR, parameters);
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// TODO: fazer a remoção do módulo
		return response;
	}
	
	private ConnectedUser getUser()
	{
		for(int i = 0; i < users_connected.size(); i++)
		{
			if(users_connected.get(i).connection.equals(Red5.getConnectionLocal()))
			{
				return users_connected.get(i);
			}
		}
		return null;
	}
	
	public Boolean viewProject(int pro_identificador)
	{
		// TODO: fazer a entrada da sala
		IConnection conn = Red5.getConnectionLocal();
		
		// Search for user
		ConnectedUser user = null;
		for(int i = 0; i < users_connected.size(); i++)
		{
			if(users_connected.get(i).connection.equals(conn))
			{
				user = users_connected.get(i);
				break;
			}
		}
		
		
		if(user != null)
		{
			int indice = -1;
		
			// Search room for selected project
			for(int i = 0; i < rooms_opened.size(); i++)
			{
				if(rooms_opened.get(i).current_project.get_pro_identificador() == pro_identificador)
				{
					indice = i;
					break;
				}
			}
			
			try 
			{
				
				DBConnection.get_connection().begin();
				Vector<String> paramPtc = new Vector<String>();
				paramPtc.add(Integer.toString(user.user.get_usr_identificador()));
				paramPtc.add(Integer.toString(pro_identificador));
				ProcedureResponse response = DBConnection.get_connection().run_procedure(Procedures.PTC_SEARCH, paramPtc);
			
				// If found room, just add user to the room (only if he is a ,
				// else create a room and add him (only if he is the owner) 
				if(indice != -1)
				{
					if(response.data.size() > 0 && rooms_opened.get(indice).connected_users.indexOf(user) == -1)
						rooms_opened.get(indice).connected_users.add(user);
					else
						return false;
				}
				else
				{
					if(response.data.size() != 0)
					{
						int coluna = response.fields.indexOf("pfl_identificador");
						
						if((Integer)response.data.get(0).get(coluna) == 2)
						{
							Room newRoom = new Room();
							newRoom.connected_users.add(user);
							newRoom.current_project = new Project();
							newRoom.current_project.set_pro_identificador(pro_identificador);
							rooms_opened.add(newRoom);
						}
						else
							return false;
					}
					else
						return false;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		else
			return false;
		
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


