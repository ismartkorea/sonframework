<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/cop/bbs/"/>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Blog Home</title>
        <!-- Favicon-->
        <link rel="icon" type="<c:url value='/templates/blog-home' />/image/x-icon" href="<c:url value='/templates/blog-home' />/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<c:url value='/templates/blog-home' />/css/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	    <link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	    <script type="text/javascript">
	    <!--
	        function press(event) {
	            if (event.keyCode==13) {
	            	fn_select_List('1');
	            }
	        }
	        
	        function fn_select_List(pageNo) {
	            document.frm.pageIndex.value = pageNo;
	            document.frm.action = "<c:url value='/blog/main/mainPage.do'/>";
	            document.frm.submit();  
	        }
	        
	        function fn_select_article(nttNo) {
	        	
		        document.frm.nttId.value = nttNo;
	            document.frm.action = "<c:url value='/blog/post/selectBlogPostArticle.do'/>";		        
	            document.frm.submit(); 	        		
	        }
	    //-->
	    </script>   
    </head>
    <body>
        <!-- Header -->
        <c:import url="/blog/main/blogHeader.do" />
        <!--// Header -->
        
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                    <!-- Featured blog post-->
                    <div class="card mb-4">
                       <c:if test="${fn:length(resultList) == 0}">
	                       <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
	                       <div class="card-body">
	                           <div class="small text-muted">NO Created Date</div>
	                           <h2 class="card-title">No Title</h2>
	                           <p class="card-text">No Content</p>
	                           <a class="btn btn-primary" href="#!">Read more →</a>
	                       </div>
                       </c:if>                    
                    
                    	<c:forEach var="result" items="${resultList}" varStatus="status">
                    	<c:if test="${status.index==0}">         
                        <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
                        <div class="card-body">
                            <div class="small text-muted">${result.frstRegisterPnttm}</div>
                            <h2 class="card-title">${result.nttSj}</h2>
                            <p class="card-text">${fn:substring(result.nttCn, 0, 20)}</p>
                            <a class="btn btn-primary" href="javascript:fn_select_article('${result.nttId}')">Read more →</a>
                        </div>
                        </c:if>
                        </c:forEach>
                    </div>
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                    	<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:if test="${status.index > 0}"> 
                        <div class="col-lg-6">                   
                            <!-- Blog post-->
                            <c:if test="${status.index == 1}"> 
                            <div class="card mb-4">
                                <a href="#!"><img class="card-img-top" src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">${result.frstRegisterPnttm}</div>
                                    <h2 class="card-title h4">${result.nttSj}</h2>
                                    <p class="card-text">${fn:substring(result.nttCn, 0, 20)}</p>
                                    <a class="btn btn-primary" href="javascript:fn_select_article('${result.nttId}')">Read more →</a>
                                </div>
                            </div>
                            </c:if>
                            <c:if test="${status.index == 2}">
                            <!-- Blog post-->
                            <div class="card mb-4">
                                <a href="#!"><img class="card-img-top" src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">${result.frstRegisterPnttm}</div>
                                    <h2 class="card-title h4">${result.nttSj}</h2>
                                    <p class="card-text">${fn:substring(result.nttCn, 0, 20)}</p>
                                    <a class="btn btn-primary" href="javascript:fn_select_article('${result.nttId}')">Read more →</a>
                                </div>
                            </div>
                            </c:if>                            
                        </div>
                        <c:if test="${status.index > 2}">
                        <div class="col-lg-6">                      
                            <!-- Blog post-->
                            <c:if test="${status.index == 3}"> 
                            <div class="card mb-4">
                                <a href="#!"><img class="card-img-top" src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">${result.frstRegisterPnttm}</div>
                                    <h2 class="card-title h4">${result.nttSj}</h2>
                                    <p class="card-text">${fn:substring(result.nttCn, 0, 20)}</p>
                                    <a class="btn btn-primary" href="/blog/post/getBlogPostArticle.do?nttId=${result.nttId}">Read more →</a>
                                </div>
                            </div>
                            </c:if>
                            <!-- Blog post-->
                            <c:if test="${status.index == 4}"> 
                            <div class="card mb-4">
                                <a href="#!"><img class="card-img-top" src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">${result.frstRegisterPnttm}</div>
                                    <h2 class="card-title h4">${result.nttSj}</h2>
                                    <p class="card-text">${fn:substring(result.nttCn, 0, 20)}</p>
                                    <a class="btn btn-primary" href="javascript:fn_select_article('${result.nttId}')">Read more →</a>
                                </div>
                            </div>
                            </c:if>  
                        </div>
                        </c:if> 
                        </c:if>                  
                    	</c:forEach>
                    </div>
					<!-- 페이지 네비게이션 시작 -->
                     <div class="board_list_bot">
                         <div class="paging" id="paging_div">
                             <ul>
                                 <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_select_List" />
                             </ul>
                         </div>
                     </div>
                    <!-- //페이지 네비게이션 끝 -->
                </div>
		        <!-- right menu -->
		        <c:import url="/blog/main/blogMenuRight.do" />
		        <!--// right menu -->


            </div>
        </div>
        
        <!-- Footer -->
        <c:import url="/blog/main/blogFooter.do" />
        <!--// Footer -->
		<form name="frm" action ="<c:url value='/blog/main/mainPage.do'/>" method="post">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<input name="nttId" type="hidden" value=""/>
		</form>
        
        
    </body>
</html>

    