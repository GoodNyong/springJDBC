<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userSearch2.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script type="text/javascript">
		'use strict';
		
		function Search() {
			let searchWord = document.getElementById("searchWord").value;
			let part = document.getElementById("part").value;
			if(searchWord.trim() == "") {
				alert("검색할 내용을 입력하세요");
				document.getElementById("searchWord").focus();
			} else {
				location.href = "${ctp}/user/userSearchPart?searchWord="+searchWord+"&part="+part;
			}
		}
		
				
		// 테이블 정렬 기능
		function sortTable(columnIndex) {
			let table = document.getElementById("userTable");
			let rows = Array.from(table.rows).slice(1);
			let ascending = table.getAttribute("data-order") === "asc";

			rows.sort((rowA, rowB) => { 
				let cellA = rowA.cells[columnIndex].textContent.trim();
				let cellB = rowB.cells[columnIndex].textContent.trim();

				let isNumber = !isNaN(cellA) && !isNaN(cellB);
				if (isNumber) {
					return ascending ? cellA - cellB : cellB - cellA;
				} else {
					return ascending ? cellA.localeCompare(cellB, 'ko-KR') : cellB.localeCompare(cellA, 'ko-KR');
				}
			});

			table.tBodies[0].append(...rows);
			table.setAttribute("data-order", ascending ? "desc" : "asc");
		}
		
	</script>
</head>
<body>
<p>${vos }<br/></p>
<div class="container"> 
	<h2>개별 회원 조회</h2>
	<hr>
	<c:if test="${!empty vo }">
		<table class="table table-bordered text-center border-secondary">
			<tr><th class="bg-secondary-subtle">아이디</th><td>${vo.mid }</td></tr>
			<tr><th class="bg-secondary-subtle">비밀번호</th><td>${vo.pwd }</td></tr>
			<tr><th class="bg-secondary-subtle">이름</th><td>${vo.name }</td></tr>
			<tr><th class="bg-secondary-subtle">나이</th><td>${vo.age }</td></tr>
			<tr><th class="bg-secondary-subtle">성별</th><td>${vo.gender }</td></tr>
			<tr><th class="bg-secondary-subtle">주소</th><td>${vo.address }</td></tr>
		</table>
		<hr>
	</c:if>
	<c:if test="${!empty vos }">
		<table id="userTable" class="table table-hover text-center" data-order="asc">
			<tr class="table-secondary">
				<th onclick="sortTable(0)" style="cursor: pointer;">번호</th>
			<th onclick="sortTable(1)" style="cursor: pointer;">아이디</th>
			<th>비밀번호</th>
			<th onclick="sortTable(3)" style="cursor: pointer;">성명</th>
			<th onclick="sortTable(4)" style="cursor: pointer;">나이</th>
			<th>성별</th>
			<th onclick="sortTable(6)" style="cursor: pointer;">주소</th>
			</tr>
			<c:forEach var="vo" items="${vos }" varStatus="st">
				<tr>
					<td>${vo.idx }</td>
					<td>${vo.mid }</td>
					<td>${vo.pwd }</td>
					<td>${vo.name }</td>
					<td>${vo.age }</td>
					<td>${vo.gender }</td>
					<td>${vo.address }</td>
				</tr>
			</c:forEach>
		</table>		
	</c:if>
	<div class="input-group">
		<select name="part" id="part">
			<option value="mid">아이디</option>
			<option value="name">성명</option>
			<option value="address">주소</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" placeholder="검색할 내용을 입력하세요" autofocus class="form-controll/">
		<div class="input-group-append">
			<input type="button" value="검색" onclick="Search()"	class="form-controll btn btn-success"/>
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/user/userMain';" class="btn btn-primary"/>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>