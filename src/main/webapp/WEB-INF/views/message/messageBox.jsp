<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
   <meta charset="UTF-8">
   <title>쪽지함</title>
   <link rel="icon" href="/img/Gazi_shortCut.png" />
   <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <link rel="stylesheet" href="/css/layout.css">
   <link rel="stylesheet" href="/css/HJHBoard.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<style>
.container{ display: flex; }
.table{ width:600px; box-sizing: border-box;}
.table-header{ width:100px; }
.msgBox_board{
	width:600px; 
/* 	border: 1px solid black; */
/* 	box-sizing: border-box; */
}
.msgBox_detail{
	display: inline-block;
	width:600px;
	height:600px;
	box-sizing: border-box;
}

.msg_detail{ 
	display:inline-block;
	width:600px;
	height:36px;
	line-height: 36px;
	background-color: #d3d3d3;
	font-size: 20px;
	font-weight: bold;
	border-left: 1px solid black;
	box-sizing: border-box;
}

.msg_content{
	font-size:20px;
	width:600px;
	height:500px;
/* 	border-radius: 5px; */
	box-sizing: border-box;
	font-weight: bold;	
}
.pagingBox{	width:600px; }
.write_btn{ width:30px;  background-color: #ff3d3d; height:30px;}

</style>
<script>
$(function(){
	$("#msgBox_detail").hide();
	let prev = -1;
	
	$(".message").click(function(){
		let msgNo = $(this).attr("value");
		console.log($(".msg_content"+msgNo).val());
		$("#msgBox_detail").val($(".msg_content"+msgNo).val());
		$("#msg_content").val($(".msg_content"+msgNo).val());
		if(msgNo == prev){ $("#msgBox_detail").toggle(); }
		else{ $("#msgBox_detail").show(); }
		prev = msgNo;
		$.ajax({
			type:"POST",
			url: "/msgRead",
			data: { 'msgNo' : msgNo },
			dataType:"json",
			success: function (data){
				if(data==1){
				// document.location.reload();
					$(".msgread"+msgNo).load(location.href+" .msgread"+msgNo);
				}
			},
			error: function(xhr,status,error){ alert("실패") }
		});

	});
	$(".del").click(function(){
		if(confirm("삭제하시겠습니까?")){
			let del = $(this).val();
			$.post({
				url: "msgDel",
				data:{'msgNo': del }
			}).done(function(data){
				document.location.reload();
			}).fail(function(xhr,status,error){
				alert("실패");
			});
		}
	});
});
</script>
<body>
   <%@include file="../top.jsp"%>
   <%@include file="../menu.jsp"%>
   <section>
         <div class="main">
            <div class="add1">광고1</div>
            	<div class="content">
				<!-- 이 곳을 수정하여 사용해주세요. -->
				<h1>쪽지함</h1>
				<div class="container">
					<div class="msgBox_board">
						<table class="table">
							<tr class="table-header">
								<th class="col-1">번호</th>
								<th class="col-2">보낸사람</th>
								<th class="col-3">제목</th>
								<th class="col-3">날짜</th>
								<th class="col-1">읽음</th>
								<th class="col-1">삭제</th>
							</tr>
							<c:forEach var="msg" items="${list }">
								<tr style="cursor: pointer;" class="message" value="${msg.message_no }">
									<td>${msg.msg_no }</td>
									<td>${msg.member_name }</td>
									<td class="title">${msg.message_title }</td>
									<td>${msg.message_time }</td>
									<td>
									<c:choose>
										<c:when test="${msg.read_or_not eq  'false' }"><b class="msgread${msg.message_no }" style="color:red;">x</b></c:when>
										<c:otherwise><b class="msgread${msg.message_no }" style="color:blue; text-align: center;">o</b></c:otherwise>
									</c:choose>
									</td>
									<td><button class="write_btn del" value="${msg.message_no }"><i class="xi-trash-o xi-x"></i></button></td>
									<input type="hidden" class="msg_content${msg.message_no }" value="${msg.message_content }" >
								</tr>
							</c:forEach>
						</table><br><br>
					<%@ include file="../board/CSJpaging.jsp" %>
						<br>
						<div class="searchForm">
							<form action="msgBox" method="get" id="searchForm">
								<select name="searchType">
									<option value="title">제목</option>
									<option value="writer"
										<c:if test='${searchType eq "writer"}'>selected</c:if>>글쓴이</option>
								</select> <input type="text" name="searchValue" value="${searchValue }">
								<button class="search_btn">검색</button>
							</form>
						</div>
					</div>
					<div class="msgBox_detail" id="msgBox_detail">
						<span class="msg_detail">쪽지 내용</span>
						<textarea style="border-radius: 0px 0px 20px 20px;" readonly="readonly" class="msg_content" id="msg_content"></textarea><br><br>
					</div>
				</div><!-- container -->
				
			</div><!-- content -->
            <div class="add2">광고2</div>
         </div>
   </section>
   <%@include file="../footer.jsp"%>
</body>
<script>
   $(function() {
      var error_msg = "${error_msg}";
      if(error_msg == "login_fail") alert("아이디와 비밀번호를 확인해주세요.");
      else if(error_msg == "not_login") alert("로그인이 필요한 서비스 입니다.");
   });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>