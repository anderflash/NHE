package br.poli.ecomp.geav.nhe.model.util;

import java.util.Iterator;
import java.util.List;

public class StringUtil
{
	public static String join(List<? extends CharSequence> s, String delimiter)
    {
    	int capacity = 0;
    	int delimLength = delimiter.length();
    	Iterator<? extends CharSequence> iter = s.iterator();
    	if (iter.hasNext())
    	{
    	    capacity += iter.next().length() + delimLength;
    	}

    	StringBuilder buffer = new StringBuilder(capacity);
    	iter = s.iterator();
    	if (iter.hasNext())
    	{
    	    buffer.append(iter.next());
    	    while (iter.hasNext())
    	    {
	    		buffer.append(delimiter);
	    		buffer.append(iter.next());
    	    }
    	}
    	return buffer.toString();
    }
}
