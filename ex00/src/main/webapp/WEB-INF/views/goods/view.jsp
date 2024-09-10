<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반게시판 상세보기</title>

<style type="text/css">
#smallImageDiv img {
	width: 80px;
	height: 80px;
	object-fit: contain;
	margin: 3px;
}
#bigImageDiv img {
	height: 500px;
	object-fit: contain;
}
#smallImageDiv img:hover {
	opacity: 70%;
	cursor: pointer;
}
.amount {
	text-align: center;
}
</style>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>





<script type="text/javascript">
$(function() {
	//이미지 보기 클릭 이벤트
	$("#smallImageDiv img").click(function() {
		let image_name = $(this).attr("src");		
		$("#bigImageDiv img").attr("src",image_name);
	});
	
	$("select").change(function() {	
		console.log($(this).attr("id"));
		if(isNotEmpty()) {
			let index = $(".optionInput").length;
			console.log(index);
			let hiddenInput = ``;
			let printOptName = `<span>`;
			let size_no = "";
			let color_no = "";
			let option_no ="";
			if($("#sizeSelect").length>0) {
				size_no =  $("#sizeSelect").val();
				let size_name = $("#sizeSelect option[value='"+size_no+"']").text();
				hiddenInput += `<input type="hidden" name="list[\${index}].size_no" value="\${size_no}">`;
				printOptName += `/\${size_name}`;
			}
			if($("#colorSelect").length>0) {
				color_no =  $("#colorSelect").val();
				let color_name = $("#colorSelect option[value='"+color_no+"']").text();
				hiddenInput += `<input type="hidden" name="list[\${index}].color_no" value="\${color_no}">`;
				printOptName += `/\${color_name}`;
			}
			if($("#optSelect").length>0) {
				option_no =  $("#optSelect").val();
				let option_name = $("#optSelect option[value='"+option_no+"']").text();
				hiddenInput += `<input type="hidden" name="list[\${index}].goods_option_no" value="\${option_no}">`;
				printOptName += `/\${option_name}`;
			}
			
			
			printOptName = printOptName.replace('/', '');
			printOptName += `</span>`;
			
			
			
			if($("#"+size_no+color_no+option_no).length == 0) {				  
				let list = `
					<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm optionInput" id="\${size_no}\${color_no}\${option_no}">`;		
				list += hiddenInput + printOptName;
				list +=	`<button type="button" class="close remove">&times;</button>
						<br><br>					
						<div class="input-group mb-3 optAmount" style="width: 150px;">
							<div class="input-group-prepend">
								<button class="btn btn-dark minusBtn" type="button">
									<i class="fa fa-minus"></i>
								</button>
							</div>
							<input type="text" name="list[\${index}].amount" class="form-control amount" value="1">
							<div class="input-group-append">
								<button class="btn btn-dark plusBtn" type="button">
									<i class="fa fa-plus"></i>
								</button>
							</div>
						</div>
					</div>
					`
				$("#optDiv").append(list);
				priceOpp();					
			}
			$("select").val(0);
		}
	});		
	
	function isNotEmpty() {
		let result = true;
		
		$("select").each(function(){
			if($(this).val() == 0) {				
				result = false;
			}
		});		
		return result;
	}
});
	
//수량이 입력될때 이벤트
$(document).on("input",".amount", function() {
	//입력된 수량이 숫자가 아니면 지워버린다.	
	$(this).val($(this).val().replace(/[^0-9]/g, ""));
	$(this).val(Number($(this).val()));
	//수량이 1보다 작아지면 0으로 바꾼다.
	if ($(this).val() < 1)
		$(this).val(0);	
	priceOpp();
	
});

$(document).on("change",".amount", function() {
	if($(this).val()==0) $(this).val(1);
	priceOpp();
});

//-버튼 클릭시 이벤트
$(document).on("click",".minusBtn", function() {
	//수량이 입력된 input태그에서 값을 가져온다.
	let amountInput = $(this).closest(".optAmount").find(".amount");		
	let amount = amountInput.val();
	//수량에 1를 뺀후 다시 입력한다. 만약 뺀값이 1보다 작은 경우 1을 입력한다.
	if(amount-1 < 1){
		amountInput.val(1);
	} else 
		amountInput.val(Number(amount)-1);
	priceOpp();

});
//+버튼 클릭시 이벤트
$(document).on("click",".plusBtn", function() {
	//수량이 입력된 input태그에서 값을 가져온다.
	let amountInput = $(this).closest(".optAmount").find(".amount");
	let amount = amountInput.val();
	console.log(amount);
	//수량에 1를 더한 후 다시 입력한다.
	amountInput.val(Number(amount) + 1);
	priceOpp();
	
});

$(document).on("click",".remove", function() {
	$(this).closest(".optionInput").remove();
	priceOpp();
	
});

function priceOpp() {
	let totalAmount = 0;
	let deliveryCharge = "${goodsVO.delivery_charge }";
	$(".amount").each(function() {
		totalAmount += (+$(this).val());
	});
	
	let totalPrice = Number("${goodsVO.sale_price }")*totalAmount;
	$("#totalPrice").text(numWithComma(totalPrice));
	if(totalPrice > 50000) deliveryCharge = 0;
	$("#deliveryCharge").text(numWithComma(deliveryCharge));
	
}

function numWithComma(strNum){
	//입력된 수를 정수 타입으로 변환
	num = parseInt(strNum);
	//수에다 3자리마다 , 삽입
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}


</script>

</head>
<body>
<div class="container">	
	<h2>상품 상세 보기</h2>
	
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<div class="row">
			<div class="col-md">
				<div id="smallImageDiv" class="img-thumbnail">				
						<img alt="대표 이미지" src="${goodsVO.image_name }">				
					<c:if test="${!empty imageList }">
						<c:forEach items="${imageList }" var="vo">						
							<img alt="추가 이미지" src="${vo.image_name }">						
						</c:forEach>				
					</c:if>
				</div>
				<div id="bigImageDiv" class="img-thumbnail">
					<img alt="대표 이미지" src="${goodsVO.image_name }" style="width: 100%;">			
				</div>
			</div>
			<div class="col-md">
				<div class="text-truncate">
					<h4><b>${goodsVO.goods_name }</b></h4>
				</div>
				<hr>
				<div class="row mb-2">
					<div class="col-md-3"><b>카테고리</b></div>
					<div class="col-md-9">
						${goodsVO.cate_name }
					</div>				
				</div>
				<div class="row mb-2">
					<div class="col-md-3"><b>제조사</b></div>
					<div class="col-md-3">
						${goodsVO.company }
					</div>		
					<div class="col-md-3"><b>제조년월일</b></div>
					<div class="col-md-3">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${goodsVO.product_date }"/>
						
					</div>			
				</div>				
				<div class="row text-secondary mb-2">
					<div class="col-md-3"><b>정가</b></div>
					<div class="col-md-9" ${(!empty goodsVO.discountRate)?'style="text-decoration: line-through;"':'' } >
						<fmt:formatNumber value="${goodsVO.price }"></fmt:formatNumber>
					</div>				
				</div>
				<div class="row mb-2">
					<div class="col-md-3"><b>판매가</b></div>
					<div class="col-md-9" style="font-size: 25px;">
					<c:if test="${!empty goodsVO.discountRate }">
						<span class="text-danger">${goodsVO.discountRate }%</span> 
					</c:if>
					<b><fmt:formatNumber value="${goodsVO.sale_price }"/></b>		
					</div>				
				</div>
				
				<div class="row mb-2">
					<div class="col-md-3">
						배송비
						<br>
						<small>(5만원 이상 구매시 무료)</small>
					</div>
					<div class="col-md-9">
						<fmt:formatNumber value="${goodsVO.delivery_charge }"/>
					</div>				
				</div>
				
				<c:if test="${goodsVO.saved_rate > 0 }">
					<div class="row mb-2">
						<div class="col-md-3">적립금</div>
						<div class="col-md-9">
							<fmt:formatNumber maxFractionDigits="0" value="${goodsVO.sale_price*goodsVO.saved_rate/100 }"/> (${goodsVO.saved_rate } %)
						</div>				
					</div>
				</c:if>
				<hr>
				<form action="/cart/write.do" method="post">
					<input name="list[0].goods_no" type="hidden" value="${goodsVO.goods_no }">
					<c:if test="${!empty sizeColorList}">
						<c:if test="${!empty sizeColorList[0].size_no }">
							<div class="row mb-2">
								<div class="col-md-3"><b>사이즈</b></div>					
								<div class="col-md-9">
									<select id="sizeSelect" class="form-control" name="size_no">
										<option value="0" style="display: none;">사이즈를 선택하세요</option>
										<c:forEach items="${ sizeList}" var="vo" varStatus="">											
												<option value="${ vo.size_no}">${ vo.size_name}</option>								
																					
											
											
										</c:forEach>
									</select>
								</div>					
							</div>
						</c:if>	
						<c:if test="${!empty sizeColorList[0].color_no }">
							<div class="row mb-2">
								<div class="col-md-3"><b>색상</b></div>					
								<div class="col-md-9">
									<select id="colorSelect" class="form-control">
										<option value="0" style="display: none;">색상을 선택하세요</option>
										<c:forEach items="${ colorList}" var="vo">
											<option value="${ vo.color_no}">${ vo.color_name}</option>
										</c:forEach>
									</select>
								</div>					
							</div>
						</c:if>
					</c:if>	
					
					<c:if test="${!empty optionList}">					
						<div class="row mb-2">
							<div class="col-md-3"><b>옵션</b></div>					
							<div class="col-md-9">
								<select id="optSelect" class="form-control">
									<option value="0" style="display: none;">옵션을 선택하세요</option>
									<c:forEach items="${ optionList}" var="vo">
										<option value="${ vo.goods_option_no}">${ vo.option_name}</option>
									</c:forEach>
								</select>
							</div>					
						</div>						
					</c:if>	
					
					<div id="optDiv">
					
					</div>	
				
				
				<div class="row mb-2">
					<div class="col-md-3"><b>총가격</b></div>
					<div class="col-md-9" style="font-size: 25px;">					
						<b id="totalPrice">0</b>원		
					</div>				
				</div>
				<div class="row mb-2">
					<div class="col-md-3"><b>배송비</b></div>
					<div class="col-md-9">					
						<b id="deliveryCharge">0</b>원		
					</div>				
				</div>
				
				<button class="btn btn-outline-dark btn-block mt-3">장바구니</button>
			</form>	
			</div>
		</div>
		
	</div>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<div class="row">
			<div class="col-md-12">
				<c:if test="${!empty goodsVO.detail_image_name }">
					<img alt="상세 이미지" src="${goodsVO.detail_image_name }" style="width: 100%;">
				</c:if>
				<c:if test="${empty goodsVO.detail_image_name }">
					<pre>${goodsVO.content }</pre>
				</c:if>
			</div>
						
		</div>
	</div>
