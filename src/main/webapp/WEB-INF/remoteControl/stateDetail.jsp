<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <title>Bootstrap 模板</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
      <link href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" rel="stylesheet">
      
      
      <link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel="stylesheet">
      <link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
      
      <script src="${pageContext.request.contextPath}/resources/js/jquery-2.1.1.min.js"></script>
      <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
      
      <script src="${pageContext.request.contextPath}/resources/layer/layer.js"></script>
     <style type="text/css">
     		.chosen{
     				border: 2px solid #2E80DC;
     		}
     </style>
</head>
<body>
	  <%@include file="../common/header.jsp"%> 
	  <%@include file="../common/sidebar.jsp"%> 
		
	 <div class="col-sm-9 col-md-10 sidebar">
				<div class="container" id="container">
						<input type="hidden" value="${pageContext.request.contextPath}" id="input_contextPath">
						<input type="hidden" id="input_state" name="state" value="${state }">
						<input type="hidden" id="input_color" name="color" value="${color }">
						<input type="hidden" id="input_stateText" name="stateText" value="${stateText }">
						<h3>测试系统[${stateText}]列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${state eq 5 }">
									<button type="submit" class="btn btn-info" onclick="test(0)">开始测试&nbsp;<span class="glyphicon glyphicon-play"></span></button>
									<button type="submit" class="btn btn-info" onclick="test(0)">暂停测试&nbsp;<span class="glyphicon glyphicon-pause"></span></button>
									<button type="submit" class="btn btn-info" onclick="test(0)">停止测试&nbsp;<span class="glyphicon glyphicon-stop"></span></button>
							</c:if>
							<a href="${pageContext.request.contextPath}/state_typeList">
									<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-backward"></span>&nbsp;返回</button>
							</a>
						</h3> 
						
						<table class="table table-condensed" id="table_systemList">
							  <thead>
								    <tr>
								    	  <c:if test="${state eq 5 }">
								    	  		 <th>
										    	  	<input type="checkbox" id="input_chosenAll" style="cursor: pointer;">
										    	  </th>
								    	  </c:if>
									      <th>mac地址</th>
									      <th>IP地址</th>
									      <th>经度</th>
									      <th>纬度</th>
									      <th>测试类型</th>
								     </tr>
							  </thead>
							  <tbody>
							  		<c:forEach items="${systemList }" var="system" varStatus="status">
											<tr>
												  <c:if test="${state eq 5 }">
												  		 <td>
									  				 	  	<input   type="checkbox" class="checkbox" state="${system.state }" systemId=${system.systemId } index="${status.index}">
									  				 	  </td>
												  </c:if>
											      <td>${system.mac }</td>
											      <td>${system.lastIp }</td>
											      <td>${system.lastLng }</td>
											      <td>${system.lastLat }</td>
											      <td>
											      		<c:choose>
															<c:when test="${system.typeId eq 0}">
																LET基站测试cms500
															</c:when>
															<c:when test="${system.typeId eq 1}">
																LET基站测试切换箱
															</c:when>
															<c:when test="${system.typeId eq 2}">
																LET基站可靠性测试-协议4.0
															</c:when>
															<c:when test="${system.typeId eq 3}">
																LET基站实验室测试-协议4.0
															</c:when>
															<c:when test="${system.typeId eq 4}">
																Femato基站射频测试系统
															</c:when>
															<c:when test="${system.typeId eq 5}">
																无源器件S参数测试系统
															</c:when>
														</c:choose>
											      </td>
										    </tr>
							  		</c:forEach>
							  </tbody>
						</table>
				</div>
	 </div>
	  <%@include file="../common/footer.jsp"%>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript">
		$(".checkbox").click(function(){
				if(isChecked($(this))){
					shiftRangeSelectCheckbox(this);
				}
		});


		$("#input_chosenAll").click(function(){
				if(isChecked($(this))){
					$(".checkbox").each(function(){
								this.checked="checked";
					});
				}else{
					$(".checkbox").each(function(){
							    this.checked=null;
					});
					last2clickedIndex=[];
				};
		});
</script>
<script type="text/javascript">
            $(function(){
		                var state=$("#input_state").val();		
		                var color=$("#input_color").val();
		                var stateText=$("#input_stateText").val();
		                var typeTextList=['LET基站测试cms500','LET基站测试切换箱','LET基站可靠性测试-协议4.0','LET基站实验室测试-协议4.0','Femato基站射频测试系统','无源器件S参数测试系统'];
		                
		                bindWebsocket("ws://192.168.0.106/websocket/stateDetailHandler?state="+state,
		                		function(evnt){
		                			//alert("连接成功");
		                },function(evnt){
		                		//alert("连接失败");
		                },function(evnt){
			                	//此页面即时监测某种状态下的测试系统
				                 var testSystemList = eval("("+evnt.data+")"); 
				               
				                  $("#table_systemList tbody").empty();//清除旧元素
				                  last2clickedIndex=[];
				                  var state=$("#input_state").val();
				                 
				                 // alert("清除完毕");
				                  for(var i=0;i<testSystemList.length;i++){  //追加新元素
					                	  	var testSystem=testSystemList[i];
				                  			var pre='';
					                	  	if(state==5){
					                	  		pre='<td>'
					  				 	  			  +'<input type="checkbox" class="checkbox" state="'+testSystem.state+'" systemId="'+testSystem.systemId+'" index="'+i+'">'
						  				 	       +'</td>';
							                }
					                	  	$("#table_systemList tbody").append($('<tr>'
																		    		  +pre
																				      +'<td>'+filterUndefined(testSystem.mac)+'</td>'
																				      +'<td>'+filterUndefined(testSystem.lastIp)+'</td>'
																				      +'<td>'+filterUndefined(testSystem.lastLng)+'</td>'
																				      +'<td>'+filterUndefined(testSystem.lastLat)+'</td>'
																				      +'<td>'+typeTextList[testSystem.typeId]+'</td>'
																	    		+'</tr>'));
				                  }
				                  $(".checkbox").click(function(){
						      				if(isChecked($(this))){
						      					shiftRangeSelectCheckbox(this);
						      				}
						      	  });
		                },function(evnt){
		                		//alert("被服务端关闭！");
		                });
            });
</script>        
</html>