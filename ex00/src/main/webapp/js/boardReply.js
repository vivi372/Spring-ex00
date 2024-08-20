/**
* 일반 게시판 댓글 처리 객체
*/

//이곳이 실행이 되는지 확인 할 수 있다.
console.log("Board Reply Module....");

//일반 게시판 댓글을 처리하는 객체 선언 - jquery의 ajax 사용 : ajax(),getJSON(),get(),post()
let replyService = {
	//실행할 함수 선언
	//일반 게시판 댓글 리스트 처리 함수
	"list":	function(page) {
		console.log("댓글 리스트 실행");
		//페이지가 없으면 1로 세팅
		if(!page) page = 1; 
		//ajax 형태를 만들어 처리한다. - getJSON()
		$.getJSON(`/boardreply/list.do?no=${no}&page=${page}&perPageNum=15`,function(data){
			//데이터 가져오기를 성공하면 시행되는 함수. data는 서버에서 넘겨주는 JSON 데이터
			console.log(data);
				
			let list = `<ul class="list-group mt-3">`;
			
			$(data.list).each(function(i){
				console.log(this);
				list += `<li class="list-group-item">
						
						<span class="float-right">
							${this.writeDate }	
						</span>
						<span>${this.name}(${this.id})</span><br>
						<pre>${this.content}</pre>
					</li>`;
			});	
			list += `</ul>`
			$("#reply").html(list);
				
		});			
	},	
	//일반 게시판 댓글 등록 처리 함수	write(댓글객체, 성공함수, 실패 함수)
	"write": function(reply,callback,error) {
		console.log("댓글 등록 실행");
	},
	//일반 게시판 댓글 수정 처리 함수 update(댓글객체, 성공함수, 실패 함수)
	"update": function(reply,callback,error) {
		console.log("댓글 수정 실행");
	},
	//일반 게시판 댓글 삭제 처리 함수 delete(댓글객체, 성공함수, 실패 함수)
	"delete": function(reply,callback,error) {
		console.log("댓글 삭제 실행");
	},	
}
