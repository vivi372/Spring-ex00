<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>

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
			<h2>상품 리스트</h2>
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
			   						<option value="8">8</option>
			   						<option value="12">12</option>
			   						<option value="16">16</option>
			   						<option value="20">20</option>   							
			   					</select>
			  				</div>
		  				</div>
					</div>	<!-- col-4 end : 한 페이지당 페이지 수 -->	
				</div>
			</form>	
		</div>
		<c:if test="${empty list }">
			<div class="jumbtron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty list }">
			<!-- 이미지의 데이터가 있는 만큼 반복해서 표시 -->
			<div class="row my-3">
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
				<c:forEach items="${list }" var="vo" varStatus="vs">	
					<!-- 줄 바꿈 처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
					<c:if test="${vs.index != 0 && vs.index % 3 ==0 }">
						${"</div>" }
						${"<div class='row my-3'>" }
					</c:if>
					<div class="col-md-4">
			    		<div class="card dataRow" data-no="${vo.goods_no }" >
			    			<div class="imageDiv text-center align-content-center" style="height: 300px;">
			    				<img class="card-img-top" style="height:100%; object-fit: contain;" src="${vo.image_name }" alt="Card image">
			    			</div>
			    			<div class="card-body">
			      				<h4 class="card-title text-truncate">${vo.goods_name }(${vo.hit })</h4>
			      				<div class="card-text">
			      					<div>
			      						정가 : <fmt:formatNumber value="${vo.price }"></fmt:formatNumber>원	  
			      					</div>
			      					<div>
			      						판매가 : <fmt:formatNumber value="${vo.sale_price }"></fmt:formatNumber>원 
			      						/ 적립 : ${vo.saved_rate }%
			      					</div>	  
			      					
			      					배송비 :<fmt:formatNumber value="${vo.delivery_charge }"></fmt:formatNumber>
			      				</div>      				
			    			</div>
			  			</div>
	<!--   				imgCard end -->
	  				</div> 	
	  			<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
	  			</c:forEach>
			</div>
		</c:if>	
		<div class="card-footer">
			<div class="pagination justify-content-center">
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
			</div>
<%-- 			<c:if test="${empty login && login.gradeNo == 9 }"> --%>
				<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-dark">상품 등록</a>
<%-- 			</c:if> --%>
		</div>
	</div>		
</div>
</body>
</html>