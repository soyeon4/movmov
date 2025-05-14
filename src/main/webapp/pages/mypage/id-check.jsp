<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.movmov.utils.MybatisUtils" %>
<%@ page import="kr.co.movmov.mapper.UserMapper" %>
<%@ page import="kr.co.movmov.vo.User" %>

<%
    String id = request.getParameter("id");

    // 응답 기본값 설정
    String result = "error";

    try {
        if (id != null && !id.trim().isEmpty()) {
            UserMapper userMapper = MybatisUtils.getMapper(UserMapper.class);
            User user = userMapper.getIdByUser(id);

            if (user == null) {
                result = "none";   // 사용 가능
            } else {
                result = "exists"; // 이미 존재
            }
        }
    } catch (Exception e) {
        result = "error";
        e.printStackTrace(); // 콘솔에 예외 로그 출력
    }

    out.print(result);
%>
