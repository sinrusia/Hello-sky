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
 * The main service class to Test the decoupling
 * that the Spring framework provides.
 * used with the SpringBeanInvoker.
 */
public class GreetingServiceImpl implements IGreetingService {
		private String greeting;
		private IhaveName namedItem;

		public GreetingServiceImpl() {
		}

		public GreetingServiceImpl(String greeting) {
			this.greeting = greeting;
		}

		public String sayGreeting() {
			System.out.println(greeting);
			return this.greeting;
		}
		public IhaveName sayName() {
			System.out.println("IhaveName " + this.namedItem.getName());
			return this.namedItem;
		}
		public IhaveName sayHiTo(IhaveName named) {
			System.out.println("sayHiTo " + named.getName());
			//conceivabley do something to named.
			return named;
		}
		public void setGreeting(String greeting) {
			this.greeting = greeting;
		}
		public void setNamedItem(IhaveName namedItem){
			this.namedItem = namedItem;
		}
}