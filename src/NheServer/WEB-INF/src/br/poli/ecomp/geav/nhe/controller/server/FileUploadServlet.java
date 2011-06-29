package br.poli.ecomp.geav.nhe.controller.server;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import br.poli.ecomp.geav.nhe.model.util.UnZip;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;

public class FileUploadServlet extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		super.doGet(request, response);
		doPost(request,response);
	}
	@SuppressWarnings("unchecked")
	@Override
	public void doPost( HttpServletRequest request, HttpServletResponse response )
	{
		/**
		 * Create a factory for new disk-based file items
		 */
		FileItemFactory factory = new DiskFileItemFactory();
		/**
		 * Create a new file upload handler
		 */
		ServletFileUpload upload = new ServletFileUpload(factory);
		try
		{
			/**
			 * Parsing input request
			 */
			List items = upload.parseRequest(request);
			/**
			 * Process the uploaded items
			 */
			Iterator iter = items.iterator();
			while (iter.hasNext())
			{
				FileItem item = (FileItem) iter.next();
				/**
				 * handling a normal form-field
				 */
				if (item.isFormField())
				{
					System.out.println("A form field");
				}
				else
				{
					/**
					 * handling file uploads
					 */
					System.out.println("Not a form field");
					String uploadFileName = item.getName();
					byte[] data = item.get();
					/**
					 * Gets directory to which the file is to be uploaded
					 */
					String uploadFolder = getServletConfig().getInitParameter("uploadFolder");
					String fileFolderName = getServletContext().getRealPath(uploadFolder + "\\"+uploadFileName);
					try
					{
						FileOutputStream fileOutSt = new FileOutputStream(fileFolderName);
						try
						{
							fileOutSt.write(data);
							fileOutSt.close();
							if(uploadFileName.endsWith(".zip"))
								UnZip.unzipFile(fileFolderName);
						}
						catch(IOException exception)
						{
							exception.printStackTrace();
						}
					}
					catch(FileNotFoundException exception)
					{
						exception.printStackTrace();
					}
				}
			}
		}
		catch(FileUploadException exception)
		{
			exception.printStackTrace();
		}
	}
}

