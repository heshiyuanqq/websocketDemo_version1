package com.websocket.web.controller;

import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import com.websocket.web.service.TestSystemService;

public class TypeListHandlerController implements WebSocketHandler {
	
    
	public static final List<WebSocketSession> sessions=new ArrayList<WebSocketSession>();
	private TestSystemService testSystemService;
	
	
	public void setTestSystemService(TestSystemService testSystemService) {
		this.testSystemService = testSystemService;
	}

	private static final Logger logger= Logger.getLogger(TypeListHandlerController.class);
	
/**
 * 客户端连入时触发
 */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    	sessions.add(session);
    }

/**
 * 接收客户端消息
 */
	@Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		
    }
	

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
    	  	if(session.isOpen()){
	            session.close();
	        }
	       
    	  	sessions.remove(session);
    }
    

   
	/**
     * 客户端连接断开触发
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
    	sessions.remove(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        	return false;
    }

}