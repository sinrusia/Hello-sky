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
 * A very simple Service interface to demonstrate
 * the decoupling that Spring Provides 
 *
 */
public interface IGreetingService {
	 public String sayGreeting();
	public IhaveName sayHiTo(IhaveName named);
}
