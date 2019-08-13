<%@page import="db.reviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	#dragandrophandler{
	    border:2px dotted #0B85A1;
	    width:400px;
	    color:#92AAB0;
	    text-align:left;vertical-align:middle;
	    padding:10px 10px 10 10px;
	    margin-bottom:10px;
	    font-size:200%;
	}
</style>
<title>Insert title here</title>
<script type="text/javascript">
var files;

//파일 리스트 번호
var fileIndex = 0;
// 등록할 전체 파일 사이즈
var totalFileSize = 0;
// 파일 리스트
var fileList = new Array();
// 파일 사이즈 리스트
var fileSizeList = new Array();
// 등록 가능한 파일 사이즈 MB
var uploadSize = 50;
// 등록 가능한 총 파일 사이즈 MB
var maxUploadSize = 500;

//파일 선택시
function selectFile(files,obj){
    // 다중파일 등록
    if(files != null){
        for(var i = 0; i < files.length; i++){
            // 파일 이름
            var fileName = files[i].name;
            var fileNameArr = fileName.split("\.");
            // 확장자
            var ext = fileNameArr[fileNameArr.length - 1];
            // 파일 사이즈(단위 :MB)
            var fileSize = files[i].size / 1024 / 1024;
            
            if($.inArray(ext, ['bmp', 'jpg', 'gif', 'png', 'tif', 'raw']) >= 0){
            	if(fileSize > uploadSize){
                    //파일 사이즈 체크
                    alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                    return;                   
                }            	                
            }else{
            	// 확장자 체크
                alert("등록 불가 확장자");
                return;              
            }
        }
        handleFileUpload(files,obj);
    }else{
        alert("ERROR");
    }
}

$(document).ready(function(){
    var obj = $("#dragandrophandler");

    obj.on('dragenter', function (e) 
    {
        e.stopPropagation();
        e.preventDefault();
        $(this).css('border', '2px solid #0B85A1');
    });
    obj.on('dragover', function (e) 
    {
        e.stopPropagation();
        e.preventDefault();
    });
    obj.on('drop', function (e) 
    {
    
        $(this).css('border', '2px dotted #0B85A1');
        e.preventDefault(); 
        files = e.originalEvent.dataTransfer.files;        
        if(files != null){
    		selectFile(files,obj);    		    	 
        	 
        }
        //We need to send dropped files to Server
        
    });

    $(document).on('dragenter', function (e) 
    {
        e.stopPropagation();
        e.preventDefault();
    });
    $(document).on('dragover', function (e) 
    {
        e.stopPropagation();
        e.preventDefault();
        obj.css('border', '2px dotted #0B85A1');
    });
    $(document).on('drop', function (e) 
    {
        e.stopPropagation();
        e.preventDefault();
    	
       
    });
 
});


// 파일 멀티 업로드
function handleFileUpload(files, obj) {	
	

    if(confirm(files.length + "개의 파일을 업로드 하시겠습니까?") ) {
    	
    	var data = new FormData();

        data.append('_token', '{{ Session::token() }}');

        for (var i = 0; i < files.length; i++) {
            data.append('file[]', files[i]);
        }
        
        $('#inputdata').val(data);

               
        for(var i=0; i < files.length; i++){
            // 드래그 앤 드롭으로 업로드된 파일 리스트 작성
            $('#status1').prepend('<div id="file_result_'+i+'" class="'+files[i].name+'"><span>'+files[i].name + " - " + files[i].size+'</span>'+
                '<input type="button" value="삭제" onclick="delete_file('+i+')">'+
                '<img id="file_img_'+i+'" width="100px" height="100px">'+
                '</div>');

            // 이미지 미리보기
            var reader = new FileReader();
            var j=0;
            reader.onload = function(e){
                document.getElementById('file_img_'+j).src = e.target.result;
                // $('#file_img_'+i).attr('src', rst.target.result);
                j++;
            }
            reader.readAsDataURL(files[i]);
        }
	}   
    
}

//사진 삭제
function delete_file(idx){
    if(confirm(files[idx].name+"을 삭제하시겠습니까?")){
    	
    	var data = new FormData();

        data.append('_token', '{{ Session::token() }}');
        data.append('_method', 'DELETE');
        data.append('file_name', files[idx].name);       
    	
    		 $('#file_result_'+idx).remove();
    		 
    }
}

//올린사진 삭제
function del_file(image){
    if(confirm(image+"을 삭제하시겠습니까?")){
    	
   		 $('#imgg'+image).remove();
    		 
    }
}
</script>
</head>
<%
	String id=(String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	if(id==null){
		response.sendRedirect("");
	}
	reviewBean rb =(reviewBean)request.getAttribute("rb");
	String imgpageNum=request.getParameter("imgpageNum");
	String noimgpageNum = request.getParameter("noimgpageNum");
%>
<body>

	<h1>review 수정</h1>
	
	<form action="./reviewUpdateAction.so?imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>" 
		  method="post" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=rb.getNum()%>">
		<input type="hidden" value="" name="data" id="inputdata">
		
		<div>
		<table>
			<tr>
				<td>이름</td>
				<td>
				<input type="text" name="name" value="<%=name%>" readonly>
				</td>
			</tr>			
			<tr>
				<td>제목</td>
				<td>
				<input type="text" name="subject" value="<%=rb.getSubject()%>">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea rows="13" cols="40" name="content"><%=rb.getContent() %></textarea>
				</td>
			</tr>
			<% if(rb.getImg()!=null){				
					String imgname = rb.getImg();
					String[] array = imgname.split("@@");
					for(int i=0;i<array.length;i++){
			%>	
			<tr>								
				<td colspan="3">
				<input type="button" value="그림삭제" onclick="del_file(<%=array[i]%>)">
				<!-- 수정시에 그림을 삭제하면 서버에 저장된 그림도 삭제하고 싶은데... 동시처리하는 방법을 모르겠다..
				그냥 글자체를 지울때 일괄적으로 삭제가 되게 만들어야것다.. -->				
					<img src="http://localhost:8090/TeamProject/image/<%=array[i]%>"
						id="imgg<%=array[i]%>">				
				<td>
			</tr>
			<%
					}
				}
			%>
		</table>
		</div>
			<div id="dragandrophandler">추가할 사진 컴온</div>
			<br><br>
			<div id="status1"></div>	
		
		<div>
			<input type="submit" value="글수정">
			<input type="reset" value="다시작성">
			<input type="button" value="목록보기" 
			   onclick="location.href='./reviewList.so?imgpageNum=<%=imgpageNum%>&noimgpageNum=<%=noimgpageNum%>'">
		</div>
	</form>
	
</body>
</html>