<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
   <meta charset="UTF-8">
   <title>스토어</title>
   <link rel="icon" href="/img/Gazi_shortCut.png" />
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
   <link rel="stylesheet" href="/css/layout.css">
</head>
<script>
   $(function() {

      var apply = "${apply}";
      if(apply == "success") {
         alert("아이콘 등록 신청완료");
      } else if(apply == "fail") {
         alert("아이콘 등록 실패");
      }

      $("#icon_file").change(function() { // 이미지 미리보기
         const icon_file = this.files[0];
         const reader = new FileReader();
         reader.onload = function(event) {
            const img = new Image();
            img.onload = function () {
               if(img.width > 45 || img.height > 45) {
                  alert("45x45 픽셀을 넘어갑니다.\n이미지 크기를 확인해주세요.");
                  return false;
               }
               $(".upload-name").val(icon_file.name);
               $("#previewText").css("display", "none");
               $("#previewImg").css({"width" : "45px", "height" : "45px", "display" : "inline-block", "padding-top" : "3px", "box-sizing" : "border-box"});
               $("#previewImg").attr("src", event.target.result);
            }
            img.src = event.target.result;
         };
         reader.readAsDataURL(icon_file);
      });

      $("#icon_count").change(function() {
         let sell_cnt = $(this).val();
         if(sell_cnt > 999) {
            alert("최대 판매 수량은 999개 입니다.");
            $(this).val(999);
         }
      });

      $("#icon_price").change(function() {
         let price = $(this).val();
         if(price > 100000) {
            alert("가격은 최대 100,000 입니다.");
            $(this).val(100000);
         }
      });

      $("#btn-submit").click(function() {
         if($("#icon_file").val() == "" || $("#icon_file").val() == null) {
            alert("아이콘 이미지를 등록해주세요.");
            return false;
         }

         if($("#icon_name").val() == "" || $("#icon_name").val() == null) {
            alert("아이콘 이름을 입력하세요.");
            return false;
         }

         if($("#icon_count").val() == "" || $("#icon_count").val() == null) {
            alert("판매 갯수를 입력하세요.");
            return false;
         }

         if($("#icon_price").val() == "" || $("#icon_price").val() == null) {
            alert("가격을 입력하세요.");
            return false;
         }
         $(".icon-form").submit();
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
               <form class="icon-form" action="/iconApply" method="post" enctype="multipart/form-data">
                  <div style="padding-top: 100px;">
                     <div style="margin: 0 auto; width: 700px; height: 450px; border: 1px solid #ccc; border-radius: 10px;">
                        <div class="mt-4" style="width: 700px; height: 50px; font-size: 30px;">아이콘 신청</div>
                        <!-- 파일 등록 -->
                        <div class="filebox mt-3" style="margin: 0 auto; width: 610px; height: 50px;">
                           <!-- 이미지 미리보기 -->
                           <div style="width: 50px; height: 50px; border-radius: 5px; float: left;">
                              <span id="previewText" style="text-align: center;">미리<br>보기</span>
                              <img id="previewImg" style="display: none;"/>
                           </div>
                           <input class="form-control upload-name" style="width: 420px; height: 50px; margin-left: 10px; float: left;" value="이미지의 크기는 45x45 제한 됩니다." placeholder="이미지의 크기는 45x45 제한 됩니다.">
                           <label class="btn btn-primary" for="icon_file" style="width: 120px; height: 50px; line-height: 40px; margin-left: 10px; float: left;">아이콘 등록</label>
                           <input type="file" id="icon_file" name="icon_file" accept="image/*" style="display: none;">
                        </div>
                        <!-- 아이콘 이름 -->
                        <div class="filebox mt-3" style="margin: 0 auto; width: 610px; height: 50px;">
                           <label class="badge bg-secondary" for="icon_name" style="width: 100px; height: 50px; line-height: 40px; font-size: 16px; float: left;">아이콘 이름</label>
                           <input class="form-control" type="text" id="icon_name" name="icon_name" style="width: 500px; margin-left: 10px; height: 50px; float: left;" maxlength="10" placeholder="아이콘 이름을 입력해주세요.">
                        </div>
                        <!-- 수량 -->
                        <div class="filebox mt-3" style="margin: 0 auto; width: 610px; height: 50px;">
                           <label class="badge bg-secondary" for="icon_count" style="width: 100px; height: 50px; line-height: 40px; font-size: 16px; float: left;">수량</label>
                           <input class="form-control" type="number" id="icon_count" name="icon_count" style="width: 500px; margin-left: 10px; height: 50px; float: left;" placeholder="아이콘 수량을 입력해주세요.">
                        </div>
                        <!-- 가격 -->
                        <div class="filebox mt-3" style="margin: 0 auto; width: 610px; height: 50px;">
                           <label class="badge bg-secondary" for="icon_price" style="width: 100px; height: 50px; line-height: 40px; font-size: 16px; float: left;">가격</label>
                           <input class="form-control" type="number" id="icon_price" name="icon_price" style="width: 500px; margin-left: 10px; height: 50px; float: left;" placeholder="아이콘 가격을 입력해주세요.">
                        </div>
                        <button class="mt-4 btn btn-primary" type="button" id="btn-submit" style="width: 610px; height: 50px; line-height: 40px;">등록 신청</button>
                     </div>
                  </div>
               </form>
            </div>
            <div class="add2">광고2</div>
         </div>
   </section>
   <%@include file="../footer.jsp"%>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</html>
