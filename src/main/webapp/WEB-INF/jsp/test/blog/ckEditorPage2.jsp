<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CkEditor 테스트 페이지</title>
		<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
		<script src="<c:url value='/'/>js/ui.js"></script>
		<script src="<c:url value='/'/>js/jquery.js"></script>
		<script src="<c:url value='/'/>js/jqueryui.js"></script>
		<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css"> 
		<style>
		  .ck-editor__editable { height: 400px; }
		  .ck-content { font-size: 12px; }
		</style>
		
</head>
<body>
  <div id="container">
  	
  	<div id="form">
  		<form id="frm" name="frm">
  		<table>
  		   <tr>
  		      <td>입력1</td>
  		      <td>
  		      	  <textarea id="editor" name="editor"></textarea>
  		      </td>
  		   </tr>
  		</table>
  		</form>
  	
  	</div>
  
  </div>
 
<!--<script src="https://cdn.ckeditor.com/ckeditor5/41.0.0/classic/ckeditor.js"></script>-->
<script src="/assets/ckeditor/ckeditor.js"></script>
<script>
  ClassicEditor.create( document.querySelector( '#editor' ), {
    removePlugins: [ 'Heading' ],
    language: "ko"
  } );
</script>

</body>
</html>