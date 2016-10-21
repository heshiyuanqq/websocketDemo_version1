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
     		.clickable{
      				cursor: pointer;
      		}
     </style>
</head>
<body>
<!-- 该页面要检测 -->
		 <%@include file="../common/header.jsp"%>
		 <%@include file="../common/sidebar.jsp"%>
		  <div class="col-sm-9 col-md-10 sidebar">
						<ul id="myTab" class="nav nav-tabs">
							    <li class="active">
							    		 
							        	<a href="#stateHome"  data-toggle="tab"><span class="glyphicon glyphicon-flash"></span>按状态分组 </a>
							    </li>
							    <li>
							    		<a href="#typeHome" data-toggle="tab"><span class="glyphicon glyphicon-th"></span>按类型分组</a>
							    </li>
						</ul>
						<div id="myTabContent" class="tab-content">
							    <div class="tab-pane fade in active" id="stateHome">
										<div id="main_state" style="height:400px;"></div>
							    </div>
							    <div class="tab-pane fade in active" id="typeHome">
  										<div id="main_type" style="height:400px;width: 1000px;"></div>
							    </div>
						</div>
		  </div>
		  <%@include file="../common/footer.jsp"%>
</body>
<!-- ECharts单文件引入 -->
 <script src="${pageContext.request.contextPath}/resources/echarts/echarts.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
  <script type="text/javascript">
  		 $(function(){
  			 			//*******************************echarts开始**********************************************
  			 		 require.config({//加载配置
  			 	         paths: {
  			 	             echarts: '${pageContext.request.contextPath}/resources/echarts'
  			 	         }
  			 	     });	
  			 		 var stateTextList= ['测试异常', '测试完成', '系统空闲', '测试中', '测试暂停', '准备执行','离线中'];
  			 	     var stateColorList = ['rgb(238, 80, 154)','rgb(6, 132, 58)','rgb(151, 151, 151)','rgb(116, 248, 237)','rgb(250, 221, 91)','rgb(30, 212, 3)','rgb(206, 198, 198)'];
  			 	     var stateCountArr=eval("${stateCountListStr}");
  			 	     //********************option_state开始***************************
  			 	     var option_state = {//设置显示参数
  			 	 		    title: {
  			 	 		        x: 'center',
  			 	 		        text: '测试系统状态统计图',
  			 	 		    },
  			 	 		    tooltip: {
  			 	 		        trigger: 'item',
  			 	 		        formatter:function(){
  			 	 		        	return "双击查看详情!";
  			 	 		        }
  			 	 		    },
  			 	 		    toolbox: {
  			 	 		        show: true,
  			 	 		        feature: {
  			 	 		            dataView: {show: true, readOnly: false},
  			 	 		            restore: {show: true,title:'刷新'},
  			 	 		            saveAsImage: {show: true}
  			 	 		        }
  			 	 		    },
  			 	 		    calculable: true,
  			 	 		    grid: {
  			 	 		        borderWidth: 0,
  			 	 		        y: 80,
  			 	 		        y2: 60
  			 	 		    },
  			 	 		    xAxis: [
  			 	 		        {
  			 	 		            type: 'category',
  			 	 		            show: true,
  			 	 		            data:stateTextList
  			 	 		        }
  			 	 		    ],
  			 	 		    yAxis: [
  			 	 		        {
  			 	 		            type: 'value',
  			 	 		            show: true
  			 	 		        }
  			 	 		    ],
  			 	 		    series: [
  			 	 		        {
  			 	 		            type: 'bar',
  			 	 		            itemStyle: {
  			 	 		                normal: {
  			 	 		                    color: function(params) {
  			 	 		                        return stateColorList[params.dataIndex]
  			 	 		                    },
  			 	 		                    label: {
  			 	 		                        show: true,
  			 	 		                        position: 'top',
  			 	 		                        formatter: '{b}\n{c}'
  			 	 		                    }
  			 	 		                }
  			 	 		            },
  			 	 		            data: stateCountArr,
  			 	 		        }
  			 	 		    ]
  			 	 		};
					//*******************************option_state结束********************************************
					function showStateEcharts(){
							 // 开始使用
		  			 	      require(['echarts','echarts/chart/bar'], // 使用柱状图就加载bar模块，按需加载
		  			 		          function (ec) {
		  			 	    	  			 var ecConfig = require('echarts/config');  
		  			 			             var myChart = ec.init(document.getElementById('main_state')); 
		  			 			             myChart.setOption(option_state);  // 为echarts对象加载数据 
		  			 			             
		  			 			             myChart.on(ecConfig.EVENT.DBLCLICK, function(param){
		  			 				            	 var color=stateColorList[param.dataIndex];
		  			 				            	 var state=param.dataIndex;
		  			 				            	 var stateText=stateTextList[param.dataIndex];
		  			 				            	 var url="${pageContext.request.contextPath}/stateDetail?state="+state+"&color="+color+"&stateText="+stateText;
		  			 								 window.location.href=url;
		  			 			             });
		  			 		         });
					}
					
					showStateEcharts();
  			 			
  			 			//************************************echarts结束******************************************
  			 			
  			 			//**********************websocket_stateList开始**************************************************
  			 			bindWebsocket("ws://192.168.0.106/websocket/stateListHandler",
  			 					function(evnt){
  			 							//alert("连接成功！");
  			 					},function(evnt){
  			 							//alert("连接失败或者被服务器以外踹走！");
  			 					},function(evnt){
		  			 					 var arr=eval("("+evnt.data+")");
		  				            	 option_state.series[0].data=arr;
		  				            	 showStateEcharts(); 
  			 					},function(){
  			 							// alert("被服务端强制关闭！");
  			 					});
  			 			
			           //**********************websocket_stateList结束**************************************************
			           
			                 var typeTextMap= {' ':'LET基站测试\ncms500','  ':'LET基站测试\n切换箱','   ':'LET基站可靠\n性测试-协议4.0','    ':'LET基站实验\n室测试-协议4.0','     ':'Femato基站射\n频测试系统','      ':'无源器件S参数\n测试系统'};
			                 var typeTextArr= ['LET基站测试\ncms500','LET基站测试\n切换箱','LET基站可靠\n性测试-协议4.0','LET基站实验\n室测试-协议4.0','Femato基站射\n频测试系统','无源器件S参数\n测试系统'];
		  			 	     var typeCountArr=eval("${typeCountListStr}");;
		  			 	     var option_type = {//设置显示参数
		  			 	 		    title: {
		  			 	 		        x: 'center',
		  			 	 		        text: '测试系统类型统计图',
		  			 	 		    },
		  			 	 		    tooltip: {
		  			 	 		        trigger: 'item',
		  			 	 		        formatter:function(){
		  			 	 		        	return "双击查看详情！";
		  			 	 		        }
		  			 	 		    },
		  			 	 		    toolbox: {
		  			 	 		        show: true,
		  			 	 		        feature: {
		  			 	 		            dataView: {show: true, readOnly: false},
		  			 	 		            restore: {show: true},
		  			 	 		            saveAsImage: {show: true}
		  			 	 		        }
		  			 	 		    },
		  			 	 		    calculable: true,
		  			 	 		    grid: {
		  			 	 		        borderWidth: 0,
		  			 	 		        y: 80,
		  			 	 		        y2: 60
		  			 	 		    },
		  			 	 		    xAxis: [
		  			 	 		        {
		  			 	 		            type: 'category',
		  			 	 		            show: true,
		  			 	 		            data:[' ','  ','   ','    ','     ','      '],
			  			 	 		        axisLabel:{
					  			 	 	            interval: 0,//标签设置为全部显示
					  			 	 	            formatter:function(params){
					  			 	 	            	return typeTextMap[params];
					  			 	 	            }
		  			 	 	       		    }
		  			 	 		        }
		  			 	 		    ],
		  			 	 		    yAxis: [
		  			 	 		        {
		  			 	 		            type: 'value',
		  			 	 		            show: true
		  			 	 		        }
		  			 	 		    ],
		  			 	 		    series: [
		  			 	 		        {
		  			 	 		            type: 'bar',
		  			 	 		            itemStyle: {
		  			 	 		                normal: {
		  			 	 		                    color: function(params) {
		  			 	 		                        return "#48B8D9";
		  			 	 		                    },
		  			 	 		                    label: {
		  			 	 		                        show: true,
		  			 	 		                        position: 'top',
		  			 	 		                        formatter: '{b}\n{c}'
		  			 	 		                    }
		  			 	 		                }
		  			 	 		            },
		  			 	 		            data: typeCountArr,
		  			 	 		        }
		  			 	 		    ]
		  			 	 		};
		  			 	     
		  			 	     
				  			 	  function showTypeEcharts(){
										 // 开始使用
					  			 	      require(['echarts','echarts/chart/bar'], // 使用柱状图就加载bar模块，按需加载
					  			 		          function (ec) {
					  			 	    	  			 var ecConfig = require('echarts/config');  
					  			 			             var myChart = ec.init(document.getElementById('main_type')); 
					  			 			             myChart.setOption(option_type);  // 为echarts对象加载数据 
					  			 			             myChart.on(ecConfig.EVENT.DBLCLICK, function(param){
					  			 			            	 	//类型不会轻易改变，指示在添加的时候需要改变
					  			 			            	 	 var typeId=param.dataIndex;
					  			 			            	 	 var typeText=typeTextArr[typeId];
						  			 			            	 var url="${pageContext.request.contextPath}/typeDetail?typeId="+typeId+"&typeText="+typeText;
						  			 			            	// alert("url="+url);
					  			 								 window.location.href=url;
					  			 			             });
					  			 		         });
								}
					        	showTypeEcharts();
					        	
					        	
					        	
					        	//**********************websocket_typeList开始**************************************************
					        	 bindWebsocket("ws://192.168.0.106/websocket/typeListHandler",
					        			 function(evnt){
					        		 		//alert("连接成功！");
					        	 },function(evnt){
					        		 	//alert("连接失败或者被服务器以外踹走！");
					        	 },function(evnt){
						        		 var arr=eval("("+evnt.data+")");
						            	 option_type.series[0].data=arr;
						            	 showTypeEcharts();  
					        	 },function(evnt){
					        		 	 //alert("被服务端强制关闭！");
					        	 });
					           //**********************websocket_typeList结束**************************************************
            });
  </script>
</html>