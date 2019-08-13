<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String id=(String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("./");
	}
	String imgpageNum=request.getParameter("imgpageNum");
	String noimgpageNum=request.getParameter("noimgpageNum");
	int num=Integer.parseInt(request.getParameter("num"));
%>
<body>
	<h1>Delete</h1>
		<form action="./reviewDeleteAction?imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>" 
			  method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<div>
				review 를 삭제하시겠습니까?
			</div>
			<div>
				<input type="submit" value="글삭제" class="btn">
				<input type="button" value="목록보기" class="btn" 
				   onclick="location.href='./reviewList.so?imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">
			</div>
		</form>

</body>
</html>