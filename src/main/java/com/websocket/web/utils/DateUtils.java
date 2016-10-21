package com.websocket.web.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

		private static  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		
		public static String date2Str(Date date){
			return sdf.format(date);
		}
}
