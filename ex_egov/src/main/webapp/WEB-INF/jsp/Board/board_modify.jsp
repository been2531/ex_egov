<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>게시판 수정</title>
<link rel="stylesheet" type="text/css" href="/stylesheet.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	function send(seulgi) {
		if (board.name.value == ''){
			alert("작성자를 입력해주세요");
			return false;
		}
		if (board.subject.value == ''){
			alert("제목을 입력해주세요");
			return false;
		}
		if (board.contents.value == ''){
			alert("내용을 입력해주세요");
			return false;
		}
		if (board.pass.value == ''){
			alert("비밀번호를 입력해주세요");
			return false;
		}

		var name = $('#name').val();
		var subject = $('#subject').val();
		var contents = $('#contents').val();
		var pass = $('#pass').val();
		var param = {"name":name, "subject":subject, "contents":contents, "pass":pass};
		$.ajax({
				url : '/Board/board_modify',
				type : 'POST',
				data : JSON.stringify(param),
				dataType : 'text',
				contentType: 'application/json',
				success : function(data) {
					if(data != null) {
						alert("게시글이 정상적으로 수정되었습니다.");
						location.href = "/Board/board_list?page=${page}";
					}else {
						alert("게시글이 수정되지 않았습니다.");
					}
				}
		});
	}
</script>
</head>
 <body topmargin="0" leftmargin="0">
 <table border="0" width="800">
 <tr>
   <td width="20%" height="500" bgcolor="#ecf1ef" valign="top">
   <!-- 다음에 추가할 부분 "-->
   </td>
   <td width="80%" valign="top">&nbsp;<br>
     <img src="/resources/img/bullet-01.gif"><font size="3" face="돋움" color="blue"> <b>자 유 게 시 판</b></font>
     <font size="2"> - 수정하기</font><p>
     <img src="/resources/img/bullet-03.gif"><font size="2" face="돋움" color="orange"> 잠깐</font> &nbsp;
     <img src="/resources/img/bullet-02.gif"><font size="2" face="돋움">는 필수 입력 사항입니다.</font><p>
     <form name="board" method="post" action="board_modify">
	   <input type="hidden" name="page" value="${page}">
	   <input type="hidden" name="idx" value="${vo.idx}">
       <table border="0">
       <tr>
         <td width="5%" align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td width="15%"><font size="2" face="돋움">글쓴이</font></td>
         <td width="80%">
         <input type="text" size="20" name="name" id="name" value="${vo.name}" readonly></td>
       </tr>
       <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">제목</font></td>
         <td><input type="text" size="60" name="subject" id="subject" value="${vo.subject}"></td>
       </tr>
       <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">내용</font></td>
         <td><textarea wrap="physical" rows="10" name="contents" id="contents" cols="60" >${vo.contents}</textarea></td>
       </tr>
       <tr>
         <td align="right"><img src="/resources/img/bullet-02.gif"></td>
         <td><font size="2" face="돋움">비밀번호</font></td>
          <td><input type="password" size="10" name="pass" id="pass">
		  <font size="2" face="돋움">*.수정과 삭제시 꼭 입력하셔야 합니다.</font></td>
        </tr>
        <tr>
          <td align="right">&nbsp;</td>
          <td><font size="2">&nbsp;</font></td>
          <td><a href="javascript:send()"><img src="/resources/img/edit2.gif" border=0></a>&nbsp;
          <a href="javascript:history.back()"><img src="/resources/img/cancle.gif" border=0></a></td></tr>
      </table>
      </form>
    </td></tr>
  </table>
  </body>
  </html>
