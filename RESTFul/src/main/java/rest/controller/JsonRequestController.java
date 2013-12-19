package rest.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;

import rest.bean.Message;


@Controller
@RequestMapping("/comm")
@ResponseStatus(value=HttpStatus.ACCEPTED)
public class JsonRequestController {
	
	@RequestMapping(method=RequestMethod.GET)
	@ResponseStatus(value=HttpStatus.FOUND)
	public void sendFruitMessage(@RequestBody Message name) {
		System.out.println("name : " + name.getName());
		return;
	}

}
