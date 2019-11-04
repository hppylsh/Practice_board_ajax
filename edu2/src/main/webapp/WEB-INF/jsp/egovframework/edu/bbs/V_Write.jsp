<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">
	$(document).ready(function() {

		$("#postEnd").datepicker({
			dateFormat : 'yy-mm-dd' //Input Display Format 변경
			, showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			, showMonthAfterYear : true //년도 먼저 나오고, 뒤에 월 표시
			, changeYear : true //콤보박스에서 년 선택 가능
			, changeMonth : true //콤보박스에서 월 선택 가능
			, minDate: "0" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		});
	})

	function Fn_boardSubmit() {
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

		// 공지여부
		var chkNotice = document.submitform.chkNotice
		if (chkNotice == null) {
			document.submitform.notice.value = '0';
		} else {
			if (chkNotice.checked) {
				document.submitform.notice.value = '1';
			} else {
				document.submitform.notice.value = '0';

			}
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
		var bbsId = $("#bbsId").val();
		var notice = $("#notice").val();
		var postEnd = $("#postEnd").val();
		var secretCheck = $("#secretCheck").val();

		var allData = {
			"title" : title,
			"content" : content,
			"bbsId" : bbsId,
			"notice" : notice,
			"postEnd" : postEnd,
			"secretCheck" : secretCheck
		};

		$.ajax({
			type : 'POST',
			url : '/insertwrite.do',
			data : allData,
			async : false,
			dataType : 'text',
			success : function(data) {
				//$("#contents").html(data);
				fnContent(bbsId)
			},
			error : function(err) {
				console.log(err);
			}
		});

		//submit
		//submitform.submit();

	}
</script>
<form id="submitform" name="submitform">
	<table class="write_form">
		<caption>게시글 작성</caption>
		<tbody>
			<tr>
				<!-- 제목 -->
				<th scope="row">제목</th>
				<td><input type="text" id="title" name="title"></input> <!-- 공지 여부 --> <c:choose>
						<c:when test="${param.bbsNotice == 0 }">
								공지불가
							</c:when>
						<c:otherwise>
							<input type='checkbox' id="chkNotice" name="chkNotice" />공지사항 
						</c:otherwise>
					</c:choose> <input type="hidden" id="notice" name="notice" /></td>
			</tr>
			<tr>
				<td>
					<!-- 게시기간 설정 --> 게시기간 <input type="text" id="postEnd" name="postEnd" /> <!-- 비밀글 설정 --> <input type='checkbox' id="chkSecret" name="chkSecret" />비밀글 <input type="hidden" id="secretCheck" name="secretCheck" />
				</td>
			</tr>
			<tr>
				<!-- 내용 -->
				<td colspan="2" class="view_text"><textarea rows="20" cols="100" title="내용" id="content" name="content"></textarea></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="bbsId" id="bbsId" value="${param.bbsId }">
	<button type="button" onclick="Fn_boardSubmit()">작성하기</button>
	<button type="reset">취소</button>
</form>
<input type="button" onclick="fnContent(' ${param.bbsId}')"  value="목록으로"/>