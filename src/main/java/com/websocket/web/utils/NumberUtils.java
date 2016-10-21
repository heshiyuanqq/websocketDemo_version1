package com.websocket.web.utils;


public class NumberUtils {

	
	public static Integer string2Integer(String numStr){
		Integer integer = null;
		try{
			integer=Integer.valueOf(numStr);
		}catch(Exception e){
			return null;
		}
		return integer;
	}
	public static Double string2Double(String numStr){
		Double num = null;
		try{
			num=Double.valueOf(numStr);
		}catch(Exception e){
			return null;
		}
		return num;
	}
}
