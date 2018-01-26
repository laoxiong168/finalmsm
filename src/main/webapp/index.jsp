<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<title>Bootstrap 实例 - 模态框（Modal）插件</title>
<style type="text/css">
body {
	text-align: center;
}

.all {
	margin: 0 auto;
	width: 300px;
	height: 100px
}
</style>
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
	});
	function buttonClick() {
		var name = $("#name").val();
		var telNum = $("#telNum").val();
		$("#telNum").val("");
		$("#name").val("");
		/* 	$("#cancle").trigger("click"); */
		$.ajax({
			url : "http://localhost:8080/bootstrap/user/login",
			type : "get",
			headers : {"headerTest":"test123"},
			data : {
				"name" : name,
				"telNum" : telNum
			},
			success : function(res) {
				var data = eval("(" + res + ")");
				$("#name").val(data.msg);
			}
		}

		);
	}
</script>
</head>
<body>
	<h2>登录</h2>
	<div class="all">
		<button class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#myModal">登录</button>

		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content" style="width: 280px">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">订单查询</h4>
					</div>
					<div class="modal-body">
						<div class="input-group">
							<span class="input-group-addon">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
							<input type="text" id="name" class="form-control"
								placeholder="输入姓名">
						</div>
						<div class="input-group">
							<span class="input-group-addon">电话号码</span> <input type="text"
								id="telNum" class="form-control" placeholder="输入电话号码"
								onkeypress="return event.keyCode>=48&&event.keyCode<=57"  >
						</div>
					</div>
					<div></div>
					<div class="modal-footer">
						<button type="button" id="cancle" class="btn btn-default"
							data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary"
							onclick="buttonClick()">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>

	</div>
</body>
</html>
