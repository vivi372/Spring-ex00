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
		
		
		//이벤트 처리
		$("#cate_code1").change(function() {
			let cate_code1 = $(this).val();
			if(cate_code1 == ""){
				$("#cate_code2").val("");
			}
			$("#search").submit();		
		});
		
		$(".dataRow").click(function() {
			let no = $(this).data("no");
			location = "/goods/view.do?goods_no="+no+"&inc=1&${pageObject.pageQuery}&${searchVO.query}";
		});	
			
					
		// perPageNum 처리
		$("#perPageNum").change(function() {
			//alert("change perPageNum");
			// page는 1페이지 + 검색 데이터 전부 보낸다.
			$("#search").submit();
		});			
		//검색 데이터 세팅		
		$("#key").val("${(empty pageObject.key)?'t':pageObject.key}");
		$("#perPageNum").val("${pageObject.perPageNum}");
		$("#word").val("${searchVO.goods_name}");
		$("#cate_code1").val("${searchVO.cate_code1}");
		$("#minPrice").val("${searchVO.minPrice}");
		$("#maxPrice").val("${searchVO.maxPrice}");
		if(${searchVO.detailState}) {
			$(".detailSearch").css("display","block");
			$("#detailState").removeAttr("disabled");
		}
		//중분류 가져오기
		$.ajax({
			type : "get", //데이터 전송 방식
			url: "/goods/getCateMidSizeColor.do?cate_code1=${searchVO.cate_code1}",
			contentType : "application/json;charset=UTF-8",
			success: function(data) {
				//console.log(data);
				//중분류 가져오기
				//catelist만 뽑아오기
				let $cateList = $(data).find("cateList");
				//생성할 옵션들 태그를 저장하는 변수 선언 
				let optionTag = `
					<option value="" selected>중분류</option>
				`;
				//catelist 반복문 돌리기
				$cateList.each(function() {
					//필요한 데이터 가져오기
					let cate_code1 = $(this).find("cate_code1").text();
					let cate_code2 = $(this).find("cate_code2").text();
					let cate_name = $(this).find("cate_name").text();
					//옵션 태그 추가
					optionTag += `<option value="\${cate_code2}">\${cate_name}</option>`;
				});
				//select 태그의 옵션 새로 치환
				$("#cate_code2").html(optionTag);
				$("#cate_code2").removeAttr("disabled");		
				
				//중분류 검색값 세팅
				if(${!empty searchVO.cate_code2})
					$("#cate_code2").val("${searchVO.cate_code2}");
			}
		});			
	
		$("#minPrice,#maxPrice").on("input",function() {
			if($(this).val()<0)
				$(this).val("");
		});
		
		//검색 이벤트
		$("#cate_code2, #minPrice, #maxPrice").change(function() {
			$("#search").submit();
		});
		$("#reset").click(function() {
			$("#word").val("");
			$("#cate_code1").val("");
			$("#cate_code2").val("");
			$("#minPrice").val("");
			$("#maxPrice").val("");
			$("#search").submit();
		});
		
		$("#detailSearchBtn").click(function() {			
			if($(".detailSearch").css("display") == "none") {
				$(".detailSearch").slideToggle();
				$("#detailState").removeAttr("disabled");
			} else {
				$(".detailSearch").slideToggle();
				$("#detailState").prop("disabled",true);
			}
		});
		
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
		  					
		 				 	<input type="text" class="form-control" placeholder="검색" id="word" name="goods_name">
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
				<div>
					<button type="button" id="detailSearchBtn" class="btn btn-dark btn-sm">상세 검색</button>
					<button type="button" id="reset" class="btn btn-secondary btn-sm">초기화</button>
				</div>
				<div class="detailSearch mt-2" style="display: none;">
					<input type="hidden" value="true" id="detailState" name="detailState" disabled>
					<label for="category">카테고리</label> 
					<div class="form-row mb-2">			
						<div class="col">
							 <select class="form-control" id="cate_code1" name="cate_code1">
							 	<option value="">대분류</option>
							 	<c:forEach items="${category }" var="vo">
							 		<option value="${vo.cate_code1 }">${vo.cate_name }</option>
							 	</c:forEach>
							 </select>		
						 </div>
						 <div class="col">
							 <select class="form-control" id="cate_code2" name="cate_code2" disabled>
							 	<!-- ajax를 이용한 중분류 option 출력 -->
							 	<option style="display: none;" value="">중분류</option>
							 </select>	
						 </div>			
					</div>
					
					<label for="minPrice">가격</label> 
					<div class="form-row mb-2">			
						<div class="col-5">
							<input type="number" class="form-control" placeholder="최소 금액" name="minPrice" id="minPrice">
						 </div>
						 <div class="col-2 text-center">
						 	<i class="fa fa-minus"></i>
						 </div>
						 <div class="col-5">
							<input type="number" class="form-control" placeholder="최대 금액" name="maxPrice" id="maxPrice">
						 </div>			
					</div>
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
					<!-- 줄 바꿈 처리 - 찍는 인덱스 번호가 4의 배수이면 줄바꿈을 한다. -->
					<c:if test="${vs.index != 0 && vs.index % 4 ==0 }">
						${"</div>" }
						${"<div class='row my-3'>" }
					</c:if>
					<div class="col-md-3">
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