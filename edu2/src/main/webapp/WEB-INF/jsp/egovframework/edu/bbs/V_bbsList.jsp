<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<script type="text/javascript">
	$(document).ready(function() {
		
		//alert('게시판 관리 접속');
	})
	
	$("#insertBbsForm").click(function() {
		$.ajax({
			 type : 'POST'
			, url : '/insertBbsForm.do'
			, data : {}
			, dataType : 'html'
			, success : function(data) {
				$("#contents").html(data);
			}
			,error: function( err ){
			      console.log(err);
			}
		});
	});		
	
	function bbsmodifyform(num) {
		$.ajax({
			 type : 'POST'
			, url : '/bbsmodifyform.do'
			, data : { bbsId:num }
			, dataType : 'html'
			, success : function(data) {
				$("#contents").html(data);
			}
			,error: function( err ){
			      console.log(err);
			
			}
		});
	}
</script>
<h2>게시판 관리 목록</h2>
<table style="border: 1px solid #ccc">
	<colgroup>
		<col width="10%" />
		<col width="10%" />
		<col width="*" />
		<col width="15%" />
		<col width="20%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">게시판이름</th>
			<th scope="col">생성일</th>
			<th scope="col">읽기사용</th>
			<th scope="col">쓰기사용</th>
			<th scope="col">삭제사용</th>
			<th scope="col">공개사용</th>
			<th scope="col">공지사용</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="row">
			<tr>
				<td><a href="javascript:void(0);" onclick="bbsmodifyform(${row.bbsId })">${row.bbsName }</a></td>
				<td><fmt:formatDate value="${row.bbsRegDate }" pattern="yyyy-MM-dd" /></td>
				<td><c:choose>
						<c:when test="${row.bbsRead ==1}">사용</c:when>
						<c:otherwise>비사용</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${row.bbsWrite ==1}">사용</c:when>
						<c:otherwise>비사용</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${row.bbsDel ==1}">사용</c:when>
						<c:otherwise>비사용</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${row.bbsUse ==1}">사용</c:when>
						<c:otherwise>비사용</c:otherwise>
					</c:choose></td>
				<td><c:choose>
						<c:when test="${row.bbsNotice ==1}">사용</c:when>
						<c:otherwise>비사용</c:otherwise>
					</c:choose></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<br>
<button id="insertBbsForm">게시판 만들기</button>
