<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	 <style type="text/css">
      		.navbar-btn{
      			margin-top: 20px;
      		}
      		
			.navbar-brand {
					height: 80px;
					margin-top: 10px;
			}
			
			.navbar {
					min-height: 80px;
			}
			
			
			.navbar-toggle {
					margin-top: 8px;
					margin-bottom: 8px;
			}
      </style>
</head>
<body>
		 <nav class="navbar navbar-default navbar-static-top" role="navigation">
	 		 <div class="container-fluid" style="background-color: #EEEEEE">
					    <div class="navbar-header">
							      <button type="button"  class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
								        <span class="icon-bar"></span>
								        <span class="icon-bar"></span>
								        <span class="icon-bar"></span>
							      </button>
							      <a class="navbar-brand" href="#">
							      		<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="" />
							      </a>
					    </div>
					    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					    		  <font class="navbar-text navbar-left" style="color: #0089C7;font-size: 40px" >XXXXXXXXXX远程测试平台</font>
							      <form class="navbar-form navbar-left" role="search" style="margin-left: 5%">
						        		 <button type="button" onclick="return toLoginPage()" class="btn btn-info navbar-btn" style="width: 70px;" >
								           	<span class="glyphicon glyphicon-user"></span>&nbsp;登录
								         </button>&nbsp;&nbsp;
								         <button type="button" class="btn btn-info navbar-btn" style="width: 70px;">
								           	<span class="glyphicon glyphicon-pencil"></span>&nbsp;注册
								         </button>
						          </form>
					    </div>
			  </div>
		</nav>
</body>

<script type="text/javascript">
		function toLoginPage(){
			
			window.location.href="${pageContext.request.contextPath}/toLogin";
		}
</script>
</html>