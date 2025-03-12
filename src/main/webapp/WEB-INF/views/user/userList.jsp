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
			let ascending = table.getAttribute("data-order") === "asc"; // 현재 테이블 정렬 상태 확인 및 오름차순 여부 판단

			rows.sort((rowA, rowB) => { 
				// .sort() : js의 메소드로, 배열을 오름/내림차순으로 정렬함.
				// 배열의 요소 두개를 비교하여 정렬 기준을 결정
				// 선택한 열(columnIndex)에 해당하는 셀의 텍스트값 삽입
				let cellA = rowA.cells[columnIndex].textContent.trim(); // 공백제거
				let cellB = rowB.cells[columnIndex].textContent.trim();

				// 숫자 여부 확인 후 비교
				let isNumber = !isNaN(cellA) && !isNaN(cellB);
				if (isNumber) { // ascending === true면 오름차순
					return ascending ? cellA - cellB : cellB - cellA;
				} else {
					// 한글 정렬을 위해 localeCompare 사용, (한글->영어대문자->영어소문자->숫자)
					return ascending ? cellA.localeCompare(cellB, 'ko-KR') : cellB.localeCompare(cellA, 'ko-KR');
				} // js의 문자열 비교 내장 메소드, 국제화를 고려함, 반환값: -1(앞의 문자열이 뒤 문자열보다 앞), 0, 1
			});

			table.tBodies[0].append(...rows); // 정렬된 행을 다시 테이블에 적용
			// rows에는 tr요소들이 저장됨, "..."은 "전개 연산자"로 배열을 펼처서 개별 tr요소로 추가
			table.setAttribute("data-order", ascending ? "desc" : "asc"); // 정렬 방향 업데이트
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
			<th onclick="sortTable(3)" style="cursor: pointer;">성명</th>
			<th onclick="sortTable(4)" style="cursor: pointer;">나이</th>
			<th>성별</th>
			<th onclick="sortTable(6)" style="cursor: pointer;">주소</th>
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