<%@page import="db.reviewBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	우선 리뷰 게시판
	해더,푸터 그대로 쓰고
	1.가운데 리뷰게시판,,, 리뷰에 사진리뷰, 일반게시글 리뷰 다 넣어야됨.
	2.그리고 따로 분류해줘야됨 리뷰게시판.가운데 레이아웃 넣고 하나하나.  
	3.페이징처리 해줘야 되고...
	4.목록으로 나오는게 게시자,제목이나 게시글내용.. 
	5.사진사이즈 작게 나오고.
	.. 글쓰기 해야 되고 글삭제 해야되고...   
	지금 세션에 id랑 닉네임이랑 포인트 있는 상태.
	리뷰쓰면 포인트 제공해야됨. 5포인트.
	
 -->
<%	
	request.setCharacterEncoding("UTF-8");
	//글만있는친구들
	int imgcount=((Integer)request.getAttribute("imgcount")).intValue();
	List<reviewBean> imgboardList
		=(List<reviewBean>)request.getAttribute("imgreviewboardList");
	String imgpageNum=(String)request.getAttribute("imgpageNum");
	int imgpageCount=((Integer)request.getAttribute("imgpageCount")).intValue();
	int imgstartPage=((Integer)request.getAttribute("imgstartPage")).intValue();
	int imgendPage=((Integer)request.getAttribute("imgendPage")).intValue();
	
	//사진리뷰친구들
	int noimgcount=((Integer)request.getAttribute("noimgcount")).intValue();
	List<reviewBean> noimgboardList
		=(List<reviewBean>)request.getAttribute("noimgreviewboardList");
	String noimgpageNum=(String)request.getAttribute("noimgpageNum");
	int noimgpageCount=((Integer)request.getAttribute("noimgpageCount")).intValue();
	int noimgstartPage=((Integer)request.getAttribute("noimgstartPage")).intValue();
	int noimgendPage=((Integer)request.getAttribute("noimgendPage")).intValue();
	
	//상수값 페이지블럭
	int pageBlock=((Integer)request.getAttribute("pageBlock")).intValue();

%>
	<h1>review</h1>	
		<div>
			<table border="1">
				<tr>
					<th>제목</th>
					<th>글쓴이</th>
					<th>글쓴날</th>
					<th>조회수</th>
				</tr>
				<% if(noimgcount!=0){
					for(int i=0;i<noimgboardList.size();i++){
						reviewBean rbean = noimgboardList.get(i);
				%>
					<tr onclick="location.href='./reviewContent.so?num=<%=rbean.getNum()%>&noimgpageNum=<%=noimgpageNum%>&imgpageNum=<%=imgpageNum%>'">
						<td><%=rbean.getSubject() %></td>
					    <td><%=rbean.getName() %></td>
					    <td><%=rbean.getDate() %></td>
					    <td><%=rbean.getCount() %></td>
				    </tr>   		
			    <%
			    		}
			   		}
			    %>
			</table>
		</div>
		<div class="clear"></div>
		<div>
		<%
			if(noimgcount!=0){
				if(noimgstartPage > pageBlock){
		%>
				<a href="./reviewList.so?noimgpageNum=<%=noimgstartPage-pageBlock%>">이전</a>
		<%
				}
				for(int i=noimgstartPage;i<=noimgendPage;i++){
		%>
				<a href="./reviewList.so?noimgpageNum=<%=i%>"><%=i %></a>
		<%
				}
				if(noimgendPage < noimgpageCount){
		%>
				<a href="./reviewList.so?noimgpageNum=<%=noimgstartPage+pageBlock%>">다음</a>
		<%
				}
			}
		%>
		</div>
		
		
		<div>
			
			<table border="1">
				<tr>
					<th>제목</th>
					<th>글쓴이</th>
					<th>글쓴날</th>
					<th>조회수</th>
				</tr>
				
				<% if(imgcount!=0){					
					for(int i=0;i<imgboardList.size();i++){
						reviewBean rrbean = imgboardList.get(i);
						
						String imgname = rrbean.getImg();
						String[] array = imgname.split("");
						//값에 따라서 여러장을 올렸을경우 잘라줘야됨.
						//아직 무슨값으로 구분해서 저장할지 안정함.
						//그냥 .jpg이런식으로 다 자를까.
						
				%>
					<tr onclick="location.href='./reviewContent.so?num=<%=rrbean.getNum()%>&imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">
					
						<td><img src="http://localhost:8090/TeamProject/image/<%=array[0]%>"><td>
					    <td><%=rrbean.getName() %></td>
					    <td><%=rrbean.getDate() %></td>
					    <td><%=rrbean.getCount() %></td>
				    </tr>   		
			    <%
			    		}
			    	}
			    %>
			</table>
		</div>
		<div class="clear"></div>
		<div>
		<%
			if(imgcount!=0){
				if(imgstartPage > pageBlock){
		%>
				<a href="./reviewList.so?imgpageNum=<%=imgstartPage-pageBlock%>">이전</a>
		<%
				}
				for(int i=imgstartPage;i<=imgendPage;i++){
		%>
				<a href="./reviewList.so?imgpageNum=<%=i%>"><%=i %></a>
		<%
				}
				if(imgendPage < imgpageCount){
		%>
				<a href="./reviewList.so?imgpageNum=<%=imgstartPage+pageBlock%>">다음</a>
		<%
				}
			}
		%>
		</div>
		
		
<%
	String id=(String)session.getAttribute("id");
	if(id!=null){
%>
		<div>
		<form action="./reviewWrite.so?imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>" 
			  method="post">
			<input type="button" value="리뷰작성">
		</form>
		</div>	
<%
	}
%>
	<div>
	<form action="./reviewListSearchAction.so" method="post">
		<input type="text" name="search" required="required" placeholder="뭐 검색하쉴?">
		<select name="menu">
			<option value="content">글내용
			<option value="name">작성자
			<option value="buyItem">물품					
		</select>
		<input type="submit" value="검색">
	</form>
	</div>
	
	
</body>
</html>