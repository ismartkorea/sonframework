<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="s-onsystem" />
        <title>Blog Home</title>
        <!-- Favicon-->
        <link rel="icon" type="<c:url value='/templates/blog-post' />/image/x-icon" href="<c:url value='/templates/blog-post' />/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="<c:url value='/templates/blog-post' />/css/styles.css" rel="stylesheet" />
		<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
		<script src="<c:url value='/'/>js/ui.js"></script>
		<script>
		   function fn_updt_btn_evnt() {
		        document.frm.action = "<c:url value='/blog/post/forUpdateBoardArticle.do'/>";
		        document.frm.submit();  
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
	                 <!-- Post header-->
	                 <header class="mb-4">
	                     <!-- Post title-->
	                     <h1 class="fw-bolder mb-1">${result.nttSj}</h1>
	                     <!-- Post meta content-->
	                     <div class="text-muted fst-italic mb-2">Posted on ${result.frstRegisterPnttm} by ${userId}</div>
	                     <!-- Post categories-->
	                     <a class="badge bg-secondary text-decoration-none link-light" href="#!">Web Design</a>
	                     <a class="badge bg-secondary text-decoration-none link-light" href="#!">Freebies</a>
	                     
						 <c:if test="${sessionUniqId eq result.frstRegisterId or sessionUniqId eq result.lastUpdusrId}">
	                     <button type="button" class="btn btn-primary" style="float:right" onClick="fn_updt_btn_evnt()">수정</button>
	                     </c:if>                 
	                 </header>
	                 
	                 <!-- Preview image figure-->
	                 <figure class="mb-4"><img class="img-fluid rounded" src="<c:url value='/templates/images/900/' />900_400_03.jpg" alt="..." /></figure>
	                 <!-- Post content-->
	                 <section class="mb-5">
	                 <form id="frm" name="frm" method="post" action="<c:url value='/blog/post/forUpdateBoardArticle.do'/>">
	                    <input type="hidden" id="nttId" name="nttId" value="${result.nttId}"/>
						<div id="content"></div>
				     </form>
	                 </section>
	                <c:if test="${empty result.atchFileId}"> 
						<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
                            <div class="board_attach">
                                <dl>
                                    <dt>첨부이미지</dt>
                                    <dd>
                                        <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
                                        	<c:param name="atchFileId" value="${egovc:encryptSession(result.atchFileId, pageContext.session.id)}" />
                                        </c:import>
                                    </dd>
                                </dl>
                            </div>
	                    </c:if>
                        <div class="board_attach">
                               <dl>
                                   <dt>첨부파일</dt>
                                   <dd>
                                       <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
                                            <c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
                                       </c:import>
                                   </dd>
                               </dl>
                        </div>
                    </c:if>             
	                <!-- 버튼부분 -->
	                <c:if test="${sessionUniqId eq result.frstRegisterId or sessionUniqId eq result.lastUpdusrId}">
					<div id="buttons">
					   <button type="button" class="btn btn-primary" style="float:right" onClick="fn_updt_btn_evnt()">수정</button>
					</div>	                
                    <!-- 버튼부분 -->
                    </c:if>                    
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
        <script>
	        // jQuery를 사용하여 HTML 표시
	        var encodedString = "${result.nttCn}";
	        var decodedString = $("<div/>").html(encodedString).text();
	        console.log(">>> decodedString : " + decodedString);
	
	        // 디코딩된 문자열을 표시
	        $("#content").html(decodedString);
        </script>
    </body>
</html>