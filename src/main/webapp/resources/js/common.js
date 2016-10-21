
		var shiftDown=false;
		var last2clickedIndex=[];//用于按shift范围选中的记录起始角标的数组
		$("body").keydown(function(x){
			if(x.keyCode==16){
				shiftDown=true;
			}
		});
		
		$("body").keyup(function(x){
			if(x.keyCode==16){
				shiftDown=false;
			}
		});
		

/* 向选中的测试系统发送命令 */

		function test(commandCode){
				var systemIds="";
				var readyTest=false;
				$(".checkbox").each(function(){
						if(this.checked){
							readyTest=true;
							systemIds+=$(this).attr("systemId");
							systemIds+=",";
						}
					
				});
				systemIds=systemIds.replace(/,$/,""); 
				
				if(readyTest){
						//layer.alert('开始测试！'); 
						layer.confirm('确定提交测试吗？', {icon: 3, title:'提示'}, function(index){
								  $.ajax({
										type : "POST",
										dataType:"JSON",
										async : false,
										url : $("#input_contextPath").val()+"/postCommandCode",
										data :{'commandCode': commandCode,'systemIds':systemIds},
										success : function(data) {
												if(data.status==0){
													layer.alert("提交成功！");
													disChosenAll();
												}else if(data.status==1){
													layer.alert("提交失败！");
												}
										},
										fail : function() {
												layer.alert("提交失败！");
										}
									});
								  layer.close(index);
						});
				}else{
					layer.alert("请至少选择一个测试系统！");
				}
		}
		
		
		function isChecked(checInput$){
			if(checInput$[0].checked){
				return true;
			}else{
				return false;
			}
		}
		
		
		
		function disChosenAll(){
			$("#input_chosenAll")[0].checked=null;
			$(".checkbox").each(function(){
					this.checked=null;
			});
		}
		
		function hidden($ele){
			$ele.css("display","none");
		}
		
		function show($ele){
			$ele.css("display","");
		}
	
		
		function clickSingleCheckbox(checkbox_dom){
				if(isChecked($(checkbox_dom))){
						if($(checkbox_dom).attr("state")!="5"){
							checkbox_dom.checked=null;
							layer.alert("未准备就绪，暂不能开始测试！");
						}else{
							shiftRangeSelectCheckbox(checkbox_dom);
						}
				}
		}
		
		
		//当按住shift时选中一个checkbox时的处理逻辑
		function  shiftRangeSelectCheckbox(checkbox_dom){
					last2clickedIndex.push(parseInt($(checkbox_dom).attr("index")));
					if(last2clickedIndex.length>2){
							last2clickedIndex.shift();
					}
					//当按下shift时
					if(shiftDown&&last2clickedIndex.length==2){
							var smallIndex=last2clickedIndex[0];
							var largeIndex=last2clickedIndex[1];
							if(smallIndex>largeIndex){
									var tempIndex=smallIndex;
									smallIndex=largeIndex;
									largeIndex=tempIndex;
							}
							//将first和second之间的checkbox选中即可
							var arr=$("#table_systemList tbody input[type='checkbox']");
							for(var i=smallIndex;i<=largeIndex;i++){
									if($(arr[i]).attr("state")=='5'){
											arr[i].checked="checked";
									}
							}
					}
		}
		
		
		function  clickChosenAllReadyCheckBox(checkbox_dom){
				if(isChecked($(checkbox_dom))){
					$(".checkbox").each(function(){
							if($(this).attr("state")=="5"){//系统准备就绪才能开启测试
								this.checked="checked";
							}
					});
				}else{
					$(".checkbox").each(function(){
							this.checked=null;
					});
					last2clickedIndex=[];
				}
		}
		
		
		
		function  filterUndefined(a){
				return a==undefined?'暂无':a;
		}
		
		
		function  bindWebsocket(wsurl,onOpen,onError,onMessage,onClose){
        	 var webscoket;
        	 if ('WebSocket' in window) {
        		 	webscoket = new WebSocket(wsurl);
             } else if ('MozWebSocket' in window) {
            	 	webscoket = new MozWebSocket(wsurl);
             } 
             //连接成功时触发
        	 webscoket.onopen = function (evnt) {
             		onOpen(evnt);
             };
             //连接失败触发
             webscoket.onerror = function (evnt) {
            	 	onError(evnt);
             };
             //收到服务端消息时触发
             webscoket.onmessage = function (evnt) {
            	 	onMessage(evnt);
             };
             //服务端关闭我时触发
             webscoket.onclose = function (evnt) {
            	 	onClose(evnt);
             }
		}
