<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(document).ready(function() {

		// 기존 데이터의 notice 값이 1이면 chkNotice 체크 상태로 만들기
		var notice = "${map.detail.notice}";
		if (notice == '1') {
			document.submitform.chkNotice.checked = true;
		}

		// 기존 데이터의 secretCheck 값이 1이면 chkSecret 체크 상태로 만들기
		var secretCheck = "${map.detail.secretCheck}";
		if (secretCheck == '1') {
			document.submitform.chkSecret.checked = true;
		}

		$("#postEnd").datepicker({
			dateFormat : 'yy-mm-dd' //Input Display Format 변경
			, showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			, showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
			, changeYear : true //콤보박스에서 년 선택 가능
			, changeMonth : true //콤보박스에서 월 선택 가능
			, minDate: "0" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		});

	})

	function Fn_modifySubmit(board, bbs) {
		// 제목과 내용 가져오기
		var content = document.getElementById("content").value;
		var title = document.getElementById("title").value;

		if (title == "") {
			alert("제목을 입력하세요");
			document.getElementById("title").focus();
			return false;

		} else if (content == "") {
			alert("내용을 입력하세요");
			document.getElementById("content").focus();
			return false;
		}

		// 공지 여부 chkNotice 값 가져와서
		var chkNotice = document.submitform.chkNotice

		//chkNotice 체크에 따라 notice value 입력
		if (chkNotice.checked) {
			document.submitform.notice.value = '1';
		} else {
			document.submitform.notice.value = '0';

		}

		// 비밀 글 여부
		var chkSecret = document.submitform.chkSecret
		if (chkSecret.checked) {
			document.submitform.secretCheck.value = '1';
		} else {
			document.submitform.secretCheck.value = '0';
		}

		// 정보를 갖고 온다.
		var title = $("#title").val();
		var content = $("#content").val();
		var notice = $("#notice").val();
		var postEnd = $("#postEnd").val();
		var secretCheck = $("#secretCheck").val();

		var data = {
			"title" : title,
			"content" : content,
			"notice" : notice,
			"postEnd" : postEnd,
			"secretCheck" : secretCheck,
			"boardId" : board
		};

		$.ajax({
			type : 'POST',
			url : '/modify.do',
			data : data,
			async : false,
			dataType : "text",
			success : function(data) {
				//$("#contents").html(data);
				fn_Detail(board, bbs);
			},
			error : function(request, status, error) {
				alert("code = " + request.status + " message = "
						+ request.responseText + " error = " + error);
			}
		});

		//submit
		//submitform.submit();

	}
</script>
<form id="submitform" name="submitform">
	<table class="board_modify">
		<caption>게시글 수정</caption>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td><input type="text" id="title" name="title" value="${map.detail.title }"></input> <!-- 공지 기능(bbsList에서 설정가능) --> <c:choose>
						<c:when test="${bbs.bbsNotice == 0 }">
							공지불가
						</c:when>
						<c:otherwise>
							<input type='checkbox' id="chkNotice" name="chkNotice" />공지사항 
							<input type="hidden" id="notice" name="notice" /></td>
				</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<!-- 게시기간 -->
				<fmt:formatDate value="${map.detail.postEnd}" pattern="yyyy-MM-dd" var="postend" />
				<td>게시기간 <input type="text" id="postEnd" name="postEnd" value="${postend }" /> <!-- 비밀글 기능 --> <input type='checkbox' id="chkSecret" name="chkSecret" />비밀글 <input type="hidden" id="secretCheck" name="secretCheck" />
				</td>
			</tr>
			<tr>
				<!-- 내용 -->
				<td colspan="2" class="view_text"><textarea rows="20" cols="100" title="내용" id="content" name="content">${map.detail.content }</textarea></td>
			</tr>
		</tbody>
	</table>
	<input type="button" onclick="Fn_modifySubmit('${param.boardId }','${param.bbsId}')" value="수정하기" />
</form>
<button onclick="fnContent('${param.bbsId }')">목록으로</button>