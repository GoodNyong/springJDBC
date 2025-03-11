<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
</head>
<body>
	<div class="container">
		<h1>Hello world!</h1>
		<P>  The time on the server is ${serverTime}. </P>
		<hr>
		<div><a href="${ctp}/user/userMain" class="btn btn-success">회원관리</a></div>
	</div>
</body>
</html>
