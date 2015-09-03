package com.springapp.mvc.controll;

import com.springapp.mvc.push.ApnsPush;
import com.springapp.mvc.push.GCMServerSide;
import javapns.communication.exceptions.CommunicationException;
import javapns.communication.exceptions.KeystoreException;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/")
public class HelloController {
	static Logger logger = Logger.getLogger(ApnsPush.class);
	@RequestMapping(method = RequestMethod.GET)
	public String printWelcome(ModelMap model) throws IOException {
		model.addAttribute("message", "Welcom to Push Test Server!");
//		GCMServerSide s = new GCMServerSide();
		logger.info("ApnsPush");
//		s.sendMessage("APA91bFN7fdTxX6cv6jtpDBvXR3W9aJBOZvdnbLoWCFevBygzE7qxxmd8pf0LEJ_gUZaf66k4DEABAy0SAR38TJ_a5Mc8__aY7aEC3YYmKlpVzzbGE7DczISt4bNf9UWwBE0YiFyljBR");
		return "hello";
	}

	@RequestMapping(value = "pushForm",method = RequestMethod.POST)
	public String pushTest(ModelMap model,
						   @RequestParam ("regId") String regId,
						   @RequestParam ("osChoice") String osChoice,
						   @RequestParam ("p12") String p12,
						   @RequestParam ("iosPass") String iosPass,
						   @RequestParam ("subject") String subject,
						   @RequestParam ("content") String content) throws KeystoreException, CommunicationException, JSONException, IOException {
		if(p12.equals("gunsan")){
			if(osChoice.equals("ios")){
				p12 = "C:/develop_gunsanAdd.p12";
			}else{
				p12 = "AIzaSyAyWi2R0EnnJWLATD_V4PhKl4XUXnBt1lE";
			}
		}else{
			if(osChoice.equals("ios")){
				p12 = "C:/test_jejuPush.p12";
			}else{
				p12 = "AIzaSyB0315_xBAxGV-NHj7NNSRM3ByGvhJXVuQ";
			}
		}

		if(osChoice.equals("android")){
			System.out.println(p12);
			System.out.println(regId);
			GCMServerSide gcm = new GCMServerSide();
			model.addAttribute("result", gcm.sendMessage(regId,p12,subject,content));
		} else{
			System.out.println(p12);
			System.out.println(iosPass);
			System.out.println(regId);
			ApnsPush ios = new ApnsPush();
			System.out.println(ios.sendMessage(p12 , iosPass , regId ,content));
		}
		return "pushResult";
	}
}