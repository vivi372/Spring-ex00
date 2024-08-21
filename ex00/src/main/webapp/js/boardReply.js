/**
* 일반 게시판 댓글 처리 객체
*/

//이곳이 실행이 되는지 확인 할 수 있다.
console.log("Board Reply Module....");

//일반 게시판 댓글을 처리하는 객체 선언 - jquery의 ajax 사용 : ajax(),getJSON(),get(),post()
let replyService = {
	//실행할 함수 선언
	//일반 게시판 댓글 리스트 처리 함수
	"list":	function(page, callback, error) {
		console.log("댓글 리스트 실행");
		//페이지가 없으면 1로 세팅
		if(!page) page = 1; 
		//ajax 형태를 만들어 처리한다. - getJSON()
		$.getJSON(`/boardreply/list.do?no=${no}&page=${page}`,
			function(data){
				//데이터 가져오기를 성공하면 시행되는 함수. data는 서버에서 넘겨주는 JSON 데이터
				console.log(data);
				//callback이 있으면 실행 -> html를 만들어 출력
				if(callback) callback(data);
				
			}).fail(function(xhr,status,err){
				console.log("댓글 리스트 가져오기 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("댓글 데이터를 가져오는 중 오류 발생");
			});			
	},	
	//일반 게시판 댓글 등록 처리 함수	write(댓글객체, 성공함수, 실패 함수)
	"write": function(reply,callback,error) {
		console.log("댓글 등록 실행");
		
		$.ajax({
			type : "post", //데이터 전송 방식
			url : "/boardreply/write.do",
			data : JSON.stringify(reply), //서버에 전송되는 데이터
			contentType : "application/json;charset=UTF-8",
			success: function(data,status,err) {
				console.log(data);
				//callback이 있으면 실행
				if(callback) callback(data);
			},
			error : function(xhr,status,err){
				console.log("댓글 등록 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("댓글 등록하는 중 오류 발생");
			}
		})
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
