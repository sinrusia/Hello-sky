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

	/**
	 * 사용자 정보 조회
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/person", method=RequestMethod.GET)
	public @ResponseBody List<Person> getPersons(ModelMap model) {
		List<Person> persons = new ArrayList<Person>();
		persons.add(new Person("Sky"));
		persons.add(new Person("Ronardo"));
		persons.add(new Person("ki"));
		return persons;
	}

	/**
	 * 삭제
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/person/{id}", method=RequestMethod.DELETE)
	public String deletePerson(@PathVariable("id") String id, ModelMap model) {
		model.addAttribute("id", id);
		model.addAttribute("message", "delete method");
		return "delete";
	}
	
	/**
	 * 등록
	 * @param obj
	 * @return
	 */
	@RequestMapping(value="/person", method=RequestMethod.POST)
	public @ResponseBody Person createPerson(@RequestBody Map obj) {
		Person newPerson = new Person();
		return newPerson;
	}
	
	/**
	 * 업데이트
	 * @param id
	 * @param obj
	 * @return
	 */
	@RequestMapping(value="/person/{id}", method=RequestMethod.PUT)
	public @ResponseBody Person updatePerson(@PathVariable("id") String id, @RequestBody Map obj) {
		Person updatePerson = new Person();
		updatePerson.setId(id);
		updatePerson.setName((String)obj.get("name"));
		return updatePerson;
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