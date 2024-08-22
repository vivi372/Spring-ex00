/**
 * JS 유틸리티 프로그램
 * 댓글 페이지네이션	
 *
 */
 
 
function replyPagenation(pageObject,$pageNav) {
	let pageNav = `
					<ul class="pagination pagination-sm">
				`;
	//disabled 추가 여부 - 이전 페이지가 없으면 disabled로 한다
	//onclick를 이용해 이벤트 처리를 한다.
	if(pageObject.startPage == 1) {
		pageNav += `<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>`
	} else {
		//이전 페이지 스택으로 넘어가기
		pageNav += `<li class="page-item"><a class="page-link" href="#" data-page="${pageObject.startPage-1}"'>Previous</a></li>`
	}
	//반복문으로 endPage까지 반복하여 페이지 태그 생성.
	for(let i=pageObject.startPage;i<=pageObject.endPage;i++){
		//현재 페이지와 같으면 active 추가
		if(i == pageObject.page) pageNav += `<li class="page-item active"><a class="page-link" href="#" data-page="${i}" onclick='return false'>${i}</a></li>`
		else pageNav += `<li class="page-item"><a class="page-link" href="#" data-page="${i}">${i}</a></li>`
	}		
	//disabled 추가 여부 - 현재 페이지가 엔드 페이지면 disabled로 한다
	if(pageObject.endPage == pageObject.totalPage) {
		pageNav += `<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>`
	} else {
		//다음 페이지 스택으로 넘어가기
		pageNav += `<li class="page-item"><a class="page-link" href="#" data-page="${pageObject.endPage+1}">Next</a></li>`
	}	
	pageNav += `</ul>`	
	//페이지네이션 생성
	$($pageNav).html(pageNav);
}
 