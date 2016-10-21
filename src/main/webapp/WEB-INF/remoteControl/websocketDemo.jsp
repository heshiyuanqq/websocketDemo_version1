<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	      <link href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" rel="stylesheet">
	      <link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel="stylesheet">
	      <link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	      <script src="${pageContext.request.contextPath}/resources/js/jquery-2.1.1.min.js"></script>
	      <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	      <script src="${pageContext.request.contextPath}/resources/layer/layer.js"></script>
</head>
<body>

		<div class="container" style="background-color: #DBD6D3">
					<h1 style="text-align: center;">C#端测试系统模拟界面</h1>
					<form class="form-horizontal" id="initForm">
						  <div class="form-group">
							    <label for="mac" class="col-sm-3 control-label">测试系统mac地址：</label>
							    <div class="col-sm-8">
							      <input type="text" class="form-control" name="mac" id="mac"/>
							    </div>
						  </div>
						  <div class="form-group">
							    <label for="lastIp" class="col-sm-3 control-label">当前ip：</label>
							    <div class="col-sm-8">
							      <input type="text" class="form-control" name="lastIp" id="lastIp"/>
							    </div>
						  </div>
						  <div class="form-group">
							    <label for="lastLng" class="col-sm-3 control-label">当前经度：</label>
							    <div class="col-sm-8">
							      <input type="text" class="form-control" name="lastLng" id="lastLng"/>
							    </div>
						  </div>
						  <div class="form-group">
							    <label for="lastLat" class="col-sm-3 control-label">当前纬度：</label>
							    <div class="col-sm-8">
							      <input type="text" class="form-control" name="lastLat" id="lastLat"/>
							    </div>
						  </div>
						  <div class="form-group">
							    <label for="typeId"  class="col-sm-3 control-label">指定测试系统类型:</label>
							    <div class="col-sm-8">
									    <select name="typeId" id="typeId" class="form-control">
												<option value="-1">---请选择类型---</option>
												<option value="0">LET基站测试cms500</option>
												<option value="1">LET基站测试切换箱</option>
												<option value="2">LET基站可靠性测试-协议4.0</option>
												<option value="3">LET基站实验室测试-协议4.0</option>
												<option value="4">Femato基站射频测试系统</option>
												<option value="5">无源器件S参数测试系统</option>
										  </select>
							    </div>
						  </div>
						  <div class="form-group">
							    <label for="state"  class="col-sm-3 control-label">初始化测试状态：</label>
							    <div class="col-sm-8">
										   <select name="state" id="state" class="form-control">
													<option value="-2">---请选择状态---</option>
													<option value="0" style="background-color: #EE509A">测试异常</option>
													<option value="1" style="background-color: #06843A">测试完成</option>
													<option value="2" style="background-color: #979797">系统空闲</option>
													<option value="3" style="background-color: #74F8ED">测试中</option>
													<option value="4" style="background-color: #FADD5B">测试暂停</option>
													<option value="5" style="background-color: #1ED403">准备执行</option>
										</select>
							    </div>
						  </div>
						  <div class="form-group">
							    <div class="col-sm-offset-3 col-sm-8">
							      <button type="" class="btn btn-default" onclick="return createConnection();">生成测试系统并建立连接</button>
							      <button type="" class="btn btn-default" onclick="return offLine();">断开连接</button>
							    </div>
						  </div>
					</form>
					
					
					
		</div>
		<br/>
		<div class="container" style="background-color: #DBD6D3">
				<form class="form-horizontal" id="changeStateForm">
						  <div class="form-group">
							    <label for="newState"  class="col-sm-3 control-label">新状态：</label>
							    <div class="col-sm-8">
										   <select name="state" id="newState" class="form-control">
													<option value="-2">---请选择新状态---</option>
													<option value="0" style="background-color: #EE509A">测试异常</option>
													<option value="1" style="background-color: #06843A">测试完成</option>
													<option value="2" style="background-color: #979797">系统空闲</option>
													<option value="3" style="background-color: #74F8ED">测试中</option>
													<option value="4" style="background-color: #FADD5B">测试暂停</option>
													<option value="5" style="background-color: #1ED403">准备执行</option>
										</select>
							    </div>
						  </div>
						  <div class="form-group">
							    <div class="col-sm-offset-3 col-sm-8">
							      <button type="" class="btn btn-default" onclick="return updateState();">立即更新</button>
							    </div>
						  </div>
					</form>
					<br/>
					<br/>
					<br/>
					<form action="${pageContext.request.contextPath}/uploadLog" method="post" class="form-horizontal" id="uploadLogForm" enctype="multipart/form-data">
						  <div class="form-group">
							    <label for="logFile"  class="col-sm-3 control-label">选择日志：</label>
							    <div class="col-sm-8">
										 <input type="file" class="form-control" name="logFile" id="logFile"/>
										 <input type="text" name="systemId" value="000000000000000_5_0"><br/>
										<button class="btn btn-default">上传</button>
							    </div>
						  </div>
					</form>
					
		</div>
</body>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
			var websocket;
			
			function createConnection(){
					if(websocket){//已经连接了，就不用不再继续连接
						alert("已经连接！");
						return false;
					}
					var mac=$("#initForm").find("input[name='mac']").val();	
					var lastIp=$("#initForm").find("input[name='lastIp']").val();	
					var lastLng=$("#initForm").find("input[name='lastLng']").val();	
					var lastLat=$("#initForm").find("input[name='lastLat']").val();	
					var typeId=$("#initForm").find("select[name='typeId']").val();	
					var state=$("#initForm").find("select[name='state']").val();	
					var url="ws://192.168.0.106/websocket/webSocketServer?mac="+mac+"&lastIp="+lastIp+"&lastLng="+lastLng+"&lastLat="+lastLat+"&typeId="+typeId+"&state="+state;
					//alert("url="+url);
					
				   if ('WebSocket' in window) {
		                	websocket = new WebSocket(url);
		            } else if ('MozWebSocket' in window) {
		                	websocket = new MozWebSocket(url);
		            } else {
		                	websocket = new SockJS("http://127.0.0.1/websocket/sockjs/webSocketServer");
		            }
		            //连接成功时触发
		            websocket.onopen = function (evnt) {
		            	//alert("连接成功！");
		            };
		            //连接失败触发
		            websocket.onerror = function (evnt) {
		            	//alert("连接错误！");
		            	offLine();
		            };
		           //接收到服务端消息时触发
		            websocket.onmessage = function (evnt) {
		        	  // alert("收到控制消息");
		        	   //todotodotodotodotodo服务端已经显示成功send命令了，但是这里没反应
							//	alert("接收到控制命令："+evnt.data.msgBody.commandCode);
		            };
		            //检测到服务端断开时触发
		            websocket.onclose = function (evnt) {
		            	//alert("连接关闭");
		            	offLine();
		            }
					return false;
			}


           
            
            
            function sendMsg(msg){
            	websocket.send(msg);
            	
            }
            
            function offLine(){
            	if(websocket){
            		//alert("即将为您断开");
            		websocket.close();
    				websocket=null;
            	}
            	return false;
			}
            
            
            
            function updateState(){
            	//向服务端发消息："{'msgBody':{'state':0}}"
            	var newState=$("#changeStateForm").find("select[name='state']").val();
            	
            	var msg="{'msgBody':{'state':"+newState+"}}";
            	
            //	alert("msg="+msg);
            	sendMsg(msg);
            	return false;
            }

</script>        

</html>