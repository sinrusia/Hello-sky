/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.examples;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.4 $, $Date: 2005/07/05 22:04:06 $
 */
public class Directory implements Serializable {

	protected static Log log = LogFactory.getLog(Directory.class);

	private List people = new ArrayList();

	public void addPerson(Person person) {
		addPerson(person, null);
	}

	public void addPerson(Person person, Authentication authentication) {
		log.debug("Adding " + person + " to Directory ");
		if (authentication != null) {
			log.debug("got authentication");
		}
		people.add(person);
	}

	public List getPeople(String name) {
		return getPeople(name, null);
	}
	
	public List getPeople(String name, Authentication authentication) {

		log.debug("getPeople(" + name + ")");
		if (authentication != null) {
			log.debug("got authentication");
		}

		List result = new ArrayList();

		for (Iterator iter = people.iterator(); iter.hasNext();) {
			Person person = (Person) iter.next();
			if (person.getFirstName().equals(name)
				|| person.getLastName().equals(name)) {
				String fname =  person.getFullName();
				log.debug("Adding " + fname + " to result");
				result.add(person);
			}
		}

		return result;

	}

	public List getPeople(int zipCode) {
		return getPeople(zipCode, null);
	}
	
	public List getPeople(int zipCode, Authentication authentication) {

		log.debug("getPeople(" + zipCode + ")");
		if (authentication != null) {
			log.debug("got authentication");
		}
		List result = new ArrayList();

		for (Iterator iter = people.iterator(); iter.hasNext();) {
			Person person = (Person) iter.next();
			if (person.getZipCode() == zipCode) {
				log.debug("Adding " + person + " to result");
				result.add(person);
			}
		}

		return result;

	}

	public String toString()
	{
		return String.valueOf(people);
	}
}
