<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
   .line{
      margin: 0px;
      padding: 0px;
      width:1920px;
      height:10px;
      background-image: url('/resources/line.png');
   }

   .menu_ul > li {
      font-weight:bold;
      color: #7e7e7e;
   }
</style>
<nav class="menu">
   <ul class="menu_ul">
      <li onclick="location.href='/index'" style="cursor: pointer;"><img src="/img/logo.png"></li>
      <li onclick="location.href='/myPage'" style="cursor: pointer;">꾸미기</li>
      <li onclick="location.href='/profile'" style="cursor: pointer;">회원정보 수정</li>
      <li onclick="location.href='/myPageChangePassword'" style="cursor: pointer;">비밀번호 변경</li>
      <li onclick="location.href='/loginLog'" style="cursor: pointer;">로그인 기록</li>
      <li onclick="location.href='/qnaboard'" style="cursor: pointer;">1:1 문의</li>
   </ul>
</nav>
<div class="line mb-5"></div>