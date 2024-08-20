/**
 * 
 */
 
 //날짜로 표시하는 처리
 //timeStemp: Long 타입의 시간 정보 데이터
 function toDate(timeStemp,separChar) {
 	if(!separChar) separChar = "-";
 	
 	
 	let dateObj = new Date(timeStemp);
 	
 	
 	let yy=dateObj.getFullYear();
 	let mm=dateObj.getMonth()+1;
 	let dd=dateObj.getDate();
 	
 	return yy+separChar+(mm>9?'':'0')+mm+separChar+(dd>9?'':'0')+dd; 	
 }
 
 //시간으로 표시하는 처리
 //timeStemp: Long 타입의 시간 정보 데이터
 function toTime(timeStemp) {
 	let dateObj = new Date(timeStemp); 
 		
 	let hh=dateObj.getHours();
 	let mm=dateObj.getMinutes();
 	let ss=dateObj.getSeconds();
 	
 	return (hh>9?'':'0')+hh+':'+(mm>9?'':'0')+mm+':'+(ss>9?'':'0')+ss; 	
 }
 
 //날짜와 시간 표시하는 처리
 //24시간이 지나지 않았으면 시간을 지났으면 날짜를 표시한다.
 function toDateTime(timeStemp) {
 	let today = new Date();
 	
 	let gap = today.getTime() - timeStemp;
 	
 	if(gap < (1000*60*60*24)) {
 		return toTime(timeStemp);
 	} else {
 		return toDate(timeStemp);
 	}
 }
 