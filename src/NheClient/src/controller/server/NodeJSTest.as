package
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	import flash.system.Security;
	
	import org.aswing.AsWingManager;
	import org.aswing.Container;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JScrollPane;
	import org.aswing.JTextArea;
	import org.aswing.JTextField;
	import org.aswing.SoftBoxLayout;
	import org.aswing.event.AWEvent;
	
	public class NodeJSTest extends Sprite
	{
		public static const CONNECTED:Boolean = true;		
		public static const DISCONNECTED:Boolean = false;

		
		private var frame:JFrame;
		private var send_btn:JButton;
		private var output_txt:JTextArea;
		private var input_txt:JTextField;
		private var disconnect_btn:JButton;
		private var xmlSocket:XMLSocket;
		
		private var _estado:Boolean;
		private var scrollpane:JScrollPane;
		
		public function NodeJSTest()
		{
			criarFrame();
			conectar();
		}
		
		public function criarFrame():void
		{
			AsWingManager.initAsStandard(this);
			frame = new JFrame(this, "Chat");
			send_btn = new JButton("Send");
			output_txt = new JTextArea("",5,40);
			input_txt = new JTextField("",40);
			disconnect_btn = new JButton("Connect");
			
			scrollpane = new JScrollPane(output_txt);
			
			var painel:Container = frame.getContentPane();
			painel.append(scrollpane);
			painel.append(input_txt);
			painel.append(send_btn);
			painel.append(disconnect_btn);
			painel.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			
			send_btn.addActionListener(sendClicked);
			disconnect_btn.addActionListener(disconnectClicked);
			frame.setDefaultButton(disconnect_btn);
			
			frame.show();
			frame.pack();
			send_btn.setEnabled(false);
		}
		
		public function conectar():void
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			xmlSocket = new XMLSocket();
			xmlSocket.addEventListener(DataEvent.DATA, socket_data_event);
			xmlSocket.addEventListener(Event.CLOSE, socket_close_event);
			xmlSocket.addEventListener(Event.CONNECT, socket_connect_event);
			xmlSocket.addEventListener(IOErrorEvent.IO_ERROR, socket_io_error_event);
			xmlSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, socket_security_error_event);
		}
		
		
		private function sendClicked(e:AWEvent = null):void
		{
			xmlSocket.send(input_txt.getText());
			input_txt.setText("");
			input_txt.requestFocus();
		}
		
		private function disconnectClicked(e:AWEvent = null):void
		{
			if(xmlSocket.connected) disconnect();
			else					connect();
		}
		
		private function connect():void
		{
			xmlSocket.connect("127.0.0.1", 7000);
		}
		private function disconnect():void
		{
			if(xmlSocket.connected)
				xmlSocket.close();
			estado = DISCONNECTED;
		}
		
		private function socket_data_event(e:DataEvent):void
		{
			if(e.data.indexOf("<?xml") == -1)
			{
				trace("Recebido: " + e.data);
				output(e.data);
			}
			else
			{
				trace("Recebido Política");
				output("Recebido Política");
			}
		}
		private function socket_close_event(e:Event):void
		{
			estado = DISCONNECTED;
		}
		private function socket_connect_event(e:Event):void
		{
			estado = CONNECTED;
		}
		private function socket_io_error_event(e:IOErrorEvent):void
		{
			disconnect();
		}
		private function socket_security_error_event(e:SecurityErrorEvent):void
		{
			disconnect();
		}
		
		public function output(msg:String):void
		{
			if(msg.length > 0)
				output_txt.appendText(msg + "\n");
			scrollpane.getVerticalScrollBar().setValue(scrollpane.getVerticalScrollBar().getMaximum());
		}
		
		private function set estado(value:Boolean):void
		{
			if(_estado != value)
			{
				_estado = value;
				
				if(value == DISCONNECTED)
				{
					output("Desconectado");
					send_btn.setEnabled(false);
					disconnect_btn.setText("Connect");
					frame.setDefaultButton(disconnect_btn);
				}
				else
				{
					output("Conectado");
					send_btn.setEnabled(true);
					disconnect_btn.setText("Disconnect");
					frame.setDefaultButton(send_btn);
				}
			}
			
		}
		
	}
}