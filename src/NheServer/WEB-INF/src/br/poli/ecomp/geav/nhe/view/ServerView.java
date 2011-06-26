package br.poli.ecomp.geav.nhe.view;

import java.awt.GraphicsConfiguration;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

//import br.poli.ecomp.geav.nhe.controller.server.ServerController;

public class ServerView extends JFrame
{
	private javax.swing.JButton btnControlarSistema;
    private javax.swing.JButton btnDesconectar;
    private javax.swing.JButton btnEnviarMsg;
    private javax.swing.JButton btnLimparMsgs;
    private javax.swing.JLabel lblMensagens;
    private javax.swing.JLabel lblConectados;
    private javax.swing.JLabel lblFundo;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    public javax.swing.JList listaUsuarios;
    private javax.swing.JTextArea txtDebug;

    /**
	 * 
	 */
	private static final long serialVersionUID = 7672105816562744278L;
	
	public ServerView(GraphicsConfiguration arg0) {
		super(arg0);
		init();
	}

	public ServerView(String arg0) throws HeadlessException {
		super(arg0);
		init();
	}
	
	private void initComponents() {
		 jScrollPane1 = new javax.swing.JScrollPane();
	        txtDebug = new javax.swing.JTextArea();
	        lblMensagens = new javax.swing.JLabel();
	        lblConectados = new javax.swing.JLabel();
	        jScrollPane2 = new javax.swing.JScrollPane();
	        listaUsuarios = new javax.swing.JList();
	        btnDesconectar = new javax.swing.JButton();
	        lblFundo = new javax.swing.JLabel();
	        btnEnviarMsg = new javax.swing.JButton();
	        btnControlarSistema = new javax.swing.JButton();
	        btnLimparMsgs = new javax.swing.JButton();

	        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
	        setTitle("Servidor NHE - Feito por Anderson Carlos Moreira Tavares");
	        setIconImage(icone());

	        txtDebug.setColumns(20);
	        txtDebug.setRows(5);
	        jScrollPane1.setViewportView(txtDebug);

	        lblMensagens.setText("Mensagens");

	        lblConectados.setText("Usuários Conectados");

	        jScrollPane2.setViewportView(listaUsuarios);
	        updateDesconectarEnable();
	        updateMensagemEnable();
	        btnDesconectar.setText("Desconectar");
	        btnDesconectar.addActionListener(new java.awt.event.ActionListener()
	        {
	            public void actionPerformed(java.awt.event.ActionEvent evt)
	            {
	                btnDesconectarActionPerformed(evt);
	            }
	        });

	        lblFundo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/images/fundoMiniatura.jpg"))); // NOI18N

	        btnEnviarMsg.setText("Enviar Mensagem");
	        btnEnviarMsg.addActionListener(new java.awt.event.ActionListener() {
	            public void actionPerformed(java.awt.event.ActionEvent evt) {
	                btnEnviarMsgActionPerformed(evt);
	            }
	        });

	        updateControlarLabel();
	        btnControlarSistema.addActionListener(new java.awt.event.ActionListener() {
	            public void actionPerformed(java.awt.event.ActionEvent evt) {
	                btnControlarSistemaActionPerformed(evt);
	            }
	        });

	        btnLimparMsgs.setText("Limpar Msgs");
	        btnLimparMsgs.addActionListener(new java.awt.event.ActionListener() {
	            public void actionPerformed(java.awt.event.ActionEvent evt) {
	                btnLimparMsgsActionPerformed(evt);
	            }
	        });

	        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
	        getContentPane().setLayout(layout);
	        layout.setHorizontalGroup(
	            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	            .addGroup(layout.createSequentialGroup()
	                .addContainerGap()
	                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	                    .addComponent(lblMensagens)
	                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 375, javax.swing.GroupLayout.PREFERRED_SIZE))
	                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
	                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	                    .addComponent(lblFundo)
	                    .addGroup(layout.createSequentialGroup()
	                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
	                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
	                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	                            .addComponent(btnLimparMsgs, javax.swing.GroupLayout.DEFAULT_SIZE, 136, Short.MAX_VALUE)
	                            .addComponent(btnEnviarMsg, javax.swing.GroupLayout.DEFAULT_SIZE, 136, Short.MAX_VALUE)
	                            .addComponent(btnDesconectar, javax.swing.GroupLayout.DEFAULT_SIZE, 136, Short.MAX_VALUE)
	                            .addComponent(btnControlarSistema, javax.swing.GroupLayout.DEFAULT_SIZE, 136, Short.MAX_VALUE)))
	                    .addComponent(lblConectados))
	                .addContainerGap())
	        );
	        layout.setVerticalGroup(
	            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	            .addGroup(layout.createSequentialGroup()
	                .addContainerGap()
	                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
	                    .addComponent(lblMensagens)
	                    .addComponent(lblConectados))
	                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
	                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	                    .addGroup(layout.createSequentialGroup()
	                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
	                            .addGroup(layout.createSequentialGroup()
	                                .addComponent(btnDesconectar)
	                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
	                                .addComponent(btnEnviarMsg)
	                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
	                                .addComponent(btnControlarSistema)
	                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
	                                .addComponent(btnLimparMsgs))
	                            .addComponent(jScrollPane2, 0, 0, Short.MAX_VALUE))
	                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
	                        .addComponent(lblFundo))
	                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 328, Short.MAX_VALUE))
	                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
	        );

	        pack();
		
	}

	private void updateControlarLabel()
	{
		/*try {
			if(ServerController.getInstance().getPrb_running())
				btnControlarSistema.setText("Parar o Sistema");
			else
				btnControlarSistema.setText("Continuar Sist.");
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
	}

	private void updateDesconectarEnable()
	{
		Boolean enabled = false;
		if(listaUsuarios.getSelectedIndex() == -1)
    		enabled = false;
    	else
    		enabled = true;
        btnDesconectar.setEnabled(enabled);
	}
	
	private void updateMensagemEnable()
	{
		Boolean enabled = false;
		if(listaUsuarios.getSelectedIndex() == -1)
    		enabled = false;
    	else
    		enabled = true;
        btnEnviarMsg.setEnabled(enabled);
	}

	protected void btnLimparMsgsActionPerformed(ActionEvent evt) {
		txtDebug.setText("");
		
	}

	protected void btnControlarSistemaActionPerformed(ActionEvent evt) {
		controlarSistema();
	}

	private void controlarSistema() {
		/*try {
			if(btnControlarSistema.getText().equals("Parar o Sistema"))
	        {
	            ServerController.getInstance().server_stop();
	            trace("Sistema parado");
	        }
	        else if(btnControlarSistema.getText().equals("Continuar Sist."))
	        {
            	ServerController.getInstance().server_start();
                trace("Sistema iniciado");
	        }
			updateControlarLabel();
		} catch (IOException ex) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
	}

	protected void btnEnviarMsgActionPerformed(ActionEvent evt)
	{
		/*if(servidorDialogo.listaUsuarios.getSelectedIndex() == -1)
        {
            JOptionPane.showMessageDialog(null, "Você não selecionou um usuário na lista");
        }
        else
        {
            String mensagem = JOptionPane.showInputDialog("Digite a mensagem");
            ArrayList<UsuarioThread> listaUsuariosArray = Servidor.servidor.supervisorThread.getListaUsuarios();
            for(UsuarioThread usuario:listaUsuariosArray)
            {
                if(usuario.usuario.getNome().equals(servidorDialogo.listaUsuarios.getSelectedValue()))
                {
                    enviarMensagem(usuario, "ADM" + Separadores.COMANDOS + mensagem + Separadores.COMANDOS + "FIMADM");
                    break;
                }
            }
        }*/
	}

	protected void btnDesconectarActionPerformed(ActionEvent evt)
	{
		/*try {
			ServerController.getInstance().client_disconnect(Integer.parseInt(listaUsuarios.getSelectedValue().toString()));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

	private Image icone()
    {
        return new javax.swing.ImageIcon(getClass().getResource("/images/icone.gif")).getImage();
    }

	

	private void init() {
		initComponents();
		try {
            UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
            SwingUtilities.updateComponentTreeUI(this);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ServerView.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ServerView.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ServerView.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedLookAndFeelException ex) {
            Logger.getLogger(ServerView.class.getName()).log(Level.SEVERE, null, ex);
        }
		
	}

	public ServerView(String arg0, GraphicsConfiguration arg1) {
		super(arg0, arg1);
		init();
	}

	public void trace(String mensagem)
	{
		System.out.println(mensagem);
        txtDebug.append(mensagem + "\n");
	}

}
