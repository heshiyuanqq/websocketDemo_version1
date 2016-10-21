package com.websocket.web.bean;

import java.util.HashMap;
import java.util.Map;



/**
 * websocket服务端返回客户端(测试系统)指示测试系统干什么事情的消息封装类
 * @author Administrator
 *
 */
public class TestSystemRespMsg {
	
	private Integer msgType;//消息类型(即此消息是指示服务端干什么是的)
	private Map<String, Object> msgBody=new HashMap<String, Object>();//消息体
	public Integer getMsgType() {
		return msgType;
	}
	public void setMsgType(Integer msgType) {
		this.msgType = msgType;
	}
	public Map<String, Object> getMsgBody() {
		return msgBody;
	}
	public void setMsgBody(Map<String, Object> msgBody) {
		this.msgBody = msgBody;
	}
	@Override
	public String toString() {
		return "TestSystemRespMsg [msgType=" + msgType + ", msgBody=" + msgBody
				+ "]";
	}
	
	
	
	//private Integer commandCode;//控制码
	//private String systemId;//控制码
	
	
	
}
