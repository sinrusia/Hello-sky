/*
 * Created on Jun 28, 2005
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */
package org.openamf.examples.spring;

/**
 * @author Troy Gardner <troy@troyworks.com>
 *
 * Trivially simple interface to demonstrate use 
 * of AS->Java and Java->AS arguments/parameters 
 * that have Interfaces with Spring
 * e.g. 
 *     IGreetingService.sayHiTo(IhaveName namedItem);
 * and 
 *     IhaveName named = new (IhaveName) // IhaveName implementer e.g. Person that's gotten from Spring.
 *     return named;
 */
public interface IhaveName {
	 public String getName();
}
