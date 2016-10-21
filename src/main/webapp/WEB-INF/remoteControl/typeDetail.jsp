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
     		
     		.halfOpacity{
     				opacity:0.5;
     				filter:alpha(opacity=50);
     		}
     </style>
</head>
<body>
	  <%@include file="../common/header.jsp"%> 
	  <%@include file="../common/sidebar.jsp"%> 
		
	 <div class="col-sm-9 col-md-10 sidebar">
				<div class="container" id="container">
						<input type="hidden" value="${pageContext.request.contextPath}" id="input_contextPath">
						<input type="hidden" id="input_typeId" name="typeId" value="${typeId }">
						<input type="hidden" id="input_typeText" name="typeText" value="${typeText }">
						<h3>测试系统[${typeText}]列表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="submit" class="btn btn-info" onclick="test(0)">开始测试&nbsp;<span class="glyphicon glyphicon-play"></span></button>
							<button type="submit" class="btn btn-info" onclick="test(0)">暂停测试&nbsp;<span class="glyphicon glyphicon-pause"></span></button>
							<button type="submit" class="btn btn-info" onclick="test(0)">停止测试&nbsp;<span class="glyphicon glyphicon-stop"></span></button>
							<a href="${pageContext.request.contextPath}/state_typeList">
									<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-backward"></span>&nbsp;返回</button>
							</a>
						</h3> 
						
						
						<table class="table table-condensed" id="table_systemList">
							  <thead>
								    <tr>
								    	  <th>
								    	  	<input type="checkbox" id="input_chosenAll" style="cursor: pointer;">
								    	  </th>
									      <th>mac地址</th>
									      <th>IP地址</th>
									      <th>经度</th>
									      <th>纬度</th>
									      <th>测试状态</th>
								     </tr>
							  </thead>
							  <tbody>
							  		<c:forEach items="${systemList }" var="system"  varStatus="status">
							  				 <c:choose>
													<c:when test="${system.state eq 0}">
														 <tr style="background-color: rgb(238, 80, 154);">
													</c:when>
													<c:when test="${system.state eq 1}">
														<tr style="background-color: rgb(6, 132, 58)">
													</c:when>
													<c:when test="${system.state eq 2}">
														<tr style="background-color: rgb(151, 151, 151)">
													</c:when>
													<c:when test="${system.state eq 3}">
														<tr style="background-color: rgb(116, 248, 237)">
													</c:when>
													<c:when test="${system.state eq 4}">
														<tr style="background-color: rgb(250, 221, 91)">
													</c:when>
													<c:when test="${system.state eq 5}">
														<tr style="background-color: rgb(30, 212, 3)">
													</c:when>
													<c:when test="${system.state eq 6}">
														<tr style="background-color: rgb(206, 198, 198)">
													</c:when>
									         </c:choose>
							  				 	  <td>
							  				 	  	<input type="checkbox" class="checkbox" state="${system.state }" systemId=${system.systemId } index="${status.index}">
							  				 	  </td>
											      <td>${system.mac }</td>
											      <td>${system.lastIp }</td>
											      <td>${system.lastLng }</td>
											      <td>${system.lastLat }</td>
											      <td>
											      		<c:choose>
															<c:when test="${system.state eq 0}">
																测试异常
															</c:when>
															<c:when test="${system.state eq 1}">
																测试完毕
															</c:when>
															<c:when test="${system.state eq 2}">
																系统空闲
															</c:when>
															<c:when test="${system.state eq 3}">
																测试中
															</c:when>
															<c:when test="${system.state eq 4}">
																测试暂停
															</c:when>
															<c:when test="${system.state eq 5}">
																准备执行
															</c:when>
															<c:when test="${system.state eq 6}">
																已离线
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
				clickSingleCheckbox(this);
		});
		
		$("#input_chosenAll").click(function(){
			clickChosenAllReadyCheckBox(this);
	 	 });
</script>
<script type="text/javascript">
            $(function(){
		                var typeId=$("#input_typeId").val();
		                var typeText=$("#input_typeText").val();
		                var stateTextList= ['测试异常', '测试完成', '系统空闲', '测试中', '测试暂停', '准备执行','离线中'];
	  			 	    var stateColorList = ['#EE509A','rgb(6, 132, 58)','rgb(151, 151, 151)','rgb(116, 248, 237)','rgb(250, 221, 91)','rgb(30, 212, 3)','rgb(206, 198, 198)'];
            	
	  			 	    bindWebsocket("ws://192.168.0.106/websocket/typeDetailHandler?typeId="+typeId,
	  			 	    		function(evnt){
	  			 	    				//alert("连接成功");
	  			 	    },function(evnt){
	  			 	    		//alert("连接失败");
	  			 	    },function(evnt){
		  			 	 		//此页面即时监测某种状态下的测试系统
				                 var testSystemList = eval("("+evnt.data+")"); 
				               
				                  $("#table_systemList tbody").empty();//清除旧元素
				                  last2clickedIndex=[];
				                 // alert("清除完毕");
				                  for(var i=0;i<testSystemList.length;i++){  //追加新元素
					                	  	var testSystem=testSystemList[i];
				                  			
					                	  	$("#table_systemList tbody").append($('<tr style="background-color:'+stateColorList[testSystem.state]+' ">'
																			    		 +'<td>'
																	  				 	  	 +'<input type="checkbox" class="checkbox" state="'+testSystem.state+'" systemId="'+testSystem.systemId+'" index="'+i+'">'
																	  				 	  +'</td>'
																					      +'<td>'+filterUndefined(testSystem.mac)+'</td>'
																					      +'<td>'+filterUndefined(testSystem.lastIp)+'</td>'
																					      +'<td>'+filterUndefined(testSystem.lastLng)+'</td>'
																					      +'<td>'+filterUndefined(testSystem.lastLat)+'</td>'
																					      +'<td>'+stateTextList[testSystem.state]+'</td>'
																		    		+'</tr>'));
				                  }
				                  $(".checkbox").click(function(){
						      				clickSingleCheckbox(this);
						      	  });	
	  			 	    },function(evnt){
	  			 	    		  alert("被服务端关闭！");
	  			 	    });
            });
</script>        
</html>