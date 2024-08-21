/**
 * replyService를 이용한 댓글 처리
 */
 function showList(page) {
	 replyService.list(page,
	 	//데이터 가져오기 성공했을 함수
	 	(data) => {
	 		//data의 구조 - {list[],pageObject}
			let listTag = ``;
			let list = data.list;
			
			if(list == null || list.length ==0){			
					$(".chat").html("<b>데이터가 없어용 ㅠㅠ</b>");
				return;
			}
			
			let today = new Date();
			let yy=today.getFullYear();
	 		let mm=today.getMonth()+1;
	 		let dd=today.getDate();
	 	
	 		let strToday = yy+"-"+(mm>9?'':'0')+mm+"-"+(dd>9?'':'0')+dd
			
			
			//strToday = "2024-08-19";
			//console.log(strToday);
			$(list).each(function(i){
				//console.log(this);		
					
				let writeDateSplit = this.writeDate.split(" ");
				let writeDate;			
				if(writeDateSplit[0]==strToday) writeDate = writeDateSplit[1];
				else writeDate = writeDateSplit[0];
				
				listTag += `<li class="left clearfix" data-rno="${this.rno}">
							<div>
								<div class="header">
									<strong class="primary-text">${this.name}(${this.id})</strong>
									<small class="pull-right text-muted">${writeDate}</small>
								</div>
								<p><pre>${this.content}</pre></p>
								<hr>
							</div>
						</li>`;
			});			
			$(".chat").html(listTag);
		}
	 );
 };
 
 //일반 게시판 글보기가 처음에 보여질때 댓글 리스트 보이기 실행 
 showList(replyPage);
 
//HTML이 로딩이 된 상태에서 실행	
$(function(){
	
	//이벤트 처리
	$("#replyWriteBtn").click(function() {
		let reply = {
				"no" : no,
				"content" : $("#content").val(),
		};
		//console.log(reply);
		replyService.write(reply, function(data){
			$("#replyModal").modal("hide");
			//alert(data);
			let $msgModal = $("#msgModal");
			$msgModal.find("#msg").text(data);
			$msgModal.modal("show");
			showList(replyPage);
		});
	});
});
 