package model.server
{
	public class ServerDefaults
	{
		public static const HOST:String = "localhost";
		public static const PORT:Number = 5555;
		
		public static var SEPARATOR_REQUESTS:String = String.fromCharCode(1);
		public static var SEPARATOR_FIELDS:String = String.fromCharCode(2);
		
		/*-------------------------------------------
		 * REQUESTS
		 ------------------------------------------*/
		/**
		 * If you run any procedure, use this function 
		 */
		public static const REQUEST_RUN_PROCEDURE:Number = 1;
		public static const RESPONSE_PROCEDURE_RETURNED:Number = 1;
		
		/**
		 * For sending chat 
		 */
		public static const REQUEST_CHAT_SEND:Number = 2;
		public static const RESPONSE_CHAT_RECEIVED:Number = 2;
		
		/**
		 * For moving the project 
		 */
		public static const REQUEST_PROJECT_MOVE:Number = 4;
		public static const RESPONSE_PROJECT_MOVED:Number = 4;
		
		/**
		 * For adding a component
		 */
		public static const REQUEST_COMPONENT_ADD:Number = 5;
		public static const RESPONSE_COMPONENT_ADDED:Number = 5;
		
		
		/**
		 * For receiving a component
		 */
		public static const REQUEST_COMPONENT_REMOVE:Number = 6;
		public static const RESPONSE_COMPONENT_REMOVED:Number = 6;
		
		/**
		 * For updating a component (moving for example)
		 */
		public static const REQUEST_COMPONENT_MOVE:Number = 7;
		public static const RESPONSE_COMPONENT_MOVED:Number = 7;
		
		/**
		 * For undo the project
		 */
		public static const REQUEST_PROJECT_UNDO:Number = 8;
		public static const RESPONSE_PROJECT_UNDONE:Number = 8;
		
		/**
		 * If the owner reject a state
		 */
		public static const REQUEST_OWNER_REJECT:Number = 9;
		public static const RESPONSE_OWNER_REJECTED:Number = 9;
		
		/**
		 * If the owner accept a state
		 */
		public static const REQUEST_OWNER_ACCEPT:Number = 10;
		public static const RESPONSE_OWNER_ACCEPTED:Number = 10;
		
		/**
		 * If the current state is set
		 */
		public static const REQUEST_PROJECT_STATE_CURRENT_SET:Number = 11;
		public static const RESPONSE_PROJECT_STATE_CURRENT_SET:Number = 11;
		
		
		/**
		 * If the owner finish the project
		 */
		public static const REQUEST_PROJECT_FINISH:Number = 12;
		public static const RESPONSE_PROJECT_FINISHED:Number = 12;
		
		/**
		 * If the owner ban a user
		 */
		public static const REQUEST_PROJECT_USER_BAN:Number = 13;
		public static const RESPONSE_PROJECT_USER_BANNED:Number = 13;

		/**
		 * If the owner set the profile of the user
		 */
		public static const REQUEST_PROJECT_USER_PROFILE_SET:Number = 14;
		public static const RESPONSE_PROJECT_USER_PROFILE_SET:Number = 14;
		
		/**
		 * Connect the user
		 */
		public static const REQUEST_USER_CONNECT:Number = 16;
		public static const RESPONSE_USER_CONNECTED:Number = 16; 
		
		/**
		 * Connect
		 */
		public static const REQUEST_USER_DISCONNECT:Number = 17;
		public static const RESPONSE_USER_DISCONNECTED:Number = 17;
		
		/**
		 * 
		 */
		public static const REQUEST_USER_PROJECT_ENTER:Number = 18;
		public static const RESPONSE_USER_PROJECT_ENTERED:Number = 18;
		
		/**
		 * 
		 */
		public static const REQUEST_USER_PROJECT_EXIT:Number = 19;
		public static const RESPONSE_USER_PROJECT_EXITED:Number = 19;
		
		
		public static const REQUEST_PROJECT_SAVE:Number = 20;
		public static const RESPONSE_PROJECT_SAVED:Number = 20;
		
		public static const REQUEST_PROJECT_CLOSED:Number = 21;
		public static const RESPONSE_PROJECT_CLOSED:Number = 21;
		
		
		
		/*-------------------------------------
		 * RESPONSES 
		 ------------------------------------*/
		
		
			
		public function ServerDefaults()
		{
			
		}
	}
}