<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
	
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function fn_egov_validateForm(obj){
        return true;
    }

    function fn_egov_regist_notice(){
        //document.board.onsubmit();

        if (!validateBoard(document.board)){
            return;
        }
        
        if (confirm('<spring:message code="common.update.msg" />')) {
            document.board.action = "<c:url value='/blog/bbs${prefix}/updateBoardArticle.do'/>";
            document.board.submit();                    
        }
    }   
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/blog/bbs${prefix}/selectBoardList.do'/>";
        document.board.submit();    
    }
    
    function fn_egov_check_file(flag) {
        if (flag=="Y") {
            document.getElementById('file_upload_posbl').style.display = "block";
            document.getElementById('file_upload_imposbl').style.display = "none";          
        } else {
            document.getElementById('file_upload_posbl').style.display = "none";
            document.getElementById('file_upload_imposbl').style.display = "block";
        }
    }
    
    /* ********************************************************
     * 달력
     ******************************************************** */
    function fn_egov_init_date(){
    	
    	$("#searchBgnDe").datepicker(
    	        {dateFormat:'yy-mm-dd'
    	         , showOn: 'button'
    	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
    	         , buttonImageOnly: true
    	         
    	         , showMonthAfterYear: true
    	         , showOtherMonths: true
    		     , selectOtherMonths: true
    		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    				
    	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
    	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
    	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
    	});

    	$("#searchEndDe").datepicker( 
    	        {dateFormat:'yy-mm-dd'
    	         , showOn: 'button'
    	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
    	         , buttonImageOnly: true
    	         
    	         , showMonthAfterYear: true
    	         , showOtherMonths: true
    		     , selectOtherMonths: true
    		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
    				
    	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
    	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
    	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
    	});
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
                <!-- 게시판 부분 -->

					<form:form modelAttribute="board" name="board" method="post" enctype="multipart/form-data" >
					
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="returnUrl" value="<c:url value='/cop/bbs/forUpdateBoardArticle.do'/>"/>
					<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
					<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
					<input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
					<input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
					<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
					<input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
					<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
					<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
					
					<c:if test="${anonymous != 'true'}">
						<input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
						<input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
					</c:if>
					
					<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
						<input name="ntceBgnde" type="hidden" value="10000101">
						<input name="ntceEndde" type="hidden" value="99991231">
					</c:if>

                             <h2 class="tit_2"><c:out value='${bdMstr.bbsNm}'/></h2>
                             
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
                                             <input id="" class="f_txt w_full" name="nttSj" title="<spring:message code="cop.nttSj" />" type="text" value='<c:out value="${result.nttSj}" />' maxlength="60" >
                                             <br/><form:errors path="nttSj" />
                                         </td>
                                     </tr>
                                     <tr>
                                         <td class="lb">
                                             <label for="qestnrPurps"><spring:message code="cop.nttCn" /></label><!-- 내용 -->
                                             <span class="req">필수</span>
                                         </td>
                                         <td>
                                             <textarea id="nttCn" name="nttCn" title="<spring:message code="cop.nttCn" />" class="f_txtar w_full h_200" cols="30" rows="10" ><c:out value="${result.nttCn}" escapeXml="true" /></textarea>
                                             <form:errors path="nttCn" />
                                         </td>
                                     </tr>
                                     
                                     <c:if test="${bdMstr.bbsAttrbCode == 'BBSA01'}">
                                      <tr>
                                          <td class="lb">
                                              <label for=""><spring:message code="cop.noticeTerm" /></label><!-- 게시기간 -->
                                              <span class="req">필수</span>
                                          </td>
                                          <td>
                                          	<input name="ntceBgnde" type="hidden" value='<c:out value="${result.ntceBgnde}" />'>
                                          	<input type="text" name="searchBgnDe" id="searchBgnDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchBgnDe}'/>" title="시작일자입력" />
                                          	~
                                          	<input name="ntceEndde" type="hidden" value='<c:out value="${result.ntceEndde}" />'>
                                          	<input type="text" name="searchEndDe" id="searchEndDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchEndDe}'/>" title="종료일자입력" />
                                          	<br/><form:errors path="ntceBgndeView" />
                                          	<br/><form:errors path="ntceEnddeView" />
                                          </td>
                                      </tr>
                                     </c:if>
                                     
                                     <c:if test="${not empty result.atchFileId}">
                                      <tr>
                                          <td class="lb">
                                              <span class="min"><spring:message code="cop.atchFileList" /></span><!-- 첨부파일목록 -->
                                          </td>
                                          <td>
                                          	<div class="board_attach2">
                                                 	<span>
                                                <c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
                                                	<c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
                                                </c:import>
                                               </span>
                                              </div>
                                          </td>
                                      </tr>
                                     </c:if>
                                     
                                     <!-- 파일첨부 시작 -->
                                     <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
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
                                                  <spring:message code="common.imposbl.fileupload" />
                                              </div>
                                              <c:if test="${empty result.atchFileId}">
								            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
								        </c:if>
                                          </td>
                                      </tr>
                                     </c:if>
                                     <!-- /파일첨부 끝 -->
                                 </table>
                                 
                                 <!-- 파일첨부 스크립트 시작 -->
                              <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}"> 
						<script type="text/javascript">
							var existFileNum = document.board.fileListCnt.value;
					        var maxFileNum = document.board.posblAtchFileNumber.value;
					
					        if (existFileNum=="undefined" || existFileNum ==null) {
					            existFileNum = 0;
					        }
					        if (maxFileNum=="undefined" || maxFileNum ==null) {
					            maxFileNum = 0;
					        }
					        var uploadableFileNum = maxFileNum - existFileNum;
					        if (uploadableFileNum<0) {
					            uploadableFileNum = 0;
					        }
					        if (uploadableFileNum != 0) {
					            fn_egov_check_file('Y');
					            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum );
					            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
					        } else {
					            fn_egov_check_file('N');
					        }
						</script>
						</c:if>
						<!-- /파일첨부 스크립트 끝 -->
                             </div>

					<!-- 목록/저장버튼  -->
                             <div class="board_view_bot">
                                 <div class="left_col btn3">
                                 </div>

                                 <div class="right_col btn1">
                                 	<c:if test="${bdMstr.authFlag == 'Y'}">
                                 		<c:if test="${result.frstRegisterId == searchVO.frstRegisterId}">
                                     		<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_regist_notice(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                     	</c:if>
                                     </c:if>
                                     <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                 </div>
                             </div>
                             <!-- // 목록/저장버튼 끝  -->
                             
                             </form:form>
                             
                             <!-- 게시판 부분 --> 
                                
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