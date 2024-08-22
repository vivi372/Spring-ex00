/**
 * replyService를 이용한 댓글 처리
 */
 function showList(page) {
	 replyService.list(page,
	 	//데이터 가져오기 성공했을 함수
	 	(data) => {
	 		//data의 구조 - {list[],pageObject}
			let listTag = ``;
			//data에서 list[]만 가져오기
			let list = data.list;
			
			//해당 글의 댓글이 없을때 처리
			if(list == null || list.length ==0){			
					$(".chat").html("<b>데이터가 없어용 ㅠㅠ</b>");
				return;
			}
			
			
			//오늘 날짜 가져온 후 문자열 형태로 변환
			let today = new Date();
			let yy=today.getFullYear();
	 		let mm=today.getMonth()+1;
	 		let dd=today.getDate();
	 	
	 		let strToday = yy+"-"+(mm>9?'':'0')+mm+"-"+(dd>9?'':'0')+dd
			
			
			//console.log(strToday);
			//list[] - 반복
			$(list).each(function(i){
				//console.log(this);		
				//날짜에 따른 시간,날짜 표시
				//댓글 날짜 시간과 날짜로 분리 writeDateSplit[0]:날짜 writeDateSplit[1]:시간
				let writeDateSplit = this.writeDate.split(" ");
				let writeDate;			
				//날짜가 오늘가 같으면 댓글 날짜를 시간으로 아니면 날짜로 바꾼다.
				if(writeDateSplit[0]==strToday) writeDate = writeDateSplit[1];
				else writeDate = writeDateSplit[0];
				//댓글의 데이터를 가져온후 ``을 이용해 <li>태그로 생성
				listTag += `<li class="left clearfix" data-rno="${this.rno}">
							<div>
								<div class="header">
									<strong class="primary-text">${this.name}(${this.id})</strong>
									<small class="pull-right text-muted">${writeDate}</small>
								</div>`;
				//현재 로그인된 아이디와 댓글 쓴 사람의 아이디가 같으면 수정,삭제 버튼 생성 
				if(id == this.id)
					listTag += `<button class="btn btn-sm btn-secondary float-right modalBtn" data-toggle="modal" data-target="#replyModal">댓글 수정</button>
								<button class="btn btn-sm btn-outline-secondary float-right modalBtn" data-toggle="modal" data-target="#replyModal">댓글 삭제</button>`
				listTag +=	`<p><pre class="replyContent">${this.content}</pre></p>
									<hr>
								</div>
							</li>`;
			});	
			//		$(".chat")안에 태그로 치환
			$(".chat").html(listTag);
			
			
			
			//페이지네이션 생성
			//페이지 오브젝트 꺼내기
			let pageObject = data.pageObject;
			//서버에서 넘어온 페이지 정보를 전역 변수 replyPage에 입력
			replyPage = pageObject.page;
			//util에 존재하는 페이지네이션 생성하는 replyPagenation함수 실행
			replyPagenation(pageObject,".pageNav");
				
		}
	 );
 };
 
 //일반 게시판 글보기가 처음에 보여질때 댓글 리스트 보이기 실행 
 showList(replyPage);
 
 

