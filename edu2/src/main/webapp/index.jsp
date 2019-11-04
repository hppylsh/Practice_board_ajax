<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <jsp:forward page="/egovSampleList.do"/> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
</head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
	$(document).ready(function() {
		//alert('메인 접속');

	});

	function removeHeader() {
		if ($('#header').is('*')) {
			$('#header').remove();
		}
	}

	function button1_click() {
		side();
		fnContent();
	}

	function button2_click() {
		side();
		bbsContent();
	}

	function fnContent(bbsId, page) {
		if (bbsId==null) {
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
				curPage : page
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
		
	function bbsContent() {
		$.ajax({
			type : 'POST',
			url : '/bbslist.do',
			data : {},
			dataType : 'html',
			success : function(data) {
				$("#contents").html(data);
				removeHeader();
			},
			error : function(err) {
				console.log(err);
			}
		});
	}

	function side() {
		$.ajax({
			type : 'POST',
			url : '/sidebar.do',
			data : {},
			dataType : 'html',
			success : function(data) {
				$("#sidebar").html(data);
				removeHeader();
			},
			error : function(err) {
				console.log(err);
			}
		});
	}

	function fn_Detail(board, bbs, page, del) {
		$.ajax({
			type : 'POST',
			url : '/detail.do',
			data : {
				boardId : board,
				bbsId : bbs,
				curPage : page,
				bbsDel : del
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
</script>
<div id="header">
	<input type="button" onClick="button1_click();" value="게시판가기" /> <input type="button" onClick="button2_click();" value="관리자모드가기" />
</div>
<div id="sidebar"></div>
<div id="contents"></div>
<div id="footer"></div>
</body>
</html>