<!-- 	<div class="card-header"><h2>일반 게시판 글 보기</h2></div> -->
<!-- 	<div class="card-body"> -->
<!-- 		<div class="card"> -->
<!-- 			<div class="card-header"> -->
<%-- 				<span class="float-right">조회수 : ${vo.hit }</span> --%>
<%-- 				${vo.no }. ${vo.title } --%>
<!-- 			</div> -->
<!-- 			<div class="card-body" style="height: 300px;"> -->
<%-- 				<pre>${vo.content }</pre> --%>
<!-- 			</div> -->
<!-- 			<div class="card-footer"> -->
<!-- 				<span class="float-right"> -->
<%-- 					<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>							 --%>
<!-- 				</span> -->
<%-- 				작성자 : ${vo.writer } --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
<!-- 	<div class="card-footer"> -->
<!-- 		<button id="listBtn" class="btn btn-dark">목록</button> -->
<!-- 		<button id="updateBtn" class="btn btn-light">수정</button> -->
		<!-- 모달창을 열어서 비밀번호를 입력 받고 삭제 --> 
<!-- 		<button type="button" id="deleteBtn" class="btn btn-secondary" data-toggle="modal" data-backdrop="static" data-target="#deleteModal"> -->
<!--   			삭제 -->
<!-- 		</button> -->
<!-- 	</div>	 -->

	
	<!-- The Modal -->
  	<div class="modal fade" id="deleteModal">
    	<div class="modal-dialog modal-dialog-centered modal-xl">
      		<div class="modal-content"   style="height: 800px;">
      			
	        	Modal Header
	       		<div class="modal-header">
	         		<h4 class="modal-title">삭제를 위한 비밀번호 입력</h4>
	          		<button type="button" class="close delCelBtn" data-dismiss="modal">&times;</button>
	        	</div>
	        
	        	Modal body
	        	<div class="modal-body">
	        		<form action="delete.do" method="post" id="deleteForm" class="form-inline">
	        			<input type="hidden" name="page" value="${param.page}">
						<input type="hidden" name="perPageNum" value="${param.key}">
						<input type="hidden" name="key" value="${param.perPageNum}">
						<input type="hidden" name="word" value="${param.word}">
	        			<input id="no" name="no" type="hidden" value="${param.goods_no }">
						<input id="pw" name="pw" type="password" placeholder="비밀번호 입력" style="padding: 5px">						
						<button class="btn btn-secondary">삭제 처리</button>
					</form>
	        	</div>
	        
	        	Modal footer
	        	<div class="modal-footer">	        		
	          		<button type="button" class="btn btn-dark delCelBtn" data-dismiss="modal">취소</button>
	        	</div>
        		
      		</div>
    	</div>
  	</div>
	
</div>
</body>
</html>