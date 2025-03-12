<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script type="text/javascript">
		'use strict';
		
		function delCheck(idx) {
			let ans = confirm("선택하신 회원을 삭제하시겠습니까?");
			if(!ans) return false;
			else location.href = "${ctp}/user/userDeleteOk?idx="+idx;
		}
		
		// 테이블 정렬 기능
		function sortTable(columnIndex) {
			let table = document.getElementById("userTable");
			let rows = Array.from(table.rows).slice(1); // 첫 번째 행(헤더) 제외
			let ascending = table.getAttribute("data-order") === "asc";

			rows.sort((rowA, rowB) => {
				let cellA = rowA.cells[columnIndex].textContent.trim();
				let cellB = rowB.cells[columnIndex].textContent.trim();

				// 숫자 여부 확인 후 비교
				let isNumber = !isNaN(cellA) && !isNaN(cellB);
				if (isNumber) {
					return ascending ? cellA - cellB : cellB - cellA;
				} else {
					// 한글 정렬을 위해 localeCompare 사용
					return ascending ? cellA.localeCompare(cellB, 'ko-KR') : cellB.localeCompare(cellA, 'ko-KR');
				}
			});

			table.tBodies[0].append(...rows);
			table.setAttribute("data-order", ascending ? "desc" : "asc");
		}
	</script>
</head>
<body>
<p><%-- ${vos } --%><br/></p>
<div class="container"> 
	<h2>회원 전체 리스트</h2>
	<table id="userTable" class="table table-hover text-center" data-order="asc">
		<tr class="table-secondary">
			<th onclick="sortTable(0)" style="cursor: pointer;">번호</th>
			<th onclick="sortTable(1)" style="cursor: pointer;">아이디</th>
			<th>비밀번호</th>
			<th onclick="sortTable(2)" style="cursor: pointer;">성명</th>
			<th onclick="sortTable(3)" style="cursor: pointer;">나이</th>
			<th>성별</th>
			<th onclick="sortTable(4)" style="cursor: pointer;">주소</th>
			<th>비고</th>
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
				<td><a href="${ctp}/user/userUpdate?idx=${vo.idx}" class="badge bg-warning text-decoration-none">수정</a>/<a href="javascript:delCheck(${vo.idx})" class="badge bg-danger text-decoration-none">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<div><a href="${ctp }/user/userMain" class="btn btn-warning">돌아가기</a></div>
</div>
<p><br/></p>
</body>
</html>