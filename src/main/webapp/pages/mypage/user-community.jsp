<%@page import="kr.co.movmov.utils.Pagination"%>
<%@page import="kr.co.movmov.utils.StringUtils"%>
<%@page import="kr.co.movmov.mapper.PostMapper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.movmov.vo.Post" %>

<%
	User user = (User) session.getAttribute("LOGIN_USER");
	String userId = user.getId();
    
	
    PostMapper postMapper = MybatisUtils.getMapper(PostMapper.class);
   	
   	
   	int pageNo = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int rows = 3;
   	int totalRows = postMapper.getTotalPostRowsByUserId(userId);
 
   	Pagination pagination = new Pagination(pageNo, totalRows, rows);
   	
   	Map<String, Object>  condition = new HashMap<>();

   	condition.put("offset", pagination.getOffset());
    condition.put("rows", pagination.getRows());
	condition.put("userId", userId);
   	
	List<Post> postData = postMapper.getPosts(condition);
     	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>나의 게시글 | MovMov</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="/movmov/resources/style/common/main.css">
</head>
<body class="bg-gray-100 text-gray-900">

  <%@ include file="../common/header.jsp" %>

  <section class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-bold mb-6">📚 나의 게시글</h2>

    <div class="bg-white shadow-md rounded-lg overflow-hidden">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-100">
          <tr>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700">제목</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700">작성일자</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700">조회수</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700">수정일</th>
            <th class="px-6 py-3 text-left text-sm font-semibold text-gray-700">머리말</th>
          </tr>
        </thead>
<%
	for (Post postDatas : postData) {
%>        
        <tbody class="bg-white divide-y divide-gray-200">
          <tr>
            <td class="px-6 py-4 whitespace-nowrap">
              <a href="#" class="text-blue-600 hover:underline"><%=postDatas.getTitle() %></a>
            </td>
            <td class="px-6 py-4 text-sm text-gray-600"><%=StringUtils.detailDate(postDatas.getCreatedDate())  %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%=postDatas.getViewCount() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%=StringUtils.detailDate(postDatas.getUpdatedDate()) %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%=postDatas.getHeader().getName() %></td>
          </tr>
<%
	}
%>          
        </tbody>
      </table>
    </div>
  </section>
  
  <!-- 페이지네이션 -->
	<div
		class="pagination mt-6 flex justify-center items-center space-x-2 text-sm">

<%
		if (!pagination.isFirst()) {
%>
		<a href="#"
			class="page-link px-3 py-1 border rounded hover:bg-gray-200"
			data-page-no="<%=pagination.getPrevPage()%>">이전</a>
<%
		}
		for (int i = pagination.getBeginPage(); i <= pagination.getEndPage(); i++) {
		if (i == pagination.getCurrentPage()) {
%>
		<span
			class="page-link px-3 py-1 border rounded bg-pink-500 text-white font-bold"><%=i%></span>
<%
		} else {
%>
		<a href="#"
			class="page-link px-3 py-1 border rounded hover:bg-gray-200"
			data-page-no="<%=i%>"><%=i%></a>
<%
		}
		}
%>

<%
		if (!pagination.isLast()) {
%>
		<a href="#"
			class="page-link px-3 py-1 border rounded hover:bg-gray-200"
			data-page-no="<%=pagination.getNextPage()%>">다음</a>
<%
	}
%>
	</div>

	<!-- 페이지 이동용 form -->
	<form id="form-page" method="get" action="user-community.jsp">
		<input type="hidden" name="page" value="<%=pagination.getCurrentPage()%>">
	</form>

	<script type="text/javascript">
		$(".page-link").click(function() {
			let pageNo = $(this).data("page-no"); 
			$("input[name=page]").val(pageNo);
			$("#form-page").submit(); 
			return false;
		});
	</script>

	<%@ include file="../common/footer.jsp" %>
</body>
</html>
