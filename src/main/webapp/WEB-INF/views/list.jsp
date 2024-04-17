<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="resources/css/common.css" type ="text/css">
<style>
img.icon{
	width:15px;
	height:15px;
}
</style>
</head>
<body>
	게시판리스트
	<hr/>
	<button onclick="del()">선택 삭제</button>
	<table>
	<thread>
	<tr>
		<th><input type="checkbox" id="all" onclick="checkAll()"/></th>
		<th>글번호야</th>
		<th>이미지</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>등록일</th>
	</tr>
	</thread>
	<tbody id="list">
	
	</tbody>
	<!--  
	<c:if test = "${list.size()<1}">
		<tr><td colspan="6">작성된 게시글이 없습니다.</td></tr>
	</c:if>
	<c:forEach items="${list}" var="bbs">
		<tr>
			<td><input type="checkbox" name="del" value="${bbs.idx }"/></td>
			<td>${bbs.idx}</td>
			<td>
			<c:if test="${bbs.img_cnt > 0 }"><img class="icon" src="resources/img/YesImg.png"/></c:if>
			<c:if test="${bbs.img_cnt == 0 }"><img class="icon" src="resources/img/Nomage.png"/></c:if>
			</td>
			<td><a href="detail?idx=${bbs.idx}">${bbs.subject}</a></td>
			<td>${bbs.user_name}</td>
			<td>${bbs.bHit}</td>
			<td>${bbs.reg_date}</td>
		</tr>
	</c:forEach>
	-->
</table>
</body>
<script>
	//옛날에는 스크립트를 헤더쪽으로 넣었기때문에..
	//위에서 읽을게 너무많아 나머지 내용들이 읽히는데 오래걸려서
	//html이 읽히고 다른것들이 읽히도록 document.ready를 사용했지만
	//요즘은 그냥 스크립트자체를 body 아래에 두는걸로 해결한다.. 
	//style태그를 위에두는 이유는.. 옷입고오는 느낌..?!;; 
	$(document).ready(function(){	//html 문서가 모두 읽히고나면 (준비되면) 다음 내용을 실행하라.
		listCall();
	});

	function listCall(){
		//왔으면 요청한다.
		$.ajax({
			type : 'get',
			url : './list.ajax',
			data : {

			},
			dataType:'json',
			success : function(data) {
				drawList(data.list);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	
	function drawList(list){
		var content = '';
		
		for (bbs of list) {
			console.log(bbs);
			content+='<tr>';
			content+='<td><input type="checkbox" name="del" value="'+bbs.idx+'"/></td>';
			content+='<td>'+bbs.idx+'</td>';
			content+='<td>';
			
			var img = bbs.img_cnt > 0? 'YesImg.png': 'Nomage.png';
			content+='<img class="icon" src="resources/img/'+img+'"/>';	
	
			content+='</td>';
			content+='<td>'+bbs.subject+'</td>';
			content+='<td>'+bbs.user_name+'</td>';
			content+='<td>'+bbs.bHit+'</td>';
			
			//java.sql.Date는 javascipt에서는 밀리세컨드로 변환해서 표시한다.
			//방법 1. Back-end-DTO의 반환날짜 타입을 문자열로 변경
			//방법 2. Front-end-js에서 직접 변환
			//content+='<td>'+bbs.reg_date+'</td>';
			var date = new Date(bbs.reg_date);
			var dateStr = date.toLocaleDateString("ko-KR"); //en-US
			
			content+='<td>'+dateStr+'</td>';
			
			content+='</tr>';
		}
		
		$('#list').html(content);
	}

	function checkAll(){
		// attr : 정적속성 : 처음부터 그려져 있거나 jsp에서 그린 내용
		// prop : 동적속성 : 자바스크립트로 나중에 그려진 내용
		if($('input[id="all"]').is(':checked')) {
			$('input[name="del"]').prop("checked", true);
		} else {
			$('input[name="del"]').prop("checked", false);
		}
	}
	
	//체크표시된 value값을 delArr에 담기
	function del(){
		var delArr=[];
		$('input[name="del"]').each(function(idx,item){
			if($(item).is(":checked")){
				var checkis = $(this).val();
				delArr.push(checkis);
			}
		});
		console.log("delArr:{}",delArr);
		
		$.ajax({
			type:'post',
			url:'./del',
			data:{
				delList:delArr
			},
			dataType:'JSON',
			success:function(data){
				if(data.cnt> 0){
					alert('선택하신'+data.cnt+'개의 글이 삭제되었습니다.');
					$('#list').empty();
					listCall();
				}
			},
			error:function(error){
				console.log(error);
			}
		});
	}
	
</script>
</html>