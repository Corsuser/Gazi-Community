<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판II</title>
<link rel="icon" href="/img/Gazi_shortCut.png" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="/css/HJHBoard.css?v=20230329_1">
</head>
<style>
h6 {
	display: inline-block;
	width: 20px;
	height: 20px;
	background-color: red;
	line-height: 20px;
	text-align: center;
	color: white;
	border-radius: 5px;
}

.board_tag {
	display: inline-block;
	width: 50px;
	height: 30px;
	background-color: #0080f0;
	line-height: 30px;
	color: white;
	border-radius: 5px;
	font-weight: bold;
}

.noResult {
	width: 100%;
	height: 400px;
	line-height: 400px;
	font-size: 24px;
}

.LayerList {
	list-style: none;
	margin: 0;
	padding: 0;
}

.LayerListItem {
	list-style: none;
	height: 33px;
	line-height: 33px;
}

.LayerListItem:hover {
	background-color: #c0c0c0;
}

.boardWriter:hover {
	cursor: pointer;
}
</style>
<script>
function detail(bno){
	location.href="/csjRead?bno="+bno;
}
function sendMessageTo(receiver){
	window.open("/message?receiver="+receiver,'쪽지', 'width=510px,height=450px,scrollbars=yes');
}
function sendPointTo(receiver){
	window.open("/sendPoint?receiver="+receiver, '쪽지', 'width=510px,height=450px,scrollbars=yes');
}
function nickNameClick(name,event){
	var layer =  document.getElementById("nickNameLayer");
	if(layer.style.display == "none") {
		layer.style.display = "block";
	}
	var y = event.clientY;
	var x = event.clientX;
	layer.style.color = "black";
	layer.style.width = "125px";
	layer.style.height = "100px";
	layer.style.border = "1px solid black";
	layer.style.backgroundColor = "white";
	layer.style.position = "absolute";
	layer.style.top = window.scrollY+y;
	layer.style.left = window.scrollX+x;
	layer.style.zIndex = 9999;
	
	layer.innerHTML = "<ul class='LayerList'>";
	layer.innerHTML += "<li class='LayerListItem' onclick='sendMessageTo(\""+name+"\")'>쪽지보내기</li>";
	layer.innerHTML += "<li class='LayerListItem' onclick='sendPointTo(\""+name+"\")'>포인트보내기</li>";
	layer.innerHTML += "<li class='LayerListItem' onclick='closeLayer()'>닫기</li>";
	layer.innerHTML += "</ul>";
	
	
}
function closeLayer(){
	var layer = document.getElementById("nickNameLayer");
	if(layer.style.display != "none"){
		layer.style.display = "none";
		document.body.onclick = "";
	}
}
</script>

<div id="nickNameLayer"></div>
<body>
	<%@include file="../top.jsp"%>
	<%@include file="../menu.jsp"%>
	<div class="main">
		<div class="add1">광고1</div>
		<div class="content">
			<h1 onclick="location.href='csjboard'">자 유 게 시 판 II</h1>
			<div class="container">
				<table class="table">
					<tr class="table-header">
						<th class="col-1">구분</th>
						<th class="col-1">번호</th>
						<th class="col-6">제목</th>
						<th class="col-1">글쓴이</th>
						<th class="col-1">날짜</th>
						<th class="col-1">조회수</th>
						<th class="col-1">좋아요</th>
					</tr>
					<c:forEach items="${list }" var="b">
						<tr>
							<td><span class="board_tag">${b.tag_name }</span></td>
							<td>${b.bno }</td>
							<td onclick="detail(${b.board_no})" class="text-truncate title"
								style="max-width: 1px;">${b.board_title }<c:if
									test="${b.isFile gt 0 }">
									<i class="xi-file-image-o"></i>
								</c:if> <c:if test="${b.comment_cnt ne 0 }">
									<h6>${b.comment_cnt}</h6>
								</c:if></td>
							<td><span class="text-truncate boardWriter"
								style="max-width: 1px;"
								<c:if test="${sessionScope.member_name ne null }">
										onclick="nickNameClick('${b.member_name }',event)"
										</c:if>>${b.member_name }</span></td>
							<td>${b.board_date }</td>
							<td>${b.board_read }</td>
							<td>${b.board_like }</td>
						</tr>
					</c:forEach>
				</table>
				<c:if test="${pageInfo.size lt 1 }">
					<div class="noResult">데이터가 없습니다</div>
				</c:if>
				<br>
				<br>
				<div class="write">
					<c:if test="${sessionScope.id eq 'admin' }">
						<button class="write_btn"
							style="background-color: #ff3d3d; margin-right: 10px;"
							onclick="location.href='/admin'">관리자</button>
					</c:if>
					<c:if test="${sessionScope.member_name ne null }">
						<button class="write_btn" onclick="location.href='/csjWrite'">글쓰기</button>
					</c:if>
				</div>
				<br>
				<%@ include file="CSJpaging.jsp"%>
				<br>
				<div class="searchForm">
					<form action="csjboard" method="get" id="searchForm">
						<select name="searchType">
							<option value="title">제목</option>
							<option value="writer"
								<c:if test='${searchType eq "writer"}'>selected</c:if>>글쓴이</option>
						</select> <input type="text" name="searchValue" value="${searchValue }">
						<button class="search_btn">검색</button>
					</form>
				</div>

			</div>
		</div>
		<div class="add2">광고2</div>
	</div>
	<%@include file="../footer.jsp"%>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</html>
