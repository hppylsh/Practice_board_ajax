<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">
	$(document).ready(function() {

		// bbsRead읽어오기
		var bbsRead = "${map.bbsRead}";

		// bbsRead값이 0이면 비사용 체크 / 1이면 사용 체크
		if (bbsRead == '0') {
			document.submitform.bbsRead[0].checked = true;
		} else {
			document.submitform.bbsRead[1].checked = true;

		}

		var bbsWrite = "${map.bbsWrite}";
		if (bbsWrite == '0') {
			document.submitform.bbsWrite[0].checked = true;
		} else {
			document.submitform.bbsWrite[1].checked = true;

		}

		var bbsDel = "${map.bbsDel}";
		if (bbsDel == '0') {
			document.submitform.bbsDel[0].checked = true;
		} else {
			document.submitform.bbsDel[1].checked = true;

		}

		var bbsUse = "${map.bbsUse}";
		if (bbsUse == '0') {
			document.submitform.bbsUse[0].checked = true;
		} else {
			document.submitform.bbsUse[1].checked = true;

		}

		var bbsNotice = "${map.bbsNotice}";
		if (bbsNotice == '0') {
			document.submitform.bbsNotice[0].checked = true;
		} else {
			document.submitform.bbsNotice[1].checked = true;

		}

	})

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

	$("#updateBbs").click(function() {
		$.ajax({
			type : 'POST',
			url : '/updateBbs.do',
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
</script>
<form id="submitform" name="submitform">
	<table class="write_form">
		<caption>게시글 작성</caption>
		<tr>
			<td>게시판 이름</td>
			<td><input id="bbsName" name="bbsName" value="${map.bbsName }"></td>
		</tr>
		<tr>
			<td>게시판 생성일</td>
			<td>${map.bbsRegDate }</td>
		</tr>
		<tr>
			<td>읽기사용</td>
			<td><input type="radio" name="bbsRead" value="0" /> 비사용 <input type="radio" name="bbsRead" value="1" /> 사용</td>
		</tr>
		<tr>
			<td>쓰기사용</td>
			<td><input type="radio" name="bbsWrite" value="0" /> 비사용 <input type="radio" name="bbsWrite" value="1" /> 사용</td>
		</tr>
		<tr>
			<td>삭제사용</td>
			<td><input type="radio" name="bbsDel" value="0" /> 비사용 <input type="radio" name="bbsDel" value="1" /> 사용</td>
		</tr>
		<tr>
			<td>공개사용</td>
			<td><input type="radio" name="bbsUse" value="0" /> 비사용 <input type="radio" name="bbsUse" value="1" /> 사용</td>
		</tr>
		<tr>
			<td>공지사용</td>
			<td><input type="radio" name="bbsNotice" value="0" /> 비사용 <input type="radio" name="bbsNotice" value="1" /> 사용</td>
		</tr>
	</table>
	<input type="hidden" id="bbsId" name="bbsId" value="${map.bbsId }">
	<button type="button" id="updateBbs">수정하기</button>
</form>
<button id="bbslist">목록으로</button>