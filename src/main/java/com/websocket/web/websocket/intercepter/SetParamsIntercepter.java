package com.websocket.web.websocket.intercepter;

import java.net.URI;
import java.util.Map;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import com.websocket.web.utils.Constant;

public class SetParamsIntercepter implements HandshakeInterceptor{

	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
	        URI uri = request.getURI();
	        //ws://192.168.0.100/websocket/webSocketServer?mac=13t72423432
			String query = uri.getQuery();
			//mac=xxx&name=zhangsan
			boolean macFlag=false;
			boolean typeIdFlag=false;
			String[] kvs = query.split("&+");
			if(kvs!=null&&kvs.length>0){
					for (String kv : kvs) {
						String[] str = kv.split("=");
						if(str!=null&&str.length==2){
							String name=str[0];
							String value=str[1];
							if(name.equals(Constant.MAC)){
								macFlag=true;
							}
							if(name.equals(Constant.TYPE_ID)){
								typeIdFlag=true;
							}
							attributes.put(name, value);
						}
					}
			}
			if(macFlag&&typeIdFlag){
				attributes.put("latestActiveTime", System.currentTimeMillis());//最近活跃时间
				return  true;
			}else{
				return false;
			}
	}

	@Override
	public void afterHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// TODO Auto-generated method stub
		
	}

}
