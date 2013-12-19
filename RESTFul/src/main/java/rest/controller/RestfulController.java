package rest.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import rest.bean.Body;
import rest.bean.Person;


@Controller
@ResponseStatus(value = HttpStatus.ACCEPTED)
public class RestfulController {

	
	@RequestMapping(value="/person", method=RequestMethod.GET)
	public @ResponseBody List<Person> getPersons(ModelMap model) {
		List<Person> persons = new ArrayList<Person>();
		persons.add(new Person("aaaa"));
		persons.add(new Person("bbbb"));
		persons.add(new Person("cccc"));
		return persons;
	}

	@RequestMapping(value="/person/{id}", method=RequestMethod.DELETE)
	public String deletePerson(@PathVariable("id") String id, ModelMap model) {
		model.addAttribute("id", id);
		model.addAttribute("message", "delete method");
		return "delete";
	}
	
	@RequestMapping(value="/person", method=RequestMethod.POST)
	public @ResponseBody Person createPerson(@RequestBody Map obj) {
		Person newPerson = new Person();
		return newPerson;
	}
	
	@RequestMapping(value="/person/{id}", method=RequestMethod.PUT)
	public @ResponseBody Person updatePerson(@PathVariable("id") String id, @RequestBody Map obj) {
		Person updatePerson = new Person();
		updatePerson.setId(id);
		updatePerson.setName((String)obj.get("name"));
		return updatePerson;
	}
	
	@RequestMapping(value="/messagebody/{message}", method=RequestMethod.GET)
	@ResponseBody
	public Body getMessageBody(@PathVariable String message, ModelMap model) {
		Body body = new Body();
		body.setMessage(message);
		return body;
	}
	
	@RequestMapping(value="/exception", method=RequestMethod.GET)
	public String throwException() {
		throw new ResourceNotFoundException();
	}
	
	@RequestMapping(value="/exception2", method=RequestMethod.GET)
	public String throwNewException() {
		throw new RuntimeException("test");
	}
	
	@ExceptionHandler(ResourceNotFoundException.class)
	@ResponseStatus(value = HttpStatus.BAD_GATEWAY)
	public void handleNotFoundException(ResourceNotFoundException ex, HttpServletRequest request) {
		System.out.print("exception" +  ex);
	}
	
}


@SuppressWarnings("serial")
class ResourceNotFoundException extends RuntimeException {
	
}