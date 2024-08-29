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

</style>

<script type="text/javascript">
	$(function() {		
		$("#cate_code1Name").text($(".nav-tabs .active").text());
		
		
		$(".nav-tabs .active").click(function() {
			return false;
		});
		
		$(".nav-link").contextmenu(function(e) {
			e.preventDefault(); //오른쪽 마우스 메뉴 나타남 방지
			alert("대분류 수정이나 삭제"+$(this).data("cate_code1"));
			
		});
	});		
</script>
</head>
<body>
	<div class="container">
		
	
		<div class="card">
			<div class="card-header"><h2>카테고리 관리</h2></div>
			<div class="card-body">
				<p>
					#대분류 탭을 수정하거나 삭제하려면 우클릭하세요.
				</p>
				 <!-- Nav tabs -->
				<ul class="nav nav-tabs">
				
					<c:forEach items="${bigList }" var="vo">
						<li class="nav-item">
							<a class="nav-link ${vo.cate_code1 == (param.cate_code1==null?1:param.cate_code1)?'active':'' }" 
							href="list.do?cate_code1=${vo.cate_code1 }" data-cate_code1=${vo.cate_code1 }>${vo.cate_name }</a>
						</li>
					</c:forEach>
						<li class="nav-item">
							<a class="nav-link text-dark"><i class="fa fa-plus"></i></a>
						</li>
					
				</ul>

  				<!-- Tab panes -->
				<div class="tab-content">
			    	<div id="mid_category" class="container tab-pane active"><br>
			    		<button class="float-right btn btn-dark btn-sm">add</button>
			      		<h3 id="cate_code1Name"></h3>
			      		<ul class="list-group">
			      			<c:forEach items="${midList }" var="vo">
			      				<li class="list-group-item">
			      				${vo.cate_name }
			      				<span class="pull-right">
			      					<button class="btn btn-secondary btn-sm">수정</button>
			      					<button class="btn btn-dark btn-sm">삭제</button>
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
	
</body>
</html>