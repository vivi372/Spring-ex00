<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판</title>

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
			
			
			
		// perPageNum 처리
		$("#perPageNum").change(function() {
			//alert("change perPageNum");
			// page는 1페이지 + 검색 데이터 전부 보낸다.
			$("#search").submit();
		});			
		//검색 데이터 세팅		
		$("#key").val("${(empty pageObject.key)?'t':pageObject.key}");
		$("#perPageNum").val("${(empty pageObject.perPageNum)?'10':pageObject.perPageNum}");
		$("#word").val("${pageObject.word}");
		//$("#perPageNum").val("${pageObject.perPageNum}");				
	
		
	});
</script>

</head>
<body>
<div class="container">
	
	<div class="card">
		<div class="card-header">
			<h2>일반 게시판 리스트</h2>
			<form action="list.do" id="search" class="mt-2">
				<input name="page" value="1" type="hidden">
				<div class="row">		
					<div class="col-md-8">				
						<div class="input-group mb-3">
		  					<div class="input-group-prepend">    					
		   						<select name="key" id="key" class="form-control">
		   							<option value="t">제목</option>
		   							<option value="c">내용</option>
		   							<option value="w">작성자</option>
		   							<option value="tc">제목+내용</option>
		   							<option value="cw">내용+작성자</option>
		   							<option value="tcw">모두</option>
		   						</select>    					
		  					</div>
		 				 	<input type="text" class="form-control" placeholder="검색" id="word" name="word">
		 				 	<div class="input-group-append">
		    					<button class="btn btn-dark" type="submit"><i class="fa fa-search"></i></button>
		  					</div>
						</div>				
					</div>	<!-- col-8 end : 검색 -->			
					<div class="col-md-4">
						<!-- 너비를 조정하기 위한 div 추가 - float-right : 오른쪽 정렬 -->
						<div style="width: 200px;" class="float-right">
							<div class="input-group mb-3">
			    				<div class="input-group-prepend">
			      					<span class="input-group-text bg-dark text-white">페이지당 글수:</span>
			    				</div>
			    				<select name="perPageNum" id="perPageNum" class="form-control">
			   						<option value="10">10</option>
			   						<option value="15">15</option>
			   						<option value="20">20</option>
			   						<option value="25">25</option>   							
			   					</select>
			  				</div>
		  				</div>
					</div>	<!-- col-4 end : 한 페이지당 페이지 수 -->	
				</div>
			</form>	
		</div>
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
			<div class="pagination justify-content-center">
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
			</div>
			<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-dark">게시판 글 등록</a>
		</div>
	</div>		
</div>
</body>
</html>