package com.springapp.mvc.controll;

import com.springapp.mvc.push.GCMServerSide;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;

@Controller
@RequestMapping("/")
public class HelloController {
	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap model) throws IOException {
		model.addAttribute("message", "Hello world!");
		GCMServerSide s = new GCMServerSide();
		s.sendMessage();
		return "hello";
	}
}