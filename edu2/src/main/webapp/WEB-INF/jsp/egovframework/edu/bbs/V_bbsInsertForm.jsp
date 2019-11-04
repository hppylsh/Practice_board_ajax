<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">
	$(document).ready(function() {

		//alert('게시판 관리 글쓰기 접속');

		$("#insertBbs").click(function() {
			$.ajax({
				type : 'POST',
				url : '/insertBbs.do',
				data : $("[name=submitform]").serialize(),
				dataType : 'html',
				success : function(data) {
					$("#contents").html(data);
					$('#sidbar').remove();
					side();

				},
				error : function(err) {
					console.log(err);

				}
			});
		});

		$("#bbslist").click(function() {
			$.ajax({
				type : 'POST',
				url : '/bbslist.do',
				data : {},
				dataType : 'html',
				success : function(data) {
					$("#contents").html(data);

				},
				error : function(err) {
					console.log(err);
				}
			});

		});
	})
</script>


<form id="submitform" name="submitform">
	<table class="write_form">
		<caption>게시글 작성</caption>

		<tr>
			<td>게시판 이름</td>
			<td><input id="bbsName" name="bbsName"></td>
		</tr>
		<tr>
			<td>읽기사용</td>
			<td><input type="radio" name="bbsRead" value="0" /> 비사용 <input
				type="radio" name="bbsRead" value="1" checked="checked" /> 사용</td>
		</tr>
		<tr>
			<td>쓰기사용</td>
			<td><input type="radio" name="bbsWrite" value="0" /> 비사용 <input
				type="radio" name="bbsWrite" value="1" checked="checked" /> 사용</td>
		</tr>
		<tr>
			<td>삭제사용</td>
			<td><input type="radio" name="bbsDel" value="0" /> 비사용 <input
				type="radio" name="bbsDel" value="1" checked="checked" /> 사용</td>
		</tr>
		<tr>
			<td>공개사용</td>
			<td><input type="radio" name="bbsUse" value="0" /> 비사용 <input
				type="radio" name="bbsUse" value="1" checked="checked" /> 사용</td>
		</tr>
		<tr>
			<td>공지사용</td>
			<td><input type="radio" name="bbsNotice" value="0" /> 비사용 <input
				type="radio" name="bbsNotice" value="1" checked="checked" /> 사용</td>
		</tr>

	</table>

	<button type="button" id="insertBbs">게시판 생성하기</button>
	<button type="reset">취소</button>
</form>
<button id="bbslist">목록으로</button>