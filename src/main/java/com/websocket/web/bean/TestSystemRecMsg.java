package com.websocket.web.bean;

import java.util.HashMap;
import java.util.Map;



/**
 * websocket服务端接收到客户端(测试系统)发来的关于测试系统自身信息的消息封装类
 * @author Administrator
 *
 */
public class TestSystemRecMsg {
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
		return "TestSystemRecMsg [msgType=" + msgType + ", msgBody=" + msgBody
				+ "]";
	}
	
	
	
	
	/*
	
	private String fromIp;//消息来自的Ip
	private String systemmId;//测试系统id
	private Integer typeId;//测试系统类型码
	private Integer state;//测试系统的最新状态码
*/
}
