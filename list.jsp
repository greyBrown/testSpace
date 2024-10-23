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

<form action="/user/ctrl.jsp" method="post">
    <input type="text" name="searchQuery" placeholder="검색어 입력">
    <input type="submit" value="검색">
</form>

<% 
    // 기본 아이템 리스트 초기화
    List<Item> allItems = new ArrayList<>();
    allItems.add(new Item(1, "basic"));
    allItems.add(new Item(2, "exist"));
    allItems.add(new Item(3, "items"));

    // request에서 검색 결과와 isSearch 상태를 가져옴
    List<Item> searchResults = (List<Item>) request.getAttribute("searchResults");
    Boolean isSearch = (Boolean) request.getAttribute("isSearch");

    // 검색 결과가 null이거나 비어 있으면 기본 아이템 리스트 사용
    if (searchResults == null || searchResults.isEmpty()) {
        searchResults = allItems; // 기본 아이템 리스트로 설정
        isSearch = false; // 검색 상태를 false로 설정
    }
%>

<h2>검색 결과</h2>
<h2>검색 결과</h2>
<ul>

<div>list 화면입니다</div>
    <% if (isSearch && searchResults != null && !searchResults.isEmpty()) { %>
        <% for (Item item : searchResults) { %>
            <li><%= item.getId() %> - <%= item.getName() %></li> <!-- 이름도 출력하도록 수정 -->
        <% } %>
    <% } else if (allItems != null) { %>
        <% for (Item item : allItems) { %>
            <li><%= item.getId() %> - <%= item.getName() %></li> <!-- 이름도 출력하도록 수정 -->
        <% } %>
    <% } else { %>
        <li>결과가 없습니다.</li> <!-- 결과가 없을 경우 처리 -->
    <% } %>
</ul>

</body>
</html>
