package com.ksy.common;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtils {
    
    private JavaMailSender mailSender;
    private MimeMessage message;
    private MimeMessageHelper messageHelper;
    
    // UserRestController에서 Autowried된 JavaMailSenderImpl을 매개변수로 받는다 
    public MailUtils(JavaMailSender mailSender) throws MessagingException {
        this.mailSender = mailSender;
        
        // 메일을 발송하기 위해 MimeMessage 객체 생성 
        // MimeMessage에 메일로 보낼 내용은 html Tag로 작성한 다음 메일을 발송하는 방식 
        message = this.mailSender.createMimeMessage();
        
        // MimeMessage에 대한 설정 
        // 해당 필드는 spring에서 제공해주는 것으로 첨부파일을 할 수 있도록 true로 설정했다 
        // 메일에 한글을 입력하기 위해서 encoding을 UTF-8로 하도록 설정했다
        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
    }
    
    public void setSubject(String subject) throws MessagingException {
        messageHelper.setSubject(subject);
    }
    
    public void setText(String htmlContent) throws MessagingException {
        messageHelper.setText(htmlContent, true);
    }
    
    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
        messageHelper.setFrom(email, name);
    }
    
    public void setTo(String email) throws MessagingException {
        messageHelper.setTo(email);
    }
    
    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
        messageHelper.addInline(contentId, dataSource);
    }
    
    public void send() {
    	mailSender.send(message);
    }
}