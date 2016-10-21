package com.websocket.web.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import com.alibaba.fastjson.JSON;
import com.websocket.web.bean.TestSystem;
import com.websocket.web.bean.TestSystemRecMsg;
import com.websocket.web.service.TestSystemService;
import com.websocket.web.utils.Constant;
import com.websocket.web.utils.NumberUtils;
import com.websocket.web.utils.SpringPropertiesUtil;

/**
 * 供C#端连入的
 * @author Administrator
 *
 */
public class RemoteHandlerController implements WebSocketHandler {
	/**
	 * 将接收消息和发送消息封装成类
	 */
	private TestSystemService testSystemService;
	public void setTestSystemService(TestSystemService testSystemService) {
		this.testSystemService = testSystemService;
	}


	private WebsocketIdelTimeThread witThread=new WebsocketIdelTimeThread();
	private static final Logger logger= Logger.getLogger(RemoteHandlerController.class);
	public static final ConcurrentHashMap<String, WebSocketSession> testSystemMap=new ConcurrentHashMap<String, WebSocketSession>();
	
/**
 * 客户端连入时触发
 */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {//要求客户端连接时这样："ws://192.168.0.100/websocket/webSocketServer?mac=13t72423432&xxx=yyy..."
    		logger.debug("连接成功！");
    		Map<String, Object> attrMap = session.getAttributes();
	    	String mac = (String) attrMap.get(Constant.MAC);
	    	String typeId = (String) attrMap.get(Constant.TYPE_ID);
	    	String systemId=mac+"_"+typeId;
	    	attrMap.put("systemId", systemId);
	    	TestSystem testSystem = new TestSystem();    	
	    	testSystem.setLastIp(session.getRemoteAddress().getAddress().getHostAddress());
	    	testSystem.setLastLat(NumberUtils.string2Double((String) attrMap.get("lastLat")));
	    	testSystem.setLastLng(NumberUtils.string2Double((String) attrMap.get("lastLng")));
	    	testSystem.setMac((String) attrMap.get("mac"));
	    	testSystem.setState(NumberUtils.string2Integer((String) attrMap.get("state")));
	    	testSystem.setTypeId(NumberUtils.string2Integer((String) attrMap.get("typeId")));
	    	testSystem.setSystemId(systemId);
	    	
	    	//客户端请求连接必须携带该参数(该参数唯一表示你是哪一个测试系统),
	    	if(testSystemMap.containsKey(systemId)){//一个测试系统同时连接多次以最新的为主
		    		WebSocketSession existSession = testSystemMap.get(systemId);
		    		existSession.close();
	    	}
			//保存数据库(判断是否存在：新增或者更新)
			testSystemMap.put(systemId, session);
			this.testSystemService.saveOrUpdate(testSystem);
			
			  //将最新测试系统状态刷新到本地浏览器控制台
	        	flushStateToLocalClient();
	        	flushTypeToLocalClient();
	        	
	        	//判断是否应该开启线程
	        	if(!witThread.isAlive()){
	        		witThread=new WebsocketIdelTimeThread();
	        		witThread.start();
	        	}
    }

	private void flushTypeToLocalClient() throws IOException {
		  //flushTypeoTypeDetail
	        List<WebSocketSession> typeDetailSessions= TypeDetailHandlerController.sessions;
	        Map<Integer, List<TestSystem>> typeId_systemList_map=null;
	        if(typeDetailSessions!=null&&typeDetailSessions.size()>0){
		        	//向本地浏览器展示最新的测试系统状态
	        	    typeId_systemList_map= testSystemService.getAllAndOrderByTypeId();
			    	for (WebSocketSession localSession : typeDetailSessions) {
							//检测当前webSocketSession绑定的typeId
				        	List<TestSystem> list = typeId_systemList_map.get(Integer.valueOf((String) localSession.getAttributes().get("typeId")));
				        	localSession.sendMessage(new TextMessage(JSON.toJSONString(list)));
			    	}	
	        }
	        
	        //flushTypeToTypeList
	        List<WebSocketSession> typeListSessions=TypeListHandlerController.sessions;
	        if(typeListSessions!=null&&typeListSessions.size()>0){
	        		long[] typeCountList = testSystemService.getTypeCountList();
	        		for (WebSocketSession typeCountSession : typeListSessions) {
	        				typeCountSession.sendMessage(new TextMessage(JSON.toJSONString(typeCountList)));
	     			}
	        }
	}

/**
 * 接收客户端消息(更新最近活跃时间)
 */
	@Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
			String msgJsonStr=message.getPayload().toString();
			TestSystemRecMsg testSystemRecMsg = JSON.parseObject(msgJsonStr, TestSystemRecMsg.class);
			Map<String, Object> msgBody = testSystemRecMsg.getMsgBody();
			String systemId= (String) session.getAttributes().get("systemId");
			Integer state = (Integer) msgBody.get("state");
			
			//更新数据库中测试系统的状态
	        testSystemService.updateStateBySystemId(systemId,state);
	        
	        //更新最近活跃时间
	        session.getAttributes().put("latestActiveTime", System.currentTimeMillis());
	        
	        //将最新测试系统状态刷新到本地浏览器控制台
	        flushStateToLocalClient();
	        flushTypeToLocalClient();
	}
	

    private void flushStateToLocalClient() throws IOException {
	        //flushStateToStateDetail
	        List<WebSocketSession> localSessions= StateDetailHandlerController.sessions;
	        Map<Integer, List<TestSystem>> state_systemList_map=null;
	        if(localSessions!=null&&localSessions.size()>0){
		        	//向本地浏览器展示最新的测试系统状态
	        	    state_systemList_map= testSystemService.getAllAndOrderByState();
			    	for (WebSocketSession localSession : localSessions) {
							//检测当前webSocketSession绑定的state
				        	List<TestSystem> list = state_systemList_map.get(Integer.valueOf((String) localSession.getAttributes().get("state")));
				        	localSession.sendMessage(new TextMessage(JSON.toJSONString(list)));
			    	}	
	        }
	        
	        //flushStateToStateList
	        List<WebSocketSession> stateCounterSessions=StateListHandlerController.sessions;
	        if(stateCounterSessions!=null&&stateCounterSessions.size()>0){
	        		long[] stateCountList = testSystemService.getStateCountList();
	        		for (WebSocketSession stateCounterSession : stateCounterSessions) {
	        			    stateCounterSession.sendMessage(new TextMessage(JSON.toJSONString(stateCountList)));
	     			}
	        }
	}

	@Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	        if(session.isOpen()){
	            session.close();
	        }
	        logger.debug("websocket connection closed......");
	        String systemId = (String) session.getAttributes().get("systemId");
	        //将数据库状态(state)更改为-1（离线）
	        testSystemService.updateStateBySystemId(systemId,Constant.TestSystemState.STATE_OFFLINE.getValue());
	        //将最新测试系统状态刷新到本地浏览器控制台
	        flushStateToLocalClient();
	        flushTypeToLocalClient();
	        removeSession(session);
    }
    

    
    private void removeSession(WebSocketSession session) {
			Set<String> keySet = testSystemMap.keySet();
			for (String key : keySet) {
					WebSocketSession currSession = testSystemMap.get(key);
					if(currSession==session){
						testSystemMap.remove(key);
						break;
					}
			}
	}

	/**
     * 客户端连接断开触发
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
	        logger.debug("websocket connection closed with code "+closeStatus.getCode()+"......");
	        String systemId = (String) session.getAttributes().get("systemId");
	        //将数据库状态(state)更改为-1（离线）
	        testSystemService.updateStateBySystemId(systemId,Constant.TestSystemState.STATE_OFFLINE.getValue());
	        //将最新测试系统状态刷新到本地浏览器控制台
	        flushStateToLocalClient();
	        flushTypeToLocalClient();
	        removeSession(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        	return false;
    }
    
    //开启一个监听客户端空闲超时的线程
    class WebsocketIdelTimeThread extends Thread{
    			private boolean stop=false;

				@Override
		    	public void run() {
		    				try{
			    					//取得sessions集合逐个判断是否超时。超时则close
			        				long websocketIdelTimes=SpringPropertiesUtil.getInt("websocketIdelTime");
			        				while(!stop){
				        					Set<String> keys = testSystemMap.keySet();  
				        					boolean hasSessionClosed=false;
				        					for (String key : keys) {
					        						WebSocketSession session = testSystemMap.get(key);
					        						long time=System.currentTimeMillis()-(long)session.getAttributes().get("latestActiveTime");
					        						if(time>websocketIdelTimes){
					        									hasSessionClosed=true;
					        									//关闭sesion
					        							  		session.close();
					        									//更新数据库状态, 将数据库状态(state)更改为6（离线）
				        								        String systemId = (String) session.getAttributes().get("systemId");
				        								        testSystemService.updateStateBySystemId(systemId,Constant.TestSystemState.STATE_OFFLINE.getValue());
				        								        //移除session
				        								        removeSession(session);
					        						}
				    						}
				        					if(hasSessionClosed){
					        						//将最新测试系统状态刷新到本地浏览器控制台
		    								        flushStateToLocalClient();
		    								        flushTypeToLocalClient();
				        					}
				        					if(testSystemMap.size()==0){
				        							stop=true;
				        					}else{
				        						Thread.sleep(3000);
				        					}
			        				}	
		    				}catch(Exception e){
		    						e.printStackTrace();
		    				}
		    	}
    }
}