<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>

<style type="text/css">
.nav-tabs .active:hover{
	cursor: default;
}
.editDiv {
	display: none;
}

</style>

 

<script type="text/javascript">
	$(function() {		
		$("#cate_code1Name").text($(".nav-tabs .active .cate_name").text());
		
		
		$(".nav-tabs .active").click(function() {
			return false;
		});
		
		
		
		//대분류 추가 버튼
		$("#bigWriteBtn").click(function() {
			//alert("대분류 추가");
			categoryProcess("대분류 추가","추가",0,0,"","write.do");
		});
		
		//중분류 추가 버튼
		$("#midWriteBtn").click(function() {
			let cate_code1 = $(this).closest("#mid_category").data("cate_code1");
			//alert("중분류 추가 "+cate_code1);			
			categoryProcess("중분류 추가","추가",cate_code1,0,"","write.do");
		});
		
		//대분류 수정 삭제 버튼 등장 이벤트
		$(".cate_edit").on("click", function() {			
			//수정 삭제 버튼이 안 보일때 - 버튼이 나타나야 한다.
			if($(this).next().css("display") == "none") {
				//전체 editDiv는 안 보이게 
				$(".editDiv").slideUp();
				//버튼이 나타나게
				$(this).next().slideDown();
				//수정 삭제 버튼이 보일때 - 버튼이 사라져야 한다.
			} else {
				//전체 editDiv는 안 보이게 
				$(".editDiv").slideUp();
				//버튼이 사라지게
				//$(this).next().slideUp();
			}
			return false; // a tag이 페이지 이동 처리를 무시시킨다.
		});
		
		//카테고리 대분류 수정
		$(".bigUpdateBtn").on("click", function() {
			let cate_code1 = $(this).closest(".nav-link").data("cate_code1");
			let cate_name = $(this).parent().siblings(".cate_name").text();
			//alert("카테고리 대분류 수정 "+cate_name);			
			
			categoryProcess("대분류 수정","수정",cate_code1,0,cate_name,"update.do");
			return false; // a tag이 페이지 이동 처리를 무시시킨다.
		});
		
		//카테고리 중분류 수정
		$(".midUpdateBtn").on("click", function() {
			let $listGroupItem = $(this).closest(".list-group-item");
			let cate_code1 = $(this).closest("#mid_category").data("cate_code1");
			let cate_code2 = $listGroupItem.data("cate_code2");
			let cate_name = $listGroupItem.find(".cate_name").text();
			//alert("카테고리 대분류 수정 "+cate_name);			
			
			categoryProcess("중분류 수정","수정",cate_code1,cate_code2,cate_name,"update.do");
		});
		
		//카테고리 대분류 삭제
		$(".bigDeleteBtn").on("click", function() {
			if(confirm("정말로 삭제 하시겠습니까?")) {
				let cate_code1 = $(this).closest(".nav-link").data("cate_code1");			
				let cateDeleteForm = `
					<form action="delete.do" id="deleteForm" method="post">
						<input name="cate_code1" value="\${cate_code1}" type="hidden">
						<input name="cate_code2" value="0" type="hidden">
					</form>			
				`;			
				$(".container").append(cateDeleteForm);			
				$("#deleteForm").submit();
			}
			return false; // a tag이 페이지 이동 처리를 무시시킨다.
		});
		//카테고리 중분류 삭제
		$(".midDeleteBtn").on("click", function() {
			if(confirm("정말로 삭제 하시겠습니까?")) {
				let cate_code1 = $(this).closest("#mid_category").data("cate_code1");
				let cate_code2 = $(this).closest(".list-group-item").data("cate_code2");
				let cateDeleteForm = `
					<form action="delete.do" id="deleteForm" method="post">
						<input name="cate_code1" value="\${cate_code1}" type="hidden">
						<input name="cate_code2" value="\${cate_code2}" type="hidden">
					</form>			
				`;			
				$(".container").append(cateDeleteForm);			
				$("#deleteForm").submit();
			}
		});
		
		
		//모달창 닫을때 초기화
		$("#categoryModal").on("hidden.bs.modal", function() {
			//입력 란 초기화
			$("#modalCate_code1").val(0); 
			$("#modalCate_code2").val(0);
			$("#modalCate_name").val("");
			
			$("#categoryModalForm").removeAttr("action");
		});
		
		$("#categoryModal").draggable();
		
// 		$(".nav-link").contextmenu(function(e) {
// 			e.preventDefault(); //오른쪽 마우스 메뉴 나타남 방지
// 			alert("대분류 수정이나 삭제"+$(this).data("cate_code1"));
			
// 		});

		function categoryProcess(title,btnName,cate_code1,cate_code2,cate_name,url) {
			//제목 변경
 			$("#categoryModal .modal-title").text(title);
			//버튼 이름 바꾸기
 			$("#categoryModal #submitBtn").text(btnName);
			//입력란 데이터 입력
 			$("#modalCate_code1").val(cate_code1);
 			$("#modalCate_code2").val(cate_code2);
 			$("#modalCate_name").val(cate_name);
 			
 			
			//submit 이동할 곳 지정
			$("#categoryModalForm").attr("action",url);
			//모달창 보여주기
			$("#categoryModal").modal("show");
		}
	});	
</script>
</head>
<body>
	<div class="container">
		
	
		<div class="card">
			<div class="card-header"><h2>카테고리 관리</h2></div>
			<div class="card-body">
<!-- 				<p> -->
<!-- 					#대분류 탭을 수정하거나 삭제하려면 우클릭하세요. -->
<!-- 				</p> -->
				 <!-- Nav tabs -->
				<ul class="nav nav-tabs">
				
					<c:forEach items="${bigList }" var="vo">
						<li class="nav-item">
							<a class="nav-link ${vo.cate_code1 == (param.cate_code1==null?1:param.cate_code1)?'active':'' }" 
							href="list.do?cate_code1=${vo.cate_code1 }" data-cate_code1=${vo.cate_code1 }>
							<span class="cate_name">${vo.cate_name }</span>
							&nbsp;&nbsp;
							<i class="fa fa-edit cate_edit" style="cursor: pointer;"></i>	
							<div class="editDiv">
								<button class="btn btn-secondary btn-sm bigUpdateBtn">수정</button>			
								<button class="btn btn-dark btn-sm bigDeleteBtn">삭제</button>	
							</div>	
							</a>
						</li>
						
					</c:forEach>
						<li class="nav-item">
							<a class="nav-link text-dark" id="bigWriteBtn" style="cursor: pointer;">
								<i class="fa fa-plus"></i>							 
							</a>
						</li>						
				</ul>
				

  				<!-- Tab panes -->
				<div class="tab-content">
			    	<div id="mid_category" class="container tab-pane active" 
			    	data-cate_code1=${param.cate_code1==null?1:param.cate_code1 }><br>
			    		<button class="float-right btn btn-dark btn-sm" id="midWriteBtn">add</button>
			      		<h3 id="cate_code1Name"></h3>
			      		<ul class="list-group">
			      			<c:forEach items="${midList }" var="vo">
			      				<li class="list-group-item" data-cate_code2=${vo.cate_code2 }>
			      				<span class="cate_name">${vo.cate_name }</span>			      				
			      				<span class="pull-right">
			      					<button class="btn btn-secondary btn-sm midUpdateBtn">수정</button>
			      					<button class="btn btn-dark btn-sm midDeleteBtn">삭제</button>
			      				</span>
			      				</li>
			      			</c:forEach>  							
						</ul>
			    	</div>
			  	</div>
			</div>
			<div class="card-footer">Footer</div>
		</div>
	</div>
	
	
	<!-- The Modal -->
	<div class="modal" id="categoryModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	
		      	<!-- Modal Header -->
		      	<div class="modal-header">
		        	<h4 class="modal-title">카테고리 관리</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
				<form method="post" id="categoryModalForm">
					<input name="cate_code1" value="0" type="hidden" id="modalCate_code1">
					<input name="cate_code2" value="0" type="hidden" id="modalCate_code2">
			     	<!-- Modal body -->
			      	<div class="modal-body">
			        	<input class="form-control" name="cate_name" id="modalCate_name" placeholder="카테고리 이름 입력">
			      	</div>
			
			      	<!-- Modal footer -->
			      	<div class="modal-footer">
			        	<button class="btn btn-dark" id="submitBtn">처리</button>
			        	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			      	</div>
				</form>
	    	</div>
		</div>
	</div>
	
	
</body>
</html>