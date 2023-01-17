package com.myspring.springProWooks.service;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.mapper.MemberDAO;

@Service("MailService")

public class MailService {
	@Autowired
    private JavaMailSender mailSender;
	
	@Async
	public void sendMail(String to, String title, String content) {
		try {
	         
			
	         MimeMessage message = mailSender.createMimeMessage();
	         MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	         helper.setFrom("namoo@naver.com", "나무늘보 서점");
	         helper.setTo(to);
	         helper.setSubject(title);
	         helper.setText(content,true);
	         mailSender.send(message);
	         
	     }catch(Exception e) {
	         e.printStackTrace();
	     }
	}
	
	 
}