//HTML이 로딩이 된 상태에서 실행	
$(function(){	
	
	//페이지네이션 클릭 처리
	$(".pageNav").on("click",".page-link", function() {
		showList($(this).data("page"));
		return false;
	});

	//모달 등장 처리
	//모달 등장 버튼 클릭 이벤트
	//버튼이나 댓글의 데이터는 동적생성된 태그이기 때문에 $(document).on 사용
	$(".replyCard").on("click",".modalBtn",function() {
		//클릭된 .modalBtn 버튼의 텍스트 가져온다(댓글 등록,댓글 수정,댓글 삭제)
		let btnText =  $(this).text();
		//console.log(btnText);
		//replyModal의 타이틀과 모달 버튼의 텍스트 변경
		$("#replyModal .modal-title").text(btnText);
		$("#replyModal #replyBtn").text(btnText);
		//댓글 등록 버튼 클릭시
		if(btnText == "댓글 등록") {
			//수정에만 필요한 rno input 태그 비우기
			$("#replyModal #rno").val("");
			//내용 입력 태그 보이기
			$("#replyModal .contentGroup").show();
			//모달 문구 삭제
			$("#replyModal #modalMsg").text("");
		//댓글 수정 버튼 클릭시
		} else if(btnText == "댓글 수정") {
			//해당 댓글의 데이터 가져오기
			let rno = $(this).closest("li").data("rno");
			let replyContent = $(this).closest("li").find(".replyContent").text();
			//console.log("1"+replyContent);
			//내용 입력 태그 보이기
			$("#replyModal .contentGroup").show();
			//모달 문구 삭제
			$("#replyModal #modalMsg").text("");
			//데이터 input 태그에 입력
			$("#replyModal #rno").val(rno);
			$("#replyModal #content").val(replyContent);
		//댓글 삭제 버튼 클릭시
		} else if(btnText == "댓글 삭제") {
			//해당 댓글의 데이터 가져오기
			let rno = $(this).closest("li").data("rno");			
			//console.log("1"+replyContent);
			//내용 입력 태그 숨기기
			$("#replyModal .contentGroup").hide();
			//삭제전 확인
			$("#replyModal #modalMsg").text("정말 삭제하시겠습니까?");
			//데이터 input 태그에 입력
			$("#replyModal #rno").val(rno);			
		} 
	}); 
 
	
	//이벤트 처리	
	//댓글 모달 버튼 클릭
	$("#replyBtn").click(function() {
		//모달 타이틀을 이용해 조건을 걸기 위해 모달 타이틀 가져오기
		let modalTitle = $("#replyModal .modal-title").text();
		//댓글 등록일때
		if(modalTitle == "댓글 등록") {
			//등록에 필요한 데이터 수집
			let reply = {
					"no" : no,
					"content" : $("#content").val(),
			};
			//console.log(reply);
			//댓글 등록 실행
			replyService.write(reply, function(data){
				//댓글 등록후 모달창 닫기
				$("#replyModal").modal("hide");
				//alert(data);
				//사용자에게 알림을 위해 디폴트 데코레이터에 있는 msgModal사용
				let $msgModal = $("#msgModal");
				//서버에서 보낸 문자열 모달에 출력
				$msgModal.find("#msg").text(data);
				$msgModal.modal("show");
				//등록후 댓글 리스트 새로 출력
				showList(1);
			});		
		//댓글 수정일때
		} else if(modalTitle == "댓글 수정") {
			//수정에 필요한 데이터 수집
			let reply = {				
				"rno" : $("#rno").val(),
				"content" : $("#content").val(),
			};
			//console.log(reply);
			replyService.update(reply, function(data){ //성공 함수
				//댓글 수정후 모달창 닫기
				$("#replyModal").modal("hide");
				//alert(data);
				//사용자에게 알림을 위해 디폴트 데코레이터에 있는 msgModal사용
				let $msgModal = $("#msgModal");
				//서버에서 보낸 문자열 모달에 출력
				$msgModal.find("#msg").text(data);
				$msgModal.modal("show");
				//수정후 댓글 리스트 새로 출력
				showList(replyPage);
			});		
		//댓글 삭제일때
		} else if(modalTitle == "댓글 삭제") {
			//삭제에 필요한 데이터 수집
			let reply = $("#rno").val();
			//console.log(reply);
			replyService.delete(reply, function(data){
				//댓글 삭제후 모달창 닫기
				$("#replyModal").modal("hide");
				//alert(data);
				//사용자에게 알림을 위해 디폴트 데코레이터에 있는 msgModal사용
				let $msgModal = $("#msgModal");
				//서버에서 보낸 문자열 모달에 출력
				$msgModal.find("#msg").text(data);
				$msgModal.modal("show");
				//삭제후 댓글 리스트 새로 출력
				showList(1);
			});		
		}
		
	});
});
 