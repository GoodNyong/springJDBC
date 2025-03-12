<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userSearch.jsp</title>
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
		
		function formSearch() {
	    	let part = document.getElementById("part").value;
	    	let content = document.getElementById("content").value;
	    	
	    	if(content.trim() == "") {
	    		alert("검색할 내용을 입력하세요");
	    		document.getElementById("content").focus();
	    	}
	    	else {
	    		location.href = "${ctp}/user/userSearchPart?part="+part+"&content="+content;
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
	<div class="input-group">
		<div class="input-group-preppend">
			<select name="part" id="part">
				<option value="mid">아이디</option>
				<option value="name">성명</option>
				<option value="address">주소</option>
			</select>
		</div>
		<input type="text" name="mid" id="mid" placeholder="검색할 내용을 입력하세요" autofocus class="form-controll/">
		<div class="input-group-append">
			<input type="button" value="검색(완전일치)" onclick="formSearch()"	class="form-controll btn btn-success"/>
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/user/userMain';" class="btn btn-primary"/>
		</div>
	</div>
</div>
<p><br/></p>
</body>
</html>