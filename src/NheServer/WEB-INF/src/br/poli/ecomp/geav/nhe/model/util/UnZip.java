package br.poli.ecomp.geav.nhe.model.util;

import java.io.*;
import java.util.*;
import java.util.zip.*;


public class UnZip
{
	public static void unzipFile(String folder, String file) throws IOException
	{
		Enumeration<? extends ZipEntry> entries;
	    ZipFile zipFile;
	    
	    zipFile = new ZipFile(folder + "\\" + file);

	    entries = zipFile.entries();

	    while(entries.hasMoreElements()) {
	    	ZipEntry entry = (ZipEntry)entries.nextElement();

	    	if(entry.isDirectory()) {
	    		// Assume directories are stored parents first then children.
	    		System.err.println("Extracting directory: " + entry.getName());
	    		// This is not robust, just for demonstration purposes.
	    		(new File(folder + "\\" + entry.getName())).mkdir();
	    		continue;
	    	}

	    	System.err.println("Extracting file: " + entry.getName());
	    	copyInputStream(zipFile.getInputStream(entry),
	    			new BufferedOutputStream(new FileOutputStream(folder + "\\" + entry.getName())));
	    }
	    zipFile.close();
	}
	 
	
	private static final void copyInputStream(InputStream in, OutputStream out)
	throws IOException
	{
		byte[] buffer = new byte[1024];
		int len;

		while((len = in.read(buffer)) >= 0)
			out.write(buffer, 0, len);

		in.close();
		out.close();
	}
	
	
	public static File unzip(File inFile, File outFolder)
	{
		final int BUFFER = 2048;
		try 
		{
			BufferedOutputStream out = null;
			ZipInputStream in = new ZipInputStream( new BufferedInputStream( new FileInputStream(inFile))); 
			ZipEntry entry; 
			while((entry = in.getNextEntry()) != null)
			{ 
				System.out.println("Extracting: " + entry); 
				int count; 
				byte data[] = new byte[BUFFER];
				
				
				File entrySupposedPath = new File(outFolder.getAbsolutePath()+File.separator+entry.getName());
				
				if(entry.isDirectory()) {
		    		// Assume directories are stored parents first then children.
		    		System.err.println("Extracting directory: " + entry.getName());
		    		// This is not robust, just for demonstration purposes.
		    		entrySupposedPath.mkdir();
		    		continue;
		    	}
				else
				{
					//We will try to reconstruct the entry directories 
					
					
					//Does the parent folder exist?
					if (!entrySupposedPath.getParentFile().exists())
					{ 
						entrySupposedPath.getParentFile().mkdirs(); 
					}
					
					// write the files to the disk 
					out = new BufferedOutputStream( new FileOutputStream(outFolder.getPath() + "/" + entry.getName()),BUFFER);
					
					while ((count = in.read(data,0,BUFFER)) != -1)
					{
						out.write(data,0,count); 
					}
					out.flush(); 
					out.close();
				}
			}
			in.close(); 
			return outFolder; 
		}
		catch(Exception e)
		{
			e.printStackTrace(); 
			return inFile;
		}
	}
}
