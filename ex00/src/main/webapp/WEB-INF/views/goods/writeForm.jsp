<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반게시판 글 쓰기 폼</title>

</head>
<body>
<div class="container">
	<h1>일반게시판 글 쓰기 폼</h1>
	<form action="/board/write.do" method="post" id="writeForm">
		<div class="form-group">
			<label for="title">제목</label> 
				<input type="text" class="form-control" placeholder="제목 입력" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">내용</label> 
				<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="writer">작성자</label> 
				<input type="text" class="form-control" placeholder="작성자 입력" id="writer" name="writer">
		</div>
		<div class="form-group">
			<label for="pw">비밀번호</label> 
				<input type="password" class="form-control" placeholder="비밀번호 입력" id="pw" name="pw">
		</div>
		<div class="form-group">
			<label for="pw2">비밀번호 확인</label> 
				<input type="password" class="form-control" placeholder="비밀번호 확인" id="pw2">
		</div>
		
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		
		<div class="btn-group">
			<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
  			<button type="submit" class="btn btn-dark" id="writeBtn">등록</button>
 			<button type="reset" class="btn btn-light">초기화</button>
  			<button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
		</div>		
	</form>
</div>
</body>
</html>