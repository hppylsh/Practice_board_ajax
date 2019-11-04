<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">

function fn_modifyform(board,bbs) {
	$.ajax({
		type : 'POST',
		url : '/modifyform.do',
		data : {boardId:board, bbsId:bbs},
		dataType : 'html',
		success : function(data) {
			$("#contents").html(data);
		},
		error : function(err) {
			console.log(err);
		}
	});
}


function fn_delete(board,bbs,page) {
	$.ajax({
		type : 'POST',
		url : '/delete.do',
		data : { boardId:board, bbsId:bbs },
		dataType : 'html',
		success : function(data) {
			fnContent(bbs,page);
		},
		error : function(err) {
			console.log(err);
		}
	});
}

</script>


<table class="board_detail">
	<h2>${map.bbsName } 게시판</h2>
	<tbody>
		<tr>
			<th scope="row">글 번호</th>
			<td>${map.boardId }</td>
		</tr>
		<tr>
			<th scope="row">조회수</th>
			<td>${map.hitcount }</td>
		</tr>
		<tr>
			<th scope="row">작성자</th>
			<td>${map.nickname }</td>
		</tr>
		<tr>

			<th scope="row">작성시간</th>
			<td>${map.writedate }</td>

		</tr>
		<tr>
			<th scope="row">제목</th>
			<td colspan="3">${map.title }</td>
		</tr>
		<tr>
			<td colspan="4">
				<!-- 비밀글 여부 --> <c:choose>
					<c:when test="${map.secretCheck == 1 }">
						<c:if test="${map.memberId == 1 }">
										${map.content }
								</c:if>
						<!-- 글쓴 사람과 읽는 사람이 다른 경우 -->
						<c:if test="${map.memberId == 3 }">
										비밀글입니다.
								</c:if>
					</c:when>
					<c:otherwise>
								${map.content }
							</c:otherwise>
				</c:choose> <!-- 글쓴 사람과 읽는 사람이 같은 경우 (memberId 1번이 이용자라고 생각할 때) -->

			</td>
		</tr>
		<tr>
			<td>
				<!-- 이전글 / 다음글 --> <c:choose>
					<c:when test="${empty lead.afterId }">
						다음글이 없습니다.
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fn_Detail('${lead.afterId }','${param.bbsId }')">[다음글]
							${lead.afterId } ${lead.afterName }</a>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td><c:choose>
					<c:when test="${empty leg.beforeId }">
						이전글이 없습니다.
					</c:when>
					<c:otherwise>
							<a href="javascript:void(0);" onclick="fn_Detail('${leg.beforeId }','${param.bbsId }')">[이전글]
							${leg.beforeId } ${leg.beforeName }</a>
					</c:otherwise>
				</c:choose></td>
		</tr>
	</tbody>
</table>
<button onclick="fnContent('${param.bbsId }','${param.curPage }')">목록으로</button>
<button onclick="fn_modifyform('${param.boardId }','${param.bbsId }')">수정하기</button>
<c:choose>
	<c:when test="${param.bbsDel == 0 }">
		<button>삭제불가</button>
	</c:when>
	<c:otherwise>
		<button onclick="fn_delete('${map.boardId }','${param.bbsId }','${param.curPage }')">삭제하기</button>
	</c:otherwise>
</c:choose>