<%@page import="db.reviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	reviewBean rb=(reviewBean)request.getAttribute("rb");
	String imgpageNum=(String)request.getAttribute("imgpageNum");
	String noimgpageNum=(String)request.getAttribute("noimgpageNum");
	
	//검색목록으로 다시 돌아가기 위한 몸부림. 이값들이  null이 아니면 검색목록으로 돌아가기 버튼을 보여줌.
	String searchimgpageNum=(String)request.getAttribute("searchimgpageNum");
	String searchnoimgpageNum=(String)request.getAttribute("searchnoimgpageNum");
	String search = (String)request.getAttribute("search");
	String menu = (String)request.getAttribute("menu");
%>
<body>

	<h3><%=rb.getSubject()%></h3>
		<div>
		<table>
			<tr>
				<td>조회수</td><td><%=rb.getCount() %></td>
				<td>작성자</td><td><%=rb.getName() %></td>
				<td>작성일</td><td><%=rb.getDate() %></td>
			</tr>
			<% if(rb.getImg()!=null){				
					String imgname = rb.getImg();
					String[] array = imgname.split("@@");
					for(int i=0;i<array.length;i++){
			%>	
			<tr>								
				<td colspan="3">				
					<img src="http://localhost:8090/TeamProject/image/<%=array[i]%>">				
				<td>
			</tr>
			<%
					}
				}
			%>
			<tr>
				<td>글내용</td><td colspan="3"><%=rb.getContent()%></td>
			</tr>
		</table>
		</div>
		<div>
		<%
		String id=(String)session.getAttribute("id");
		if(id!=null){
			if(id.equals(rb.getId())){
		%>
		<input type="button" value="글수정"
		 onclick="location.href='./reviewUpdate.so?num=<%=rb.getNum()%>&imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">
		<input type="button" value="글삭제"
		 onclick="location.href='./reviewDelete.so?num=<%=rb.getNum()%>&imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">		
		<%
			}
			if(id.equals(rb.getSellId())){
		%>
		<input type="button" value="댓글쓰기" onclick="">
		  <form id="cft" style="display: none;" name="crf" 
				action="" 
				method="post" onsubmit="return ckgoreWrite();">
					<table class="table">
						<tr>
							<td>글쓴이</td>
							<td><input type="text" name="name" value="${name}" 
							readonly="readonly"></td>
						</tr>					
						<tr>
							<td>글내용</td>
							<td><textarea name="content" rows="7" cols="40" 
							style="resize:none;"></textarea></td>
						</tr>
					</table>
					<input type="submit" value="댓달기">
					<input type="reset" value="취소" onclick="history.go(0)">
				</form>
		<%
			}
		}
			if(search==null){			
		%>
		<input type="button" value="목록보기"
		   onclick="location.href='./reviewList.so?imgpageNum=&imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">
		</div>
		<%
			}else if(search!=null){
		%>
		<input type="button" value="전체목록보기"
				   onclick="location.href='./reviewList.so'">
			
		<input type="button" value="검색목록으로 돌아가기"
					onclick="location.href='./reviewListSearch.so?searchimgpageNum=<%=searchimgpageNum%>&searchnoimgpageNum=<%=searchnoimgpageNum%>&search=<%=search%>&menu=<%=menu%>'">	   
		</div>		
				
		<%		
			}			
		%>

</body>
</html>