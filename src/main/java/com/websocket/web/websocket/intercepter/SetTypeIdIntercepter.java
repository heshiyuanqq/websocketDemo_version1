package com.websocket.web.websocket.intercepter;

import java.net.URI;
import java.util.Map;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

public class SetTypeIdIntercepter implements HandshakeInterceptor{

	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
	        URI uri = request.getURI();
	        //ws://192.168.0.100/websocket/typeDetailHandler?typeId=0
			String query = uri.getQuery();
			//typeId=0
			
			String[] split = query.split("=");
			String name=split[0];
			String value=split[1];
			attributes.put(name, value);
			return true;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// TODO Auto-generated method stub
		
	}

}
