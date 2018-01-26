<html>
<head>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- <script type="text/javascript" src="https://cdn.rawgit.com/ricmoo/aes-js/e27b99df/index.js"></script> -->
<%-- <script type="text/javascript" src="<%=basePath%>/js/core.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/mode-ecb.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/aes.js"></script> --%>
<script type="text/javascript" src="<%=basePath%>/js/aes_2.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery-1.10.2.min.js"></script>
<script src="http://cdn.bootcss.com/blueimp-md5/1.1.0/js/md5.js"></script>

<script type="text/javascript">
	$(function(){
		var userName = '湖南';
		var password = '123456';
		var timestamp = (new Date()).valueOf();
		var totalCharactor = userName + password+ timestamp;
		var token = md5(totalCharactor);
		var FileController = "/api/uploadExcel.do?timestamp=" + timestamp
				+ "&token=" + token + "&userName=" + userName; // 接收上传文件的后台地址  
		$("#myform").attr("action","/api/uploadExcel.do?timestamp="+timestamp+"&token="+token+"&userName="+userName);
	});
</script>
</head>
<body>
	<div class="input-chunk">
		<form id="myform" name="myform" action="/api/uploadExcel.do" method="post"
			enctype="multipart/form-data">
			选择文件:<br> <input type="file" name="myfile"><br> <br>
			<input type="submit" name="submit" value="开始提交">
		</form>
	</div>
</body>
</html>
