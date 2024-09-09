<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<style type="text/css">
	input[type="text"]:disabled {
		background: #000;
	}
</style>


<script type="text/javascript">
	$(function() {
		//이벤트 처리
		$("#cate_code1").change(function() {
			let cate_code1 = $(this).val();
			//중분류 가져오기
			$.ajax({
				type : "get", //데이터 전송 방식
				url: "/goods/getCateMidSizeColor.do?cate_code1="+cate_code1,
				contentType : "application/json;charset=UTF-8",
				success: function(data) {
					//console.log(data);
					//중분류 가져오기
					//catelist만 뽑아오기
					let $cateList = $(data).find("cateList");
					//생성할 옵션들 태그를 저장하는 변수 선언 
					let optionTag = `
						<option style="display: none;" value="">중분류</option>
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
					
					//기본 사이즈,컬러,옵션 가져오기
					//경고 숨기기
					$("#optionAlert").hide();
					$("#radioDiv").show();
					
					let $sizeList = $(data).find("sizeList");
					let $colorList = $(data).find("colorList");
					
					if($sizeList.length>0 && $colorList.length>0) {
						$("#sizeDiv").show();
						$("#colorDiv").show();
						$("#optionDiv").hide();
						
						$(".optionInputDiv").remove();
						$("#optionInputDiv .option_name").val("").attr("disabled",true);
						
						$("input[value='컬러 사이즈']").prop("checked",true);
						$("#radioDiv").show();
					}
					else {
						$("#sizeDiv").hide();
						$("#colorDiv").hide();
						$("#optionDiv").show();
						$("#optionInputDiv .option_name").removeAttr("disabled");
						
						$("#radioDiv").hide();
					}					
					
					//사이즈 체크박스 생성
					let sizeCheckBoxsTag = ``;
					$sizeList.each(function() {
						let size_no = $(this).find("size_no").text();
						let size_name = $(this).find("size_name").text();
						
						sizeCheckBoxsTag += `
							<div class="form-check">
		 						<label class="form-check-label">
		    						<input type="checkbox" name="size_no" class="form-check-input" value="\${size_no}">\${size_name}
		  						</label>
							</div>
						`;
					});
					$(".sizeCheckBoxDiv").html(sizeCheckBoxsTag);
					
					//컬러 체크박스 생성
					let colorCheckBoxsTag = ``;
					$colorList.each(function() {
						let color_no = $(this).find("color_no").text();
						let color_name = $(this).find("color_name").text();
						
						colorCheckBoxsTag += `
							<div class="form-check">
		 						<label class="form-check-label">
		    						<input type="checkbox" name="color_no" class="form-check-input" value="\${color_no}">\${color_name}
		  						</label>
							</div>
						`;
					});
					$(".colorCheckBoxDiv").html(colorCheckBoxsTag);	
				}
			});			
		});
		
		$(".radioOption").click(function() {
			if($("#cate_code1").val()=="") return false;
			let checkedRadio = $(this).parent().text().trim();
			if(checkedRadio == '옵션 직접 입력') {
				$("#sizeDiv").hide();
				$("#colorDiv").hide();
				$("#optionDiv").show();
				$("#optionInputDiv .option_name").removeAttr("disabled");
				
				$("input[name='size_no'],input[name='color_no']").prop("checked",false);
				$("input[name='size_no'],input[name='color_no']").attr("disabled",true);
			} else {
				$("#sizeDiv").show();
				$("#colorDiv").show();
				$("#optionDiv").hide();
				
				$(".optionInputDiv").remove();
				$("#optionInputDiv .option_name").val("").attr("disabled",true);
				
				//$("input[name='size_no']").attr("checked",true);
				$("input[name='size_no'],input[name='color_no']").removeAttr("disabled");
				
				
			}
		});
		
		//판매가 계산 이벤트
		$("#price ,#discount, #discount_rate").keyup(function() {
			let discountInputName = $(this).attr("name");
			//console.log(discountInputName);
			let price = $("#price").val();
			
			if(discountInputName == 'discount') {
				$("#discount_rate").val("");
				let sale_price = price - (+ $(this).val());
				$("#sale_price").text(sale_price);
			} else if(discountInputName == 'discount_rate') {
				let discount_rate = Number($(this).val());
				$("#discount").val("");
				let sale_price = Math.floor((price - (price*discount_rate/100))/10)*10;
				$("#sale_price").text(sale_price);
			} else {
				$("#sale_price").text(price);
				let discount_rate = $("#discount_rate").val();
				let discount = $("#discount").val();
				let sale_price;
				if(discount != ''){
					sale_price = price - (+ discount);
					$("#sale_price").text(sale_price);
				} else if(discount_rate != '') {
					let sale_price = Math.floor((price - (price*discount_rate/100))/10)*10;
					$("#sale_price").text(sale_price);
				} else $("#sale_price").text(price);
				
			}
		});
		
		//옵션 입력 태그 백틱
		let optionInputTag = `
			<div class="input-group optionInputDiv mb-2">
				<input type="text" class="form-control option_name" name="option_name">
				<div class="input-group-append">
				<button type="button" class="btn btn-secondary btn-sm float-right inputRemove">&times;</button>
				</div>
			</div>
		`;
		//add option 버튼 클릭 이벤트
		$("#addOptionBtn").click(function() {
			//alert("클릭");
			//옵션 입력 태그 생성			
			$(".optionCheckBoxDiv").append(optionInputTag);			
		});
		
		//추가 이미지 입력 태그의 x버튼 클릭 이벤트
		$(".optionCheckBoxDiv").on("click",".inputRemove",function() {
			//태그 삭제
			$(this).closest(".optionInputDiv").remove();
		});
		
		//추가 이미지 입력 태그 백틱
		let imgInputTag = `
			<div class="input-group image_names-div mb-2">
				<input type="file" class="form-control image_names" name="image_names">
				<div class="input-group-append">
				<button type="button" class="btn btn-secondary btn-sm float-right inputRemove">&times;</button>
				</div>
			</div>
		`;
		//add imge 버튼 클릭 이벤트
		$("#addImageBtn").click(function() {
			//alert("클릭");
			//추가 이미지 입력 태그 생성
			//추가 이미지 입력 태그 생성은 태그가 5개 보다 적을때 가능하다.
			if($(".image_names-div").length<5)
				$(".image_names-group").append(imgInputTag);
			else alert("추가 이미지는 5개까지만 가능합니다.")
			
		});
		//추가 이미지 입력 태그의 x버튼 클릭 이벤트
		$(".image_names-group").on("click",".inputRemove",function() {
			//태그 삭제
			$(this).closest(".image_names-div").remove();
		});
		
		$("#writeForm").submit(function() {
			$("input[name='option_name']").each(function() {
				if($(this).val()=="") $(this).attr("disabled",true);
			});
			
			
		});
		
		
		//datepicker 
		let now = new Date();
		
		$("#product_date").datepicker("option","maxDate",now);
		
		$("#sale_start_date,#sale_end_date").datepicker("option",{
			"minDate" : now,
		});
		
		$(".datepicker").datepicker();

		
		$("#sale_start_date").change(function() {
			//alert($(this).val());
			$("#sale_end_date").datepicker( "option", "minDate", $(this).val() );
		});
		
		$("#sale_end_date").change(function() {
			//alert($(this).val());
			$("#sale_start_date").datepicker( "option", "maxDate", $(this).val() );
		});
		
		$("#dateReset").click(function() {
			$("#sale_end_date").val("");
			$("#sale_start_date").val("");
			$("#sale_end_date").datepicker( "option", "minDate",now );
			$("#sale_start_date").datepicker( "option", "maxDate",null );
		});
	});
</script>

</head>
<body>
<div class="container">
	<h1>상품 등록</h1>
	<form action="write.do" method="post" id="writeForm" enctype="multipart/form-data">
		<!-- 상품 기본 정보 -->
		<h5><b>상품 기본 정보</b></h5>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
			<label for="category">카테고리</label> 
			<div class="form-row mb-2">			
				<div class="col">
					 <select class="form-control" id="cate_code1" name="cate_code1">
					 	<option style="display: none;" value="">대분류</option>
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
			<div class="form-group">
				<label for="goods_name">상품 이름</label> 
					<input type="text" class="form-control" required placeholder="상품 이름 입력" id="goods_name" name="goods_name">
			</div>
			<div class="form-group">
				<label for="company">제조사</label> 
				<input type="text" class="form-control" required placeholder="제조사 입력" id="company" name="company">
			</div>
			<div class="form-group">
				<label for="product_date">제조일</label> 
				<input type="text" class="form-control datepicker" required readonly placeholder="제조일 입력" id="product_date" name="product_date">
			</div>
			
			<div class="form-row">
				<div class="form-group col">
					<label for="image_name">대표 이미지</label> 
					<!-- vo 객체의 프로퍼티와 다르다. 파일 자체이므로 이름만 저장하고 경로만 서버에 저장 -->
					<input type="file" class="form-control" id="image_name" required name="image_name_file">
				</div>
				<div class="form-group col">
					<label for="detail_image_name">상세 이미지</label> 
					<!-- vo 객체의 프로퍼티와 다르다. 파일 자체이므로 이름만 저장하고 경로만 서버에 저장 -->
					<input type="file" class="form-control" id="detail_image_name" name="detail_image_name_file">
				</div>		
			</div>		
			<div class="form-group">
				<label for="content">상세 설명</label> 
					<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content"></textarea>
			</div>
		</div>
		<!-- 상품 기본 입력 끝 -->
		
		<!-- 가격 정보 입력 시작 -->
		<h5><b>가격 정보</b></h5>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
			<div class="form-group">
				<label for="price">정가</label> 
				<input type="text" class="form-control" required placeholder="정가 입력" id="price" name="price">
			</div>
			<div class="form-row">
				<div class="form-group col">
					<label for="discount">할인가</label> 
					<input type="text" class="form-control" id="discount" name="discount">
				</div>
				<div class="form-group col">
					<label for="discount_rate">할인율</label> 
					<input type="text" class="form-control" id="discount_rate" name="discount_rate">
				</div>		
			</div>	
			<div>
				판매가 : <span id="sale_price"></span>원
			</div>
				
			<div class="form-group">
				<label for="delivery_charge">배송비</label> 
				<input type="text" class="form-control" required placeholder="배송비 입력" id="delivery_charge" name="delivery_charge">
			</div>
			<div class="form-group">
				<label for="saved_rate">적립금</label> 
				<input type="text" class="form-control" required placeholder="적립금 입력" id="saved_rate" name="saved_rate">
			</div>
			
			<div class="form-group">
				<label>할인 시작일 / 할인 종료일</label> 
				<div class="form-inline">
					<input type="text" class="form-control datepicker" readonly placeholder="할인 시작일" id="sale_start_date" name="sale_start_date" required autocomplete="off">	
					<span class="mx-3"> ~ </span>		
					<input type="text" class="form-control datepicker" readonly placeholder="할인 종료일" id="sale_end_date" name="sale_end_date" required autocomplete="off">		
					<button class="btn btn-light" type="button" id="dateReset">날짜 리셋</button>
				</div>	
			</div>
		</div>
		<!-- 가격 정보 입력 끝 -->
		
		<!-- 상품 옵션 입력 시작 -->
		<h5><b>상품 옵션 입력</b></h5>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
			<div class="form-inline mb-2" id="radioDiv" style="display: none;">
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input radioOption" value="컬러 사이즈" name="radioOption">컬러 사이즈
				  </label>
				</div>
				<div class="form-check">
				  <label class="form-check-label">
				    <input type="radio" class="form-check-input radioOption" value="옵션 직접 입력" name="radioOption">옵션 직접 입력
				  </label>
				</div>
			</div>
			<div class="form-row mb-2" id="goodsOptionInputDiv">
				<b id="optionAlert">카테고리를 선택해주세요</b>		
				<div class="col" id="sizeDiv" style="display: none;">
					<b>상품 사이즈 선택</b>
					<div class="sizeCheckBoxDiv">
					
					</div>					
				</div>
				<div class="col" id="colorDiv" style="display: none;">
					<b>상품 컬러 선택</b>
					<div class="colorCheckBoxDiv">
					
					</div>		
				</div>
				<div class="col" id="optionDiv" style="display: none;">
					<button type="button" class="btn btn-secondary btn-sm float-right mb-3" id="addOptionBtn">add option</button>
					<b>상품 옵션 선택</b>
					<div class="optionCheckBoxDiv">
						<div class="input-group mb-2" id="optionInputDiv">
							<input type="text" class="form-control option_name" name="option_name">
						</div>
					</div>		
				</div>
			</div>
		</div>
		<!-- 상품 옵션 입력 끝 -->
		
		<!-- 추가 이미지 시작 -->
		<h5><b>추가 이미지</b></h5>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
			<button type="button" id="addImageBtn" class="btn btn-secondary btn-sm mb-3">add Image</button>
			<div class="form-group image_names-group">
				<div class="input-group image_names-div mb-2">
				<!-- vo 객체의 프로퍼티와 다르다. 파일 자체이므로 이름만 저장하고 경로만 서버에 저장 -->
					<input type="file" class="form-control image_names" name="image_names">
<!-- 					<div class="input-group-append"> -->
<!-- 						<button type="button" class="btn btn-secondary btn-sm float-right inputRemove">&times;</button> -->
<!-- 					</div> -->
				</div>
			</div>		
		</div>
		<!-- 추가 이미지 끝 -->
		
		
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		
		<div class="btn-group my-4">
			<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
  			<button type="submit" class="btn btn-dark" id="writeBtn">등록</button>
 			<button type="reset" class="btn btn-light">초기화</button>
  			<button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
		</div>		
	</form>
</div>
</body>
</html>