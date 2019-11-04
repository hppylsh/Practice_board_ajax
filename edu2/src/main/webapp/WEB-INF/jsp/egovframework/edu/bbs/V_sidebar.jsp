<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#jb-sidebar {
	width: 260px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
	border: 1px solid #bcbcbc;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		//alert("사이드바");
	})
</script>

<div id="jb-sidebar">
	<h2>게시판 목록</h2>
	<ul>
		<c:forEach items="${sidebar }" var="bbs">
			<!-- 공개(bbsList) 여부 -->
			<c:if test="${bbs.bbsUse == 1 }">
				<li><a href="javascript:void(0);"
					onclick="fnContent('${bbs.bbsId}')"> ${bbs.bbsName }</a></li>
			</c:if>
		</c:forEach>
	</ul>
</div>