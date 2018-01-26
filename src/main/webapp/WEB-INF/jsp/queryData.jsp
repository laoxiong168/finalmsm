
<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript"
	src="<%=basePath%>/js/jquery-1.10.2.min.js"></script>
<title>数据查询</title>
<script type="text/javascript">
	function login() {
		//这是使用ajax的方式提交
		$.ajax({
					type : 'post',
					url : '/api/query.do',
					//data:$('#loginInputForm').serialize(),
					data : {
						'name' : $("#user_code").val(),
						'idCode' : $("#user_account").val(),
						'verificationCode' : $("#VerificationCode").val(),
					},
					dataType : 'json',
					success : function(obj) {
						var rad = Math.floor(Math.random() * Math.pow(10, 8));
						if (obj && obj.success == 'true') {
							window.location.href = 'Uase/login.action';
						} else {
							document.getElementById("verification_Code").innerHTML = obj.msg;
							//uuuy是随便写的一个参数名称，后端不会做处理，作用是避免浏览器读取缓存的链接
							$("#randCodeImage").attr("src",
									"VerificationCode/generate.do?uuuy=" + rad);
							$("#VerificationCode").val("").focus(); // 清空并获得焦点
						}
					}
				});
	}

	/**
	 *验证码刷新
	 */
	function VerificationCode() {
		var rad = Math.floor(Math.random() * Math.pow(10, 8));
		//uuuy是随便写的一个参数名称，后端不会做处理，作用是避免浏览器读取缓存的链接
		$("#randCodeImage").attr("src",
				"VerificationCode/generate.do?uuuy=" + rad);
	}
</script>
<style type="text/css">
#all{   
position: absolute;      /*绝对定位*/   
top: 35%;                  /* 距顶部50%*/   
left: 50%;                  /* 距左边50%*/   
height: 200px;  margin-top: -100px;   /*margin-top为height一半的负值*/   
width: 400px;  margin-left: -200px;    /*margin-left为width一半的负值*/   
}   

</style>

</head>


<body>
<div id="all">



	<form>
	
	<div style="display:block;">
	
		<div id="login_tip">信息查询</div>
		<div>
			<input type="text" id="user_code" name="user_code" class="username"
				placeholder="请输入姓名">
		</div>
		<div>
			<input type="text" id="user_account" name="user_account"
				class="pwd" placeholder="请输入身份证号码"   >
		</div>
		<div>
			 <a
				href="javascript:void(0);" onclick="VerificationCode()">
				 <img
				id="randCodeImage" alt="验证码" src="VerificationCode/generate.do"
				width="100" height="40" />
			</a>
		</div>
		<div id="btn_area" >
			<input type="text" id="VerificationCode" name="VerificationCode"
				placeholder="请输入验证码" class="verify" style="width:90px;">
			
		</div>
		<div style=" display:inline-block;">
			<input type="button"  name="button" id="sub_btn" onclick="login()" style="display: inline-block;"
				value="查询" />
		</div>
		<div id="verification_Code1" style="display: inline-block;">
			<b style="display: inline-block;"></b>
		</div>
		
		
		</div>
		
		
		<div style="display:block;">
		<span id="verification_Code">
		</div>
		
		</span>
		
	</form>
	
	
	
	</div>
</body>
</html>






























