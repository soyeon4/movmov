<%@page import="kr.co.movmov.vo.Review"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.mapper.ReviewMapper"%>
<%@page import="kr.co.movmov.vo.Movie"%>
<%@page import="kr.co.movmov.mapper.MovieMapper"%>
<%@page import="java.time.Year"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
   User user = (User) session.getAttribute("LOGIN_USER");   

   
   ReviewMapper reviewMapper = MybatisUtils.getMapper(ReviewMapper.class);
   List<Review> Reviews = reviewMapper.getReviewsByUserId(user.getId());   

   Calendar cal = Calendar.getInstance();
   Calendar today = Calendar.getInstance();
   
   int todayYear = cal.get(Calendar.YEAR);
   int todayMonth = cal.get(Calendar.MONTH);

   String yearPara = request.getParameter("year");
   String monthPara = request.getParameter("month");
   
   int year = (yearPara != null ? Integer.parseInt(yearPara) : cal.get(Calendar.YEAR));
   int month = (monthPara != null ? Integer.parseInt(monthPara) : cal.get(Calendar.MONTH));
   
   cal.set(Calendar.YEAR, year);
   cal.set(Calendar.MONTH, month);
   cal.set(Calendar.DATE, 1);
   
   
   int startWeek = cal.get(Calendar.DAY_OF_WEEK); // 날짜별로 일요일 - 1 , 월 = 2, 화 = 3, 수 = 4, 목 = 5, 금 = 6, 토 = 7
   int lastDay = cal.getActualMaximum(Calendar.DATE); // 현재 객체의 시점의 달의 마지막 날짜를 계산해준다.      
   
   int emptyBox = startWeek -1 + lastDay;
   
   
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>리뷰 캘린더 | McvMov</title>

  <!-- 스타일 -->
  <link rel="stylesheet" href="../../resources/style/mypage/watcha.css">
  <link rel="stylesheet" href="../../resources/style/mypage/calendar.css"> 
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <link rel="stylesheet" href="/movmov/resources/style/common/main.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

<section class="container">

   <form>
      <div>
         <a href="?year=<%=today.get(Calendar.YEAR)%>&month=<%=today.get(Calendar.MONTH)%>">현재 달로 이동</a>
      </div>
   </form>
   
  <div class="calendar-header">
    <a href="?year=<%=cal.get(Calendar.YEAR) %>&month=<%=cal.get(Calendar.MONTH) -1%>" class="month-btn">← 이전 달</a>
    <div class="month-title">
      <%=cal.get(Calendar.YEAR) %>년 <%=cal.get(Calendar.MONTH) +1 %>월 
    </div>
    <a href="?year=<%=cal.get(Calendar.YEAR) %>&month=<%=cal.get(Calendar.MONTH) + 1%>" class="month-btn">다음 달 →</a>
  </div>

  <div class="calendar">
    <!-- 요일 헤더 -->
    <div class="day">일</div>
    <div class="day">월</div>
    <div class="day">화</div>
    <div class="day">수</div>
    <div class="day">목</div>
    <div class="day">금</div>
    <div class="day">토</div>

<%
   if (startWeek >1) {
      for (int i = 1; i <= startWeek-1; i++) {
%>
    <div class="date-box"></div>
<% 
      }
   }
%>    
  
   
<%
   for (int i = 1; i <= lastDay; i++) {
%>   
    <div class="date-box"><%=i %> 
<%
      for (Review review : Reviews) {
         Calendar reviewData = Calendar.getInstance();
         reviewData.setTime(review.getCreatedDate());
                  
         
         if (reviewData.get(Calendar.DAY_OF_MONTH) == i && reviewData.get(Calendar.MONTH) == month) {
             if (review.getMovie() != null) {
                    String reviewposterData = review.getMovie().getPosterImagePath();

%>
      <a href="../movie/movie-detail.jsp?movieNo=<%=review.getMovie().getNo()%>"><img src="../../resources/images/movie/<%=reviewposterData %>" class="movie-poster"></a>
<%         
          } else {
                  // movie가 null일 경우, 디폴트 이미지나 처리할 로직을 추가할 수 있습니다.
                  System.out.println("Movie is null for review: " + review.getNo());
                  }
         }
        }
%>
   </div>
<% 
   }
%>
 

<%   
   if (emptyBox <= 35) {
   
   for (int i = 1; i <=35 - emptyBox; i++) {
%>   
    <div class="date-box"></div>
<%
      }
   } else if (emptyBox >= 36) {
      for (int i = 1; i <= 42 - emptyBox; i++) {
%>
    <div class="date-box"></div>
<%
      }
   }
%>
 </div>
</section>



<!-- 푸터 -->
<%@ include file="../common/footer.jsp" %>

</body>
</html>
