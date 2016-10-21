package com.websocket.web.utils;

public  class Constant {
	
	public static final String MAC="mac";
	public static final String TYPE_ID="typeId";
	public static final int stateSum=7;
	public static final int typeSum=6;
	
	
	
	/**
	 * 测试控制命令枚举类
	 * @author Administrator
	 *
	 */
	public enum TestCommand { 
		 START(0, "启动测试"),
		 STOP(1, "结束测试"), 
		 PAUSE(2, "暂停测试");
		  
		  private int value; 
		  private String text; 
		  private TestCommand(int value, String text) { 
			    this.value = value; 
			    this.text = text; 
		  } 
		  
		  public int getValue() { 
			  	return value; 
		  } 
		  public String getText() { 
			  	return text; 
		  } 
	}
	
	
	/**
	 * 测试系统测试状态枚举类
	 * @author Administrator
	 *
	 */
	 public enum TestSystemState { 
		 
		 STATE_TEST_EXCEPTION(0, "测试异常"), 
		 STATE_TEST_COMPLETE(1, "测试完成"),
		 STATE_SYSTEM_IDLE(2, "系统空闲"),
		 STATE_TESTING(3, "测试中"),
		 STATE_TEST_PAUSE(4, "测试暂停"), 
		 STATE_READYTODO(5, "准备执行"),
		 STATE_OFFLINE(6, "测试系统未接入[离线]");
		  
		  private int value; 
		 private String text; 
		  private TestSystemState(int value, String text) { 
			    this.value = value; 
			    this.text = text; 
		  } 
		  
		  public int getValue() { 
			  	return value; 
		  } 
		  public String getText() { 
			  	return text; 
		  } 
	}
	
	 
	 /**
	  * 测试系统类型枚举类
	  * @author Administrator
	  *
	  */
	 public enum TestSystemType { 
		 
		 LET_JZCS_cms500(0, "LET基站测试cms500"), 
		 LEFT_JZCSQHX(1, "LET基站测试切换箱"),
		 LET_JZKKXCS_XY4_0(2, "LET基站可靠性测试-协议4.0"),
		 LET_JZSYSCS_XY4_0(3, "LET基站实验室测试-协议4.0"),
		 FEMATO_JZSPCSXT(4, "Femato基站射频测试系统"), 
		 WYQJSCSCSXT(5, "无源器件S参数测试系统");
		 private int value; 
		 private String text; 
		 private TestSystemType(int value, String text) { 
			 this.value = value; 
			 this.text = text; 
		 } 
		 
		 public int getValue() { 
			 return value; 
		 } 
		 public String getText() { 
			 return text; 
		 } 
	 }
	 
	 
	 
		
	
	/**
	 * websocket客户端退出状态码
	 * @author Administrator
	 *
	 */
	public  enum WebsocketClinetCloseCode { 
		  CLOSE_NORMALLY(1000, "正常退出"), 
		  CLOSE_EXCEPTION(1001, "以外断开"); 
		  
		  private int value; 
		  private String text; 
		  
		  private WebsocketClinetCloseCode(int value, String text) { 
		    this.value = value; 
		    this.text = text; 
		  } 
		  
		  public int getValue() { 
		    return value; 
		  } 
		  public String getText() { 
		    return text; 
		  } 
	}
	 
}
