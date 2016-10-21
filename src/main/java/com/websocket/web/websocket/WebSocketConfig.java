package com.websocket.web.websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import com.websocket.web.controller.StateDetailHandlerController;
import com.websocket.web.controller.RemoteHandlerController;
import com.websocket.web.controller.StateListHandlerController;
import com.websocket.web.controller.TypeDetailHandlerController;
import com.websocket.web.controller.TypeListHandlerController;
import com.websocket.web.service.TestSystemService;
import com.websocket.web.utils.SpringBeanUtils;
import com.websocket.web.websocket.intercepter.SetParamsIntercepter;
import com.websocket.web.websocket.intercepter.SetStateIntercepter;
import com.websocket.web.websocket.intercepter.SetTypeIdIntercepter;


@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(getRemoteHandlerController(),"/webSocketServer").addInterceptors(new SetParamsIntercepter());
        registry.addHandler(getStateDetailHandlerController(),"/stateDetailHandler").addInterceptors(new SetStateIntercepter());
        registry.addHandler(getStateListHandlerController(),"/stateListHandler");
        registry.addHandler(getTypeListHandlerController(),"/typeListHandler");
        registry.addHandler(getTypeDetailHandlerController(),"/typeDetailHandler").addInterceptors(new SetTypeIdIntercepter());
        
        /*
        registry.addHandler(getRemoteController(), "/sockjs/webSocketServer").addInterceptors(new SetParamsIntercepter())
                .withSockJS();*/
    }

    @Bean
    public WebSocketHandler getRemoteHandlerController(){
    	RemoteHandlerController remoteHandler = new RemoteHandlerController();
    	remoteHandler.setTestSystemService(SpringBeanUtils.getBean(TestSystemService.class));
        return remoteHandler;
    }
    @Bean
    public WebSocketHandler getStateDetailHandlerController(){
    	StateDetailHandlerController handler = new StateDetailHandlerController();
    	handler.setTestSystemService(SpringBeanUtils.getBean(TestSystemService.class));
    	return handler;
    }
    
    
    @Bean
    public WebSocketHandler getStateListHandlerController(){
    	StateListHandlerController handler = new StateListHandlerController();
    	handler.setTestSystemService(SpringBeanUtils.getBean(TestSystemService.class));
    	return handler;
    }
    
    
    @Bean
    public WebSocketHandler getTypeListHandlerController(){
    	TypeListHandlerController handler = new TypeListHandlerController();
    	handler.setTestSystemService(SpringBeanUtils.getBean(TestSystemService.class));
    	return handler;
    }
    
    @Bean
    public WebSocketHandler getTypeDetailHandlerController(){
    	TypeDetailHandlerController handler = new TypeDetailHandlerController();
    	handler.setTestSystemService(SpringBeanUtils.getBean(TestSystemService.class));
    	return handler;
    }
    
    

}