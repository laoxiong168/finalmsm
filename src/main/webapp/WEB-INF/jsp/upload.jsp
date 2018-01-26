
<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<title>上传excel</title>

<%-- <link rel="stylesheet" type="text/css" href="<%=basePath%>css/base.css"> --%>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/login.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrapValidator.min.css">
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=2885420509"
	type="text/javascript" charset="utf-8"></script>
<script
	src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="http://cdn.bootcss.com/blueimp-md5/1.1.0/js/md5.js"></script>

<style>
.a-upload {
	padding: 4px 10px;
	height: 30px;
	line-height: 20px;
	position: relative;
	cursor: pointer;
	color: #888;
	background: #fafafa;
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	display: inline-block;
	*display: inline;
	*zoom: 1
}

.a-upload input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	cursor: pointer
}

.a-upload:hover {
	color: #444;
	background: #eee;
	border-color: #ccc;
	text-decoration: none
}
</style>

</head>
<body>
	<canvas id="canvas"></canvas>
	<base id="baseUrl" href="<%=basePath%>+" /"/>
	<div class="wrap"
		style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; margin-top: 90px; margin-left: 35px;">
		<header>
			<h1>
				<font size="6">深圳-光启</font>
			</h1>
		</header>

		<!-- 		<div class="col-lg-8 col-lg-offset-2">
			<form id="defaultForm" method="post" action="target.php"
				class="form-horizontal">

				<a href="javascript:;" class="a-upload"
					style="margin-top: 5px; margin-bottom: 5px;"> <input
					type="file" name="" id=""> <span id="showFileName">点击这里上传文件</span>
				</a>
				<div class="form-group" style="width: 600px;">
					<label class="col-lg-3 control-label">账号：</label>
					<div class="col-lg-5">
						<input type="text" class="form-control" name="username" />
					</div>
				</div>

				<div class="form-group" style="width: 600px;">
					<label class="col-lg-3 control-label">密码：</label>
					<div class="col-lg-5">
						<input type="password" class="form-control" name="password" />
					</div>
				</div>

				<div class="form-group">
					<div class="col-lg-9 col-lg-offset-3">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</div>

			</form>
		</div>
 -->







		<section>





			<div class="input-chunk">
				<form id="myform" name="myform" action="/api/uploadExcel.do"
					method="post" enctype="multipart/form-data"
					onsubmit="return check();">

					<div class="modal-body">
						<a href="javascript:;" class="a-upload"
							style="margin-top: 5px; margin-bottom: 5px;"> <input
							type="file" name="myfile" id="myfile" accept="xls"> <span
							id="showFileName">点击这里选择文件</span>
						</a>
						<div class="input-group">
							<span class="input-group-addon">账号：</span> <input type="text"
								id="name" class="form-control" placeholder="请输入账号">

						</div>

						<div class="input-group" style="margin-top: 5px;">
							<span class="input-group-addon">密码：</span> <input type="password"
								id="password" class="form-control" placeholder="请输入密码">
						</div>

						<div>
							<input type="button" value="开始上传" name="btnSubmit"
								class="btn btn-default" id="btnSubmit"
								style="margin-top: 5px; width: 270px;">
						</div>






					</div>
				</form>
			</div>


		</section>
	</div>


	<script type="text/javascript"
		src="<%=basePath%>/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/login.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>/js/bootstrapValidator.min.js"></script>
	<script>
		$("#btnSubmit").click(function() {
			var userName = $("#name").val();
			var password = $("#password").val();
			var filePath = $("#myfile").val();

			if (userName == "") {
				alert("用户名不能为空");
				return false;
			} else if (password == "") {
				alert("密码不能为空");
				return false;
			} else if (filePath == "") {
				alert("请选择需要上传的文件");
				return false;
			}
            $("#btnSubmit").val("文件上传中...");
			var formUrl = $("#myform").attr("action");
			var form = new FormData(document.getElementById("myform"));
			$.ajax({
				url : formUrl,
				type : "post",
				data : form,
				processData : false,
				contentType : false,
				success : function(data) {
					if(data.isSuccess){
						$("#btnSubmit").val("文件加密存储成功");
						$("#myfile").val("");
						$("#showFileName").html("点击这里选择文件");
					}else if(!data.isSuccess){
						$("#btnSubmit").val(data.msg);
					}
					window.setTimeout(function(){$("#btnSubmit").val("开始上传");},3000); 
					
				},
				error : function(e) {
					alert("错误！！");
				}
			});
		});

		function check() {
			var userName = $("#name").val();
			var password = $("#password").val();
			var filePath = $("#myfile").val();

			if (userName == "") {
				alert("用户名不能为空");
				return false;
			} else if (password == "") {
				alert("密码不能为空");
				return false;
			} else if (filePath == "") {
				alert("请选择需要上传的文件");
				return false;
			}

			return true;

		}

		$(function() {

			var userName = '';
			var password = '';

			function tt() {
				alert("tt");
			}

			function handle() {

				userName = $("#name").val();
				password = $("#password").val();
				var timestamp = (new Date()).valueOf();
				var totalCharactor = userName + password + timestamp;
				var token = md5(totalCharactor);
				$("#myform").attr(
						"action",
						"/api/uploadExcel.do?timestamp=" + timestamp
								+ "&token=" + token + "&userName=" + userName);
			}

			$("#name").keyup(function() {
				handle();
			});

			$("#password").keyup(function() {
				handle();
			});

			var timestamp = (new Date()).valueOf();
			var totalCharactor = userName + password + timestamp;
			var token = md5(totalCharactor);
			var FileController = "/api/uploadExcel.do?timestamp=" + timestamp
					+ "&token=" + token + "&userName=" + userName; // 接收上传文件的后台地址  
			$("#myform").attr(
					"action",
					"/api/uploadExcel.do?timestamp=" + timestamp + "&token="
							+ token + "&userName=" + userName);

			$(".a-upload").on("change", "input[type='file']", function() {
				var filePath = $(this).val();
				if (filePath.indexOf("xls") != -1||filePath.indexOf("xlsx") != -1) {
					/* $(".fileerrorTip").html("").hide(); */
					var arr = filePath.split('\\');
					var fileName = arr[arr.length - 1];
					$("#showFileName").html(fileName);
				} else {
					alert("文件类型有误！请选择Excel文档！");
					return false
				}
			})
		});
	</script>
	<script>
		$(function() {
			/* 	$(".a-upload").on("change", "input[type='file']", function() {
					var filePath = $(this).val();
					if (filePath.indexOf("xls") != -1) {
						$(".fileerrorTip").html("").hide();
						var arr = filePath.split('\\');
						var fileName = arr[arr.length - 1];
						$("#showFileName").html(fileName);
					} else {
						alert("您上传文件类型有误！请上传后缀为.xls的excel文档！");
						return false
					}
				}) */

			$('#defaultForm')
					.bootstrapValidator(
							{
								message : 'This value is not valid',
								feedbackIcons : {
									valid : 'glyphicon glyphicon-ok',
									invalid : 'glyphicon glyphicon-remove',
									validating : 'glyphicon glyphicon-refresh'
								},
								fields : {
									username : {
										message : 'The username is not valid',
										validators : {
											notEmpty : {
												message : '用户名不得为空!'
											}

										}
									},
									password : {
										validators : {
											notEmpty : {
												message : '密码不能为空'
											},
											identical : {
												field : 'confirmPassword',
												message : 'The password and its confirm are not the same'
											}
										}
									}
								}
							});

		});
	</script>
</body>
</html>






























