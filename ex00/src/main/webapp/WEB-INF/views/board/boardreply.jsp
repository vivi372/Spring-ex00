<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<div class="row my-3">
	<div class="col-lg-12">		
		<div class="card replyCard">
			<!-- 댓글 제목 -->
			<div class="card-header" style="background: #e0e0e0">
				<button class="btn btn-sm btn-dark float-right modalBtn" data-toggle="modal" data-target="#replyModal">댓글 등록</button>
				<i class="fa fa-comments fa-fw"></i> Reply
			</div>
			
			<!-- 댓글 리스트 데이터 출력 -->
			<div class="card-body">
				<ul class="chat">
					<!-- 데이터 한개당 li 태그가 생긴다. -->
					<!-- js로 생성 -->
				</ul>
			</div>			
			
			<div class="card-footer">
				<div class="pagination justify-content-center pageNav">
					
				</div>
			
			</div>
			
		</div>
	</div>
</div>

<!-- The Modal -->
<div class="modal" id="replyModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 등록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<span id="modalMsg"></span>
      	<input id="rno" name="rno" type="hidden">
      	<div class="form-group contentGroup">
    		<label for="content">내용:</label>    
      		<textarea rows="5" cols="" class="form-control" id="content" name="content"></textarea>
  		</div>        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" id="replyBtn">등록</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>