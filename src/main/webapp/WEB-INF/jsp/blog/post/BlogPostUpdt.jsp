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
		<style>
		      .ck-editor__editable[role="textbox"] {
		          /* editing area */
		          min-height: 500px;
		      }
			  .ck-content .image {
			    max-width: 80%;
			    margin: 20px auto;
			  }      
		</style>		
		<script>
		
			function fn_regist_btn_evnt() {
		        if (confirm('<spring:message code="common.regist.msg" />')) {
		            //document.board.onsubmit();
		            document.blogPost.action = "<c:url value='/blog/post/updateBoardArticle.do'/>";
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
					<div id="form">
					
					<form:form modelAttribute="blogPostInfo" id="blogPost" name="blogPost" method="post" enctype="multipart/form-data" >
             				
	                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	                <input type="hidden" name="bbsId" value="BLGPST_000000000001" />
	                <input type="hidden" name="bbsAttrbCode" value="BBSA03" />
	                <input type="hidden" name="bbsTyCode" value="BBST01" />
	                <input type="hidden" name="replyPosblAt" value="N" />
	                <input type="hidden" name="fileAtchPosblAt" value="Y" />
	                <input type="hidden" name="posblAtchFileNumber" value="1" />
	                <input type="hidden" name="posblAtchFileSize" value="5242880" />
	                <input type="hidden" name="tmplatId" value="TMPLAT_BOARD_DEFAULT" />
	                
	                <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
	                <input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
	                
	                <c:if test="${anonymous != 'true'}">
	                    <input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
	                    <input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
	                </c:if>
	                
	                <c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
	                   <input name="ntceBgnde" type="hidden" value="10000101">
	                   <input name="ntceEndde" type="hidden" value="99991231">
	                </c:if>
	                <!-- 버튼부분 -->
					<div id="buttons">
					   <button type="button" class="btn btn-primary" style="float:right" onClick="fn_regist_btn_evnt()">저장</button>
					   <button type="button" class="btn btn-secondary" style="float:right" onClick="fn_cancel_btn_evnt()">취소</button>
					</div>	                
                    <!-- 버튼부분 -->
                             <h1 class="tit_1">포스팅</h1>
                             
                             <div class="board_view2">
                                 <table>
                                     <colgroup>
                                         <col style="width: 190px;">
                                         <col style="width: auto;">
                                     </colgroup>
                                     <tr>
                                         <td class="lb">
                                             <label for=""><spring:message code="cop.nttSj" /></label><!-- 제목 -->
                                             <span class="req">필수</span>
                                         </td>
                                         <td>
                                             <input type="text" id="nttSj" name="nttSj" class="form-control" maxlength="60" value="${result.nttSj}" >
                                             <br/><form:errors path="nttSj" />
                                         </td>
                                     </tr>
                                     <tr>
                                         <td class="lb">
                                             <label for="qestnrPurps"><spring:message code="cop.nttCn" /></label><!-- 글내용 -->
                                             <span class="req">필수</span>
                                         </td>
                                         <td>
                                             <textarea id="nttCn" name="nttCn" class="form-control"></textarea>
                                             <form:errors path="nttCn" />
                                         </td>
                                     </tr>
                                     
                                     <!-- 파일첨부 시작 -->
                                      <tr>
                                          <td class="lb">
                                          	<label for="egovComFileUploader" ><spring:message code="cop.atchFile" /></label>
                                          </td>
                                          <td>
                                              <div class="board_attach2" id="file_upload_posbl">
                                                  <input name="file_1" id="egovComFileUploader" type="file" />
                                                  <div id="egovComFileList"></div>
                                              </div>
                                              <div class="board_attach2" id="file_upload_imposbl">
                                              </div>
                                              <c:if test="${empty result.atchFileId}">
								            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
								        </c:if>
                                          </td>
                                      </tr>
                                     <!-- /파일첨부 끝 -->
                                 </table>
                                 
		                        <script type="text/javascript">
		                            var maxFileNum = document.board.posblAtchFileNumber.value;
		                            if(maxFileNum==null || maxFileNum==""){
		                                maxFileNum = 3;
		                            } 
		                            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		                            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		                        </script>
                      
                             </div>
                             
                             </form:form>
                             
			                <!-- 버튼부분 -->
							<div id="buttons">
							   <button type="button" class="btn btn-primary" style="float:right" onClick="fn_regist_btn_evnt()">저장</button>
							   <button type="button" class="btn btn-secondary" style="float:right" onClick="fn_cancel_btn_evnt()">취소</button>
							</div>	                
		                    <!-- 버튼부분 -->                             
                             
                      </div>       

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
        

	<!-- ckeditor -->
	<script src="${pageContext.request.contextPath}/assets/ckeditor/ckeditor.js"></script>
	<script>
	  ClassicEditor.create( document.querySelector( '#nttCn' ), {
	    removePlugins: [ 'Heading' ],
	    language: "ko"
	  } );
	</script>
	<!-- ckeditor --> 
        <script>
	        // jQuery를 사용하여 HTML 표시
	        var encodedString = "${result.nttCn}";
	        var decodedString = $("<div/>").html(encodedString).text();
	        console.log(">>> decodedString : " + decodedString);
	
	        // 디코딩된 문자열을 표시
	        $("#nttCn").html(decodedString);
        </script>        
        
    </body>
</html>