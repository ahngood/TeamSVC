<%@page import="db.reviewBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%	
	request.setCharacterEncoding("UTF-8");
	//글만있는친구들
	int imgcount=((Integer)request.getAttribute("imgcount")).intValue();
	
	List<reviewBean> imgboardList
		=(List<reviewBean>)request.getAttribute("imgsearchboardList");
	
	String searchimgpageNum=(String)request.getAttribute("searchimgpageNum");
	
	int imgpageCount=((Integer)request.getAttribute("imgpageCount")).intValue();
	int imgstartPage=((Integer)request.getAttribute("imgstartPage")).intValue();
	int imgendPage=((Integer)request.getAttribute("imgendPage")).intValue();
	
	//사진리뷰친구들
	int noimgcount=((Integer)request.getAttribute("noimgcount")).intValue();
	
	List<reviewBean> noimgboardList
		=(List<reviewBean>)request.getAttribute("noimgsearchboardList");
	
	String searchnoimgpageNum=(String)request.getAttribute("searchnoimgpageNum");
	
	int noimgpageCount=((Integer)request.getAttribute("noimgpageCount")).intValue();
	int noimgstartPage=((Integer)request.getAttribute("noimgstartPage")).intValue();
	int noimgendPage=((Integer)request.getAttribute("noimgendPage")).intValue();
	
	//상수값 페이지블럭
	int pageBlock=((Integer)request.getAttribute("pageBlock")).intValue();
	
	//검색한 서치값. 이거 넘기는 이유는 글내용 클릭했다가 다시 검색목록으로 오기위해서임.
	String search = request.getParameter("search");
	String menu = request.getParameter("menu");

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
				<%  
				if(imgcount==0){
				%>
				<tr><td colspan="4">검색 결과가 없네유..</td></tr>
				<%	
				} 
				
				if(noimgcount!=0){
					for(int i=0;i<noimgboardList.size();i++){
						reviewBean rbean = noimgboardList.get(i);
				%>
					<tr onclick="location.href='./reviewContent.so?num=<%=rbean.getNum()%>&noimgpageNum=<%=searchnoimgpageNum%>&imgpageNum=<%=searchimgpageNum%>&search=<%=search%>&menu=<%=menu%>'">
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
				<a href="./reviewListSearch?noimgpageNum=<%=noimgstartPage-pageBlock%>">이전</a>
		<%
				}
				for(int i=noimgstartPage;i<=noimgendPage;i++){
		%>
				<a href="./reviewListSearch?noimgpageNum=<%=i%>"><%=i %></a>
		<%
				}
				if(noimgendPage < noimgpageCount){
		%>
				<a href="./reviewListSearch?noimgpageNum=<%=noimgstartPage+pageBlock%>">다음</a>
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
				
				<%  
				if(imgcount==0){
				%>
				<tr><td colspan="4">검색 결과가 없네유..</td></tr>
				<%	
				}
				
				if(imgcount!=0){					
					for(int i=0;i<imgboardList.size();i++){
						reviewBean rrbean = imgboardList.get(i);
						
						String imgname = rrbean.getImg();
						String[] array = imgname.split("");
						//값에 따라서 여러장을 올렸을경우 잘라줘야됨.
						//아직 무슨값으로 구분해서 저장할지 안정함.
						//그냥 .jpg이런식으로 다 자를까.
						
				%>
					<tr onclick="location.href='./reviewContent.so?num=<%=rrbean.getNum()%>&imgpageNum=<%=searchimgpageNum%>&noimgpageNum=<%=searchnoimgpageNum%>&search=<%=search%>&menu=<%=menu%>'">
					
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
				<a href="./reviewListSearch.so?imgpageNum=<%=imgstartPage-pageBlock%>">이전</a>
		<%
				}
				for(int i=imgstartPage;i<=imgendPage;i++){
		%>
				<a href="./reviewListSearch.so?imgpageNum=<%=i%>"><%=i %></a>
		<%
				}
				if(imgendPage < imgpageCount){
		%>
				<a href="./reviewListSearch.so?imgpageNum=<%=imgstartPage+pageBlock%>">다음</a>
		<%
				}
			}
		%>
		</div>		
		

	<div>
		<form action="" method="post">
			<input type="text" name="search">
			<input type="submit" value="결과내검색">
		</form>
	</div>

</body>
</html>