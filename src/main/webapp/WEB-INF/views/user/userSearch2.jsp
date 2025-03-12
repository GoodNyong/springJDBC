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
		
		function idSearch(flag) {
			let mid = document.getElementById("mid").value;
			if(mid.trim() == ""){
				alert("검색할 아이디를 입력하세요");
				document.getElementById("mid").focus();
			} else{
				if(flag =='s') location.href = "${ctp}/user/userSearchList?mid="+mid;
				else location.href = "${ctp}/user/userSearchListOk?mid="+mid;
			}
		}
		
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
					return ascending ? cellA.localeCompare(cellB, 'ko') : cellB.localeCompare(cellA, 'ko');
				}
			});

			table.tBodies[0].append(...rows);
			table.setAttribute("data-order", ascending ? "desc" : "asc");
		}
		
	</script>
</head>
<body>
<p><br/></p>
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
	</c:if>
	<div class="input-group">
		<input type="text" name="mid" id="mid" placeholder="검색할 아이디를 입력하세요" autofocus class="form-controll/">
		<div class="input-group-append">
			<input type="button" value="아이디검색(완전일치)" onclick="idSearch('s')"	class="form-controll btn btn-success"/>
			<input type="button" value="아이디검색(부분일치)" onclick="idSearch('l')"	class="form-controll btn btn-info"/>
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/user/userMain';" class="btn btn-primary"/>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>