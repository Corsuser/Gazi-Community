<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
   <meta charset="UTF-8">
   <title>레벨 등급표</title>
   <link rel="icon" href="/img/Gazi_shortCut.png" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <link rel="stylesheet" href="/css/layout.css">
</head>
<body>
   <%@include file="../top.jsp"%>
   <%@include file="../menu.jsp"%>
   <section>
         <div class="main">
            <div class="add1">광고1</div>
            <div class="content">
               <div style="margin: 0 auto; width: 1050px;">
                  <table class="table" style="width: 500px; float: left; text-align: center;">
                     <thead style="background-color: #CCC;">
                        <th>레벨</th>
                        <th style="border-left: 1px solid black;">기준 포인트</th>
                     </thead>
                     <c:forEach items="${list}" var="level" step="1" begin="0" end="24">
                        <tbody>
                           <td>${level.member_level}</td>
                           <td style="border-left: 1px solid black;">${level.level_to_point}</td>
                        </tbody>
                     </c:forEach>
                  </table>
                  <table class="table" style="width: 500px; float: left; margin-left: 50px; text-align: center;">
                     <thead style="background-color: #CCC;">
                     <th>레벨</th>
                     <th style="border-left: 1px solid black;">기준 포인트</th>
                     </thead>
                     <c:forEach items="${list}" var="level" step="1" begin="25">
                        <tbody>
                           <td>${level.member_level}</td>
                           <td style="border-left: 1px solid black;">${level.level_to_point}</td>
                        </tbody>
                     </c:forEach>
                  </table>
               </div>
            </div>
            <div class="add2">광고2</div>
         </div>
   </section>
   <%@include file="../footer.jsp"%>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>
