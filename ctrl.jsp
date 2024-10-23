<%@page import="com.my.test.dto.Item"%>
<%@page import="com.my.test.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
    String contextPath = request.getContextPath();
%>

<% 
    String searchQuery = request.getParameter("searchQuery");
    List<UserDto> items;
    
    List<Item> allItems = new ArrayList<>();
    allItems.add(new Item(1, "basic"));
    allItems.add(new Item(2, "exist"));
    allItems.add(new Item(3, "items"));
    
    List<Item> searchResults = new ArrayList<>();
    searchResults.add(new Item(1, "Apple"));
    searchResults.add(new Item(2, "Green Apple"));
    searchResults.add(new Item(3, "Apple Pie"));

    // 검색어가 있을 경우 필터링
    if (searchQuery != null && !searchQuery.isEmpty()) {
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("isSearch", true);
    } else {
        request.setAttribute("searchResults", allItems); 
        request.setAttribute("isSearch", false);
    }
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
    dispatcher.forward(request, response);
    
%>


</body>
</html>
