package com.websocket.web.bean;

/**
 * 测试系统实例类
 * @author heshiyuan
 *
 */
public class TestSystem {
	
		
	private Integer id;//主键
	private String mac;//该测试系统所在机器mac地址
	private String lastIp;//该测试系统所在机器上次登录ip
	private Double lastLng;//......所在位置经度
	private Double lastLat;//...维度
	private Integer typeId;//该测试系统类型id(根据该字段显示系统名称)
	private String typeName;//系统类型名称
	private String systemId;//唯一区分该测试系统的字段(其实就是mac和type_id的组合)
	private Integer state;//系统状态(如系统空、闲准备就绪等)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public String getLastIp() {
		return lastIp;
	}
	public void setLastIp(String lastIp) {
		this.lastIp = lastIp;
	}
	public Double getLastLng() {
		return lastLng;
	}
	public void setLastLng(Double lastLng) {
		this.lastLng = lastLng;
	}
	public Double getLastLat() {
		return lastLat;
	}
	public void setLastLat(Double lastLat) {
		this.lastLat = lastLat;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getSystemId() {
		return systemId;
	}
	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	
	
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	@Override
	public String toString() {
		return "TestSystem [id=" + id + ", mac=" + mac + ", lastIp=" + lastIp
				+ ", lastLng=" + lastLng + ", lastLat=" + lastLat + ", typeId="
				+ typeId + ", systemId=" + systemId + ", state=" + state + "]";
	}
	
	
	
	public static void main(String[] args) {
		/*1元钱一瓶汽水，喝完后两个空瓶换一瓶汽水，问：你有20元钱，最多可以喝到几瓶汽水？*/
			
			//喝20瓶饮料，得20空瓶，换10瓶饮料，剩0空瓶
			//喝10瓶饮料，得10空瓶，换5瓶饮料，剩0空瓶
			//喝5瓶饮料，得5空瓶，换2瓶饮料，剩1空瓶
			//喝2瓶饮料，得2+1=3空瓶，换1瓶饮料，剩1空瓶
			//喝1瓶饮料，得1+1=2空瓶，换1瓶饮料，剩0空瓶
			//喝1瓶饮料，的1空瓶，
			//20+10+5+2+1+1=39
		
		
		
		
	}
	
	
	//计算最终能喝到多少瓶饮料的方法
	

}
