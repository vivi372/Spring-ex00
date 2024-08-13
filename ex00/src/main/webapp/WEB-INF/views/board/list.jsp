<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판</title>

<jsp:include page="../jsp/weblib.jsp"/>

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
			location = "/board/view.do?no="+no+"&inc=1";
		});		
	});
</script>

</head>
<body>
<div class="container">
	<div class="card">
		<div class="card-header"><h2>일반 게시판 리스트</h2></div>
		<div class="card-body">
			<c:forEach items="${list }" var="vo">
				<div class="card dataRow" data-no="${vo.no }">
					<div class="card-header">
						<span class="float-right">조회수 : ${vo.hit }</span>
						글번호 : ${vo.no }
					</div>
					<div class="card-body">
						<pre>${vo.title }</pre>
					</div>
					<div class="card-footer">
						<span class="float-right">
							<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>							
						</span>
						작성자 : ${vo.writer }
					</div>
				</div>
			</c:forEach>		
		</div>
		<div class="card-footer">
			<a href="writeForm.do" class="btn btn-dark">게시판 글 등록</a>
		</div>
	</div>		
</div>
</body>
</html>