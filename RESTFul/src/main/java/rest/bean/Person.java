package rest.bean;

import java.util.UUID;

public class Person {

	private String name;
	private String id;
	
	public Person() {
		this.id = UUID.randomUUID().toString();
	}
	
	public Person(String name) {
		this.name = name;
		this.id = UUID.randomUUID().toString();
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
}
