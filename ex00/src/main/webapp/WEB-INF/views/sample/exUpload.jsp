<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	let json = {"주문 번호":1,"주문 상품":"테스트 주문"};
	console.log(typeof json);
	let strJson = JSON.stringify(json);
	console.log(strJson);
	let baseStrJson = utf8_to_b64(strJson);
	console.log(baseStrJson);
	let deBaseStrJson = b64_to_utf8(baseStrJson);
	console.log(deBaseStrJson);
	
	function utf8_to_b64( str ) {
	  return window.btoa(unescape(encodeURIComponent( str )));
	}

	function b64_to_utf8( str ) {
	  return decodeURIComponent(escape(window.atob( str )));
	}
		
</script>
</head>
<body>

<form action="/sample/exUploadPost2" method="post" enctype="multipart/form-data">
	<input type="file" name="files" multiple>
	<button>등록</button>

</form>

</body>
</html>