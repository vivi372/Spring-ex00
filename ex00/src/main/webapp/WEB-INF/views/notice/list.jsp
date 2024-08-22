<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시판</title>

<%-- <jsp:include page="../jsp/weblib.jsp"/> --%>

<style type="text/css">
.dataRow:hover{
	border-color: orange;
	cursor: pointer;
}
.dataRow>.card-header{
	background-color: #e0e0e0;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".dataRow").click(function() {
			let no = $(this).data("no");
			location = "/board/view.do?no="+no+"&inc=1&${pageObject.pageQuery}";
		});		
		
		
		$("#binBtn").click(function() {
			const settings = {
				async: true,
				crossDomain: true,
				url: 'https://bin-ip-checker.p.rapidapi.com/?bin=40457700',
				method: 'POST',
				headers: {
					'x-rapidapi-key': 'e27f927316msh17728d5e05a657ep1f205cjsnb7a806adc04d',
					'x-rapidapi-host': 'bin-ip-checker.p.rapidapi.com',
					'Content-Type': 'application/json'
				},
				processData: false,
				data: '{"bin":"40457700"}'
			};

			$.ajax(settings).done(function (response) {
				console.log(response);
			});
		});
	});
</script>

</head>
<body>
<div class="container">
	<button id="binBtn">통신</button>
	<div id="rest"></div>
	<div class="card">
		<div class="card-header"><h2>공지사항 리스트</h2></div>
		<div class="card-body">
			<c:forEach items="${list }" var="vo">
				<div class="card dataRow" data-no="${vo.no }">
					<div class="card-header">
						글번호 : ${vo.no }
					</div>
					<div class="card-body">
						<pre>${vo.title }</pre>
					</div>
					<div class="card-footer">
						<span class="float-right">
							<fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>		
							<b>~</b>					
							<fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/>							
						</span>						
					</div>
				</div>
			</c:forEach>		
		</div>
		<div class="card-footer">
			<div class="pagination justify-content-center">
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
			</div>
			<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-dark">게시판 글 등록</a>
		</div>
	</div>		
</div>
</body>
</html>