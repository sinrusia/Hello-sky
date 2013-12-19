package rest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import rest.bean.Body;
import rest.bean.Fruit;


@Controller
@RequestMapping("/fruit")
public class FruitController {

	@RequestMapping(value="{fruitName}", method=RequestMethod.GET)
	public @ResponseBody Fruit getFruit(@PathVariable String fruitName, ModelMap model) {
		Fruit fruit = new Fruit(fruitName, 1);
		Body body = new Body();
		body.setMessage("message");
		fruit.setBody(body);
		return fruit;
	}
	
}
