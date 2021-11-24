<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>게시판 작성</title>
<link rel="stylesheet" type="text/css" href="/css/stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	// 작성
	function send() { 
		var name = $('#name').val();
		var subject = $('#subject').val();
		var contents = $('#contents').val();
		var pass = $('#pass').val();
		var param = {"name":name, "subject":subject, "contents":contents, "pass":pass};
		 $.ajax({ 
				url : '/Board/board_write',
				type : 'POST',
				data : JSON.stringify(param),
				dataType : 'text',
				contentType: 'application/json',
				success : function(data) {
					if(data != null) {
						alert("게시글이 정상적으로 작성되었습니다.");
						location.href = "/Board/board_list?page=${page}";
					}else {
						alert("게시글이 작성되지 않았습니다.");
					}
				}
		});
	}
	
	// 초기화
	function reset(){
		$("#board_write_page")[0].reset();
	}
</script>

<!-- 업로드 -->
<script>
	function uploadFile(){
	    var form = $('#board_write_page')[0];
	    var formData = new FormData(form);
	    formData.append("fileObj", $("#filename")[0].files[0]);
	    $.ajax({
	        url: '/Board/upload',
	                processData: false,
	                contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	if(data != null) {
	                		alert("업로드가 성공하였습니다.");
	                	}else {
	                		alert("업로드를 실패하였습니다.");
	                	}
	                }
	        });
	}
</script>
	
<!-- 추가버튼 -->
<script>	
	$(function() {
		var maxAppend = 1;
		$('#_add').on('click',function(){ 
		   if(maxAppend >= 3){
		      return;
		   }else{
		       $('._up_ul').append("<div class='_con'><li class='_con _li'><input type='file'> <button type='button' id='_del'>삭제</button></li><div>");  
		       maxAppend ++;
		   }
		 });
	});
</script>

<!-- 삭제버튼 -->
<script type="text/javascript">
	$(function() {
		var removeCnt = 1;
		$('#_del').on('click', function() {
			if(removeCnt >= 3){
				return;
			}else {
				$('._con').remove('._li');
				removeCnt ++;
			}
		});
	});
</script>
 
<!-- 삭제버튼
<script type="text/javascript">
	$(function() {
		var data;
		$("#_del").on("click", function() {
			data = $(".container").detach();
		});
	});
</script>
 -->
</head>
<body topmargin="0" leftmargin="0">
 <table border="0" width="800">
 <tr>
   <td width="20%" height="500" bgcolor="#ecf1ef" valign="top">

   <!-- 다음에 추가할 부분 -->
   </td>

   <td width="80%" valign="top">&nbsp;<br>
     <img src="/resources/img/bullet-01.gif"><font size="3" face="돋움" color="blue"> <b>반갑습니다</b></font>
     <font size="2"> - 글쓰기</font><p>
     <img src="/resources/img/bullet-03.gif"><font size="2" face="돋움" color="orange"> 잠깐</font> &nbsp;
     <img src="/resources/img/bullet-02.gif"><font size="2" face="돋움">는 필수 입력 사항입니다.</font><p>
     
     <form name="board_write_page" id="board" method="post" action="board_write" enctype="multipart/form-data"> 
	 <input type="hidden" name="page" id="page" value="${page}">	 
	  <table border="0">
       <tr>
         <td width="5%" align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td width="15%"><font size="2" face="돋움">글쓴이</font></td>
         <td width="80%">
         <input type="text" size="20" name="name" id="name"></td>
       </tr>
	   <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">제목</font></td>
         <td><input type="text" size="60" name="subject" id="subject"></td>
       </tr>
       <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">내용</font></td>
         <td><textarea wrap="physical" rows="10" name="contents" id="contents" cols="60"></textarea></td>
       </tr>
	   <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">비밀번호</font></td>
          <td><input type="password" size="10" name="pass" id="pass"><font size="2" face="돋움">*.수정과 삭제시 꼭 입력하셔야 합니다.</font></td>
        </tr>
        
        <!-- 첨부파일 -->
       	<tr height="30px">
		  <td colspan="2" align="left"><img src="Pds/img/bullet-02.gif"><font size="2" face="돋움">파일</font></td>
		  <td>
		  <ul class="_up_ul">
			  <li id="_li" >
			  	  <input type="file" name="filename" id="filename">
			  	  <button type="button" id="_add">추가</button>
				  <button type="button" id="_del">삭제</button>
			  </li>
		  </ul>
		  </td>
	    </tr>
		<tr>
          <td align="right">&nbsp;</td>
          <td><font size="2">&nbsp;</font></td>
          <td>
             <br><input type="button" value="작성" onclick="send()">
			 <input type="button" value="초기화" onclick="reset()">
			 <input type="button" value="뒤로가기" onclick="javascript:history.back()">
          </td>
        </tr>
      </table>
      </form>
    </td>
  </tr>
  </table>
  </body>
  </html>
