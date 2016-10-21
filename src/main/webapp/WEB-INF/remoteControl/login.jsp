<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
		  <meta charset="UTF-8">
		  <title>登录页面</title>
		  <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	      <link href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css" rel="stylesheet">
	      
	      <script src="${pageContext.request.contextPath}/resources/js/jquery-2.1.1.min.js"></script>
	      <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	      
	      <script src="${pageContext.request.contextPath}/resources/layer/layer.js"></script>
</head>
<body style="background-color: #303641">
		<div class="container" style="width: 400px;margin-top: 80px;">
				<form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/login" method="post">
					  <div class="input-group">
					  		 <span class="input-group-addon" style="background-color: #373E4A">
					  		 		<span class="glyphicon glyphicon-user" style="color: #555555"></span>
					  		 </span>
				            <input type="text" class="form-control" name="username" placeholder="用户名" style="background-color: #373E4A;height: 50px;" >
				       </div>
					  <div class="input-group" style="margin-top: 19px;">
				            <span class="input-group-addon" style="background-color: #373E4A">
				            	<span class="glyphicon glyphicon-eye-close" id="span_eyeCloseOpen" style="color: #555555"></span>
				            </span>
				            <input type="password" name="password" id="input_password" class="form-control" placeholder="密码" style="background-color: #373E4A;height: 50px;">
				            <span class="input-group-addon" style="background-color: #373E4A">
				            			<span class="glyphicon glyphicon-eye-open" id="pswShowTypeSwitcher" style="cursor: pointer;" title="显示明文!"></span>
				            </span>
				       </div>
					   <div class="input-group" style="margin-top: 12px;">
						      <button type="submit"  class="btn btn-info navbar-btn" style="width: 370px;height: 50px;">
								    登&nbsp;&nbsp;录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								    <span class="glyphicon glyphicon-log-in"></span>
						      </button>
					    </div>
				</form>
		</div>
</body>


<script type="text/javascript">
			$("#pswShowTypeSwitcher").click(function(){
				if($(this).attr("title")=="显示明文!"){
						$("#span_eyeCloseOpen").removeClass("glyphicon-eye-close");
						$("#span_eyeCloseOpen").addClass("glyphicon-eye-open");
						
						$("#input_password").attr("type","text");
						
						$(this).removeClass("glyphicon-eye-open");
						$(this).addClass("glyphicon-eye-close");
						$(this).attr("title","显示密文!");
				}else{
						$("#span_eyeCloseOpen").removeClass("glyphicon-eye-open");
						$("#span_eyeCloseOpen").addClass("glyphicon-eye-close");
						
						$("#input_password").attr("type","password");
						
						$(this).removeClass("glyphicon-eye-close");
						$(this).addClass("glyphicon-eye-open");
						$(this).attr("title","显示明文!");
				}
				
			});
</script>
</html>