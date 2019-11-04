<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	$(document).ready(function() {

		//alert('list 접속');

	})

	function fn_write(bbs, notice) {
		$.ajax({
			type : 'POST',
			url : '/write.do',
			data : {
				bbsId : bbs,
				bbsNotice : notice
			},
			dataType : 'html',
			success : function(data) {
				$("#contents").html(data);
			},
			error : function(err) {
				console.log(err);
			}
		});
	}

	function fn_search(bbsId, page) {
		var option = $("#search_option option:checked").val();
		var notice = $("#search_notice option:checked").val();
		var word = $("#keyword").val();

		if (bbsId == null) {
			bbsId = "1";
		}
		if (page == null) {
			page = "1";
		}
		$.ajax({
			type : 'POST',
			url : '/list.do',
			data : {
				bbsId : bbsId,
				curPage : page,
				search_option : option,
				search_notice : notice,
				keyword : word
			},
			dataType : 'html',
			success : function(data) {
				$("#contents").html(data);
				removeHeader();

			},
			error : function(request, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
</script>
<!-- 게시판 이름 -->
<h2>${bbs.bbsName }게시판</h2>
<table style="border: 1px solid #ccc">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="15%" />
		<col width="20%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">글번호</th>
			<th scope="col">제목</th>
			<th scope="col">글쓴이</th>
			<th scope="col">조회수</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<!-- 공지사용(bbsList) 여부 -->
		<c:choose>
			<c:when test="${bbs.bbsNotice == 0 }"></c:when>
			<c:otherwise>
				<!-- 공지 리스트 -->
				<c:forEach items="${notice }" var="row">
					<c:if test="${empty row.delDate}">
						<tr>
							<th></th>
							<th><c:choose>
									<c:when test="${row.bbsRead == 0 }">${row.title }</c:when>
									<c:otherwise>
										<a href="javascript:void(0)" onClick="fn_Detail('${row.boardId }','${row.bbsId }')">${row.title }</a>
									</c:otherwise>
								</c:choose> <!-- 게시하고 하루동안 new --> <c:if test="${row.popnew <= 1 }"> new </c:if> <!-- 비밀글 선택시 --> <c:if test="${not empty row.secret }">비밀글</c:if></th>
							<td>${row.nickname }</td>
							<td>${row.hitcount }</td>
							<td><fmt:formatDate value="${row.writedate }" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<!-- 글 리스트 -->
		<c:forEach items="${map.list }" var="row">
			<!-- 삭제되지 않은 데이터만 -->
			<c:if test="${empty row.delDate}">
				<tr>
					<td>${row.boardId }</td>
					<td>
						<!-- 읽기기능(bbsList) 사용 여부 --> <c:choose>
							<c:when test="${row.bbsRead == 0 }">${row.title }</c:when>
							<c:otherwise>
								<a href="javascript:void(0)" onClick="fn_Detail('${row.boardId }','${row.bbsId }', '${map.pager.curPage}','${bbs.bbsDel }')">${row.title }</a>
							</c:otherwise>
						</c:choose> <!-- 게시하고 하루동안 new --> <c:if test="${row.popnew<= 1 }"> new </c:if> <!-- 비밀글 선택시 --> <c:if test="${row.secretCheck == 1}">비밀글</c:if>
					</td>
					<td>${row.nickname }</td>
					<td>${row.hitcount }</td>
					<td><fmt:formatDate value="${row.writedate }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:if>
		</c:forEach>
		<tr>
			<!-- 페이징 처리 -->
			<td colspan="5" align="center"><c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:void(0)" onclick="fn_search('${bbs.bbsId}','1')">[처음]</a>
				</c:if> <c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:void(0)" onclick="fn_search('${bbs.bbsId}','${map.pager.prevPage}')">[이전]</a>
				</c:if> <c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
					<c:choose>
						<c:when test="${num==map.pager.curPage}">
							<span style="color: red;">${num}</span>&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0)" onclick="fn_search('${bbs.bbsId}','${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach> <c:if test="${map.pager.curBlock <= map.pager.totBlock}">
					<a href="javascript:void(0)" onclick="fn_search('${bbs.bbsId}','${map.pager.nextPage}')">[다음]</a>
				</c:if> <c:if test="${map.pager.curPage <= map.pager.totPage}">
					<a href="javascript:void(0)" onclick="fn_search('${bbs.bbsId}','${map.pager.totPage}')">[끝]</a>
				</c:if></td>
		</tr>
		<tr>
			<td><!-- 검색 -->
				<form name="searchForm" method="post">
					<select id="search_notice" name="search_notice">
						<c:forEach var="sn" items="${SearchOption.SN }">
							<c:choose>
								<c:when test="${map.search_notice == sn.optionId }">
									<option value="${sn.optionId }" selected>${sn.optionName }</option>
								</c:when>
								<c:otherwise>
									<option value="${sn.optionId }">${sn.optionName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select> 
					<select id="search_option" name="search_option">
						<c:forEach var="so" items="${SearchOption.SO }">
							<c:choose>
								<c:when test="${map.search_option == so.optionId }">
									<option value="${so.optionId }" selected>${so.optionName }</option>
								</c:when>
								<c:otherwise>
									<option value="${so.optionId }">${so.optionName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
					<input id="keyword" name="keyword" value="${map.keyword }"> 
					<input type="button" onclick="fn_search('${param.bbsId }')" value="조회">
				</form>
			</td>
		</tr>
		<tr>
			<td>
				<!-- 글쓰기(bbsList)사용 여부 --> <c:choose>
					<c:when test="${map.list[0].bbsWrite == 0 }">
						<button>글쓰기x</button>
					</c:when>
					<c:otherwise>
						<button onClick="fn_write('${bbs.bbsId }','${bbs.bbsNotice}')">글쓰기</button>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</tbody>
</table>