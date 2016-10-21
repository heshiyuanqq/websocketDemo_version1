package com.websocket.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import com.alibaba.fastjson.JSON;
import com.websocket.web.bean.TestSystem;
import com.websocket.web.bean.TestSystemRespMsg;
import com.websocket.web.service.TestSystemService;
import com.websocket.web.utils.Result;
import com.websocket.web.utils.SpringPropertiesUtil;
@Controller
public class IndexController {

			
/**
 * 登录测试系统控制台后，将RemoteController服务端接入的session关联的测试系统(设备)的信息显示出来
 */
	static Logger logger = Logger.getLogger(IndexController.class);

	@Autowired
	private TestSystemService testSystemService;

    @Bean
    public RemoteHandlerController getRemoteController() {
        return new RemoteHandlerController();
    }


    @RequestMapping("/index")
    public String toIndex(HttpServletRequest request){
        return "index";
    }    
    
    
    @RequestMapping("/toLogin")
    public String toLogin(HttpServletRequest request){
    	return "login";
    }    
    
    @RequestMapping("/state_typeList")
    public String state_typeList(HttpServletRequest request,Model model){
    	long[] stateCountList=testSystemService.getStateCountList();
    	long[] typeCountList=testSystemService.getTypeCountList();
    	model.addAttribute("stateCountListStr", JSON.toJSONString(stateCountList));
    	model.addAttribute("typeCountListStr", JSON.toJSONString(typeCountList));
    	return "state_typeList";
    }
    
    /**
     * 向C#测试系统客户端发送控制命令
     * @param commandCode
     * @param systemIds
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping("/postCommandCode")
    public String postCommandCode(@RequestParam("commandCode") Integer commandCode,@RequestParam("systemIds") String systemIds) throws IOException{
    			Result result = new Result();
    			try {
	    		    	String[] systemIdArr = systemIds.split(",");
	    		    	if(systemIdArr!=null&&systemIdArr.length>0){
	    			    		//取得RemoteHandlerController的sesionss，向其发送相应命令
	    			        	ConcurrentHashMap<String, WebSocketSession> sessionMap=RemoteHandlerController.testSystemMap;
	    			        	TestSystemRespMsg respMsg = new TestSystemRespMsg();
	    			        	respMsg.getMsgBody().put("commandCode", commandCode);
	    			        	
	    			        	for (String systemId : systemIdArr) {
	    							WebSocketSession session = sessionMap.get(systemId);
	    							if(session!=null&&session.isOpen()){
	    								session.sendMessage(new TextMessage(JSON.toJSONString(respMsg)));
	    							}
	    						}
	    			        	
	    		    	}
	    		    	result.setStatus(Result.SUCCESS);
				} catch (Exception e) {
					result.setStatus(Result.EXCEPTION);
				}
    			return JSON.toJSONString(result);
    }

    
    @RequestMapping("/stateDetail")
    public String stateDetail(HttpServletRequest request,Model model,Integer state,String color,String stateText) throws UnsupportedEncodingException{
		    	/*SELECT * FROM test_system WHERE state=$(state),然后跳转到此页面，
		    	 * 但是此页面内部还要通过websocket连接server定时刷新最喜状态
		    	*/
		    	List<TestSystem> list=testSystemService.getVOListByState(state);
		    	model.addAttribute("systemList", list);
		    	model.addAttribute("state", state);
		    	model.addAttribute("color", color);
		    	model.addAttribute("stateText", new String(stateText.getBytes("iso-8859-1"), "UTF-8"));
		    	return "stateDetail";
    }
    
    @RequestMapping("/typeDetail")
    public String typeDetail(HttpServletRequest request,Model model,Integer typeId,String typeText) throws UnsupportedEncodingException{
		    	List<TestSystem> list=testSystemService.getVOListByTypeId(typeId);
		    	model.addAttribute("systemList", list);
		    	model.addAttribute("typeId", typeId);
		    	model.addAttribute("typeText", new String(typeText.getBytes("iso-8859-1"), "UTF-8"));
		    	return "typeDetail";
    }
    
    
    @RequestMapping("/toWebSocket")
    public String toWebSocket(HttpServletRequest request){
    	return "websocketDemo";
    }
    
    
    
    @RequestMapping("/uploadLog")
    public String uploadLog(@RequestParam(value = "logFile", required = false) MultipartFile logFile, HttpServletRequest request,HttpServletResponse response,String systemId, ModelMap model) throws IOException {  
	        String path = SpringPropertiesUtil.getString("logPath");
	        String fileName = logFile.getOriginalFilename();  
	        File targetFile = new File(path, fileName);  
	        if(!targetFile.exists()){  
	            	targetFile.mkdirs();  
	        }  
	        try {  
	        		logFile.transferTo(targetFile);  
	        		response.getWriter().write("success");
	        } catch (Exception e) {  
	            	e.printStackTrace();  
	            	response.getWriter().write("fail");
	        }  
	        return null;  
    }  
    @RequestMapping("/login")
    public String login(HttpServletRequest request) {  
    	 	return "redirect:state_typeList "; 
    }  
    @RequestMapping("/lessTest")
    public String lessTest(HttpServletRequest request) {  
    	return "lessTest";
    }  
}  