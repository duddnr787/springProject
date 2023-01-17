package com.myspring.springProWooks;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.service.GoodsService;
import com.myspring.springProWooks.service.MailService;

@Controller("MailCotroller")
@RequestMapping("/mail")
public class MailController extends BaseController  {
	@Autowired
	MailService mailService;
	
	@RequestMapping(value="/mailCheck.do", method=RequestMethod.POST)
    public @ResponseBody Map<String, String> mailCheck(@RequestBody HashMap<String, String> email,
            HttpServletRequest request, HttpServletResponse response) throws Exception{
        
		
		Map<String, String> result = new HashMap<String, String>();
        /* 뷰(View)로부터 넘어온 데이터 확인 */

        Random random = new Random();
		String checkNum = Integer.toString(random.nextInt(888888) + 111111);
		
	        String toMail = email.get("email1");
	        String toMail2 = email.get("email2");
	        
	        StringBuilder sb = new StringBuilder();
	        sb.append(toMail).append("@").append(toMail2);
	        String toMailSub =  sb.toString();
	        String title = "나무늘보 인증 이메일 입니다.";

			BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/mail/emailForm.html"), "utf-8"));
			StringBuilder str = new StringBuilder();
			reader.lines().forEach(lineText -> {
				str.append(lineText);
			});
			String content =  str.toString();
			content = content.replace("${checkNum}", checkNum);
	        mailService.sendMail(toMailSub, title, content);
	        result.put("key", checkNum);
	        return result;
    }

	@RequestMapping(value="/findPwd.do", method=RequestMethod.POST)
    public @ResponseBody Map<String, String> findPwd(@RequestBody HashMap<String, String> email,
            HttpServletRequest request, HttpServletResponse response) throws Exception{
        
		
		Map<String, String> result = new HashMap<String, String>();
        /* 뷰(View)로부터 넘어온 데이터 확인 */

        Random random = new Random();
		String checkNum = Integer.toString(random.nextInt(888888) + 111111);
		
	        String toMail = email.get("email1");
	        String toMail2 = email.get("email2");
	        
	        StringBuilder sb = new StringBuilder();
	        sb.append(toMail).append("@").append(toMail2);
	        String toMailSub =  sb.toString();
	        String title = "나무늘보 인증 이메일 입니다.";

			BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/mail/emailForm.html"), "utf-8"));
			StringBuilder str = new StringBuilder();
			reader.lines().forEach(lineText -> {
				str.append(lineText);
			});
			String content =  str.toString();
			content = content.replace("${checkNum}", checkNum);
	        mailService.sendMail(toMailSub, title, content);
	        result.put("key", checkNum);
	        return result;
    }
}
