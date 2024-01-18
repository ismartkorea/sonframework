<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="사내 테크 블로그 입니다." />
        <meta name="author" content="s-onsystem" />
        <title>Blog Home</title>
        <!-- Favicon-->
        <link rel="icon" type="<c:url value='/templates/blog-post' />/image/x-icon" href="<c:url value='/templates/blog-post' />/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<c:url value='/templates/blog-post' />/css/styles.css" rel="stylesheet" />
        <script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>     
		<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
		<script src="<c:url value='/'/>js/ui.js"></script>
		<script src="<c:url value='/'/>js/jquery.js"></script>
		<script src="<c:url value='/'/>js/jqueryui.js"></script>
		<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css"> 
		<script>
		
			function fn_regist_btn_evnt() {
		        if (confirm('<spring:message code="common.regist.msg" />')) {
		            //document.board.onsubmit();
		            document.blogPost.action = "<c:url value='/blog/post/insertBlogPostArticle.do'/>";
		            document.blogPost.submit();
		        }
			}
			
			function fn_cancel_btn_evnt() {
				location.href="/";
			}
		</script>
    </head>
    <body>
        <!-- Header -->
        <c:import url="/blog/main/blogHeader.do" />
        <!--// Header -->
        
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <div class="col-lg-8">        
	             <!-- Post content-->
	             <article>
     

	             </article>
	             </div>
		        <!-- right menu -->
		        <c:import url="/blog/main/blogMenuRight.do" />
		        <!--// right menu -->	             
	             
	        </div>     
        </div>
        
        <!-- Footer -->
        <c:import url="/blog/main/blogFooter.do" />
        <!--// Footer -->
                
        
    </body>
</html>