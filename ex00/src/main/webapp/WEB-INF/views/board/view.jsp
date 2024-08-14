<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반게시판 상세보기</title>
<%-- <jsp:include page="../jsp/weblib.jsp"/> --%>
<script type="text/javascript">
$(function() {
	$('#deleteModal').on('hidden.bs.modal', function () {	
		$("#pw").val("");	
	});	
	
	$("#listBtn").click(function() {
		location = "/board/list.do?page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}";
	});
	
	$("#updateBtn").click(function() {
		location = "/board/updateForm.do?no="+${vo.no}+"&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}";
	});
});
</script>

</head>
<body>
<div class="container">	
	
	<div class="card-header"><h2>일반 게시판 글 보기</h2></div>
	<div class="card-body">
		<div class="card dataRow" data-no="${vo.no }">
			<div class="card-header">
				<span class="float-right">조회수 : ${vo.hit }</span>
				${vo.no }. ${vo.title }
			</div>
			<div class="card-body" style="height: 300px;">
				<pre>${vo.content }</pre>
			</div>
			<div class="card-footer">
				<span class="float-right">
					<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>							
				</span>
				작성자 : ${vo.writer }
			</div>
		</div>
	</div>
	<div class="card-footer">
		<button id="listBtn" class="btn btn-dark">목록</button>
		<button id="updateBtn" class="btn btn-light">수정</button>
		<!-- 모달창을 열어서 비밀번호를 입력 받고 삭제 -->
		<button type="button" id="deleteBtn" class="btn btn-secondary" data-toggle="modal" data-target="#deleteModal">
  			삭제
		</button>
	</div>	
		
	
	<!-- The Modal -->
  	<div class="modal fade" id="deleteModal">
    	<div class="modal-dialog modal-dialog-centered">
      		<div class="modal-content">
      			
	        	<!-- Modal Header -->
	       		<div class="modal-header">
	         		<h4 class="modal-title">삭제를 위한 비밀번호 입력</h4>
	          		<button type="button" class="close delCelBtn" data-dismiss="modal">&times;</button>
	        	</div>
	        
	        	<!-- Modal body -->
	        	<div class="modal-body">
	        		<form action="delete.do" method="post" id="deleteForm" class="form-inline">
	        			<input id="no" name="no" type="hidden" value="${vo.no }">
						<input id="pw" name="pw" type="password" placeholder="비밀번호 입력" style="padding: 5px">
						<input type="hidden" name="perPageNum" value="${param.perPageNum}">
						<button class="btn btn-secondary">삭제 처리</button>
					</form>
	        	</div>
	        
	        	<!-- Modal footer -->
	        	<div class="modal-footer">	        		
	          		<button type="button" class="btn btn-dark delCelBtn" data-dismiss="modal">취소</button>
	        	</div>
        		
      		</div>
    	</div>
  	</div>
	
</div>
</body>
</html>