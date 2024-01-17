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
	
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function onloading() {
        if ("<c:out value='${msg}'/>" != "") {
            alert("<c:out value='${msg}'/>");
        }
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/blog/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_delete_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }
        
        if (confirm('<spring:message code="common.delete.msg" />')) {
            document.frm.action = "<c:url value='/blog/bbs${prefix}/deleteBoardArticle.do'/>";
            document.frm.submit();
        }   
    }
    
    function fn_egov_moveUpdt_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }

        document.frm.action = "<c:url value='/blog/bbs${prefix}/forUpdateBoardArticle.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_addReply() {
        document.frm.action = "<c:url value='/blog/bbs${prefix}/addReplyBoardArticle.do'/>";
        document.frm.submit();
    }
</script>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useComment == 'true'}">
<c:import url="/cop/bbs/selectCommentList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/cop/bbs/selectSatisfactionList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
    function fn_egov_addScrap() {
        document.frm.action = "<c:url value='/blog/bbs/addScrap.do'/>";
        document.frm.submit();          
    }
</script>
</c:if>    
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

								<form name="frm" method="post" action="<c:url value='/blog/bbs${prefix}/selectBoardList.do'/>">
								
			                    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			                    <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
			                    <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			                    <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
			                    <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
			                    <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
			                    <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >

                                <h2 class="tit_2"><c:out value='${result.bbsNm}'/></h2>

                                <!-- 게시판 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${result.nttSj}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>작성자</dt>
                                                <dd>
                                                	<c:choose>
                                                		<c:when test="${anonymous == 'true'}">
                                                			******
                                                		</c:when>
                                                		<c:when test="${result.ntcrNm == ''}">
                                                			<c:out value="${result.frstRegisterNm}" />
                                                		</c:when>
                                                		<c:otherwise>
                                                			<c:out value="${result.ntcrNm}" />
                                                		</c:otherwise>
                                                	</c:choose>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dt>작성일</dt>
                                                <dd><c:out value="${result.frstRegisterPnttm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>조회수</dt>
                                                <dd><c:out value="${result.inqireCo}" /></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="board_article">
										<textarea id="nttCn" name="nttCn" class="textarea" cols="30" rows="10" readonly="readonly" title="글내용"><c:out value="${result.nttCn}" escapeXml="true" /></textarea>
                                    </div>

									<c:if test="${not empty result.atchFileId}">
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
	                                
                                    <c:if test="${anonymous == 'true'}">
                                    	<div class="board_attach">
	                                    	<dl>
                                                <dt><label for="password"><spring:message code="cop.password" /></label></dt>
                                                <dd><input name="password" title="암호" type="password" size="20" value="" maxlength="20" ></dd>
                                            </dl>
                                           </div>
                                    </c:if>

									<!-- 목록/저장버튼  -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                        	<c:if test="${result.frstRegisterId == sessionUniqId}">
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_moveUpdt_notice(); return false;">수정</a><!-- 수정 -->
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_delete_notice(); return false;">삭제</a><!-- 삭제 -->
                                            </c:if>
                                            <c:if test="${result.replyPosblAt == 'Y'}">
                                            	<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_addReply(); return false;">답글작성</a><!-- 답글작성 -->
                                            </c:if>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList('1'); return false;">목록</a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- // 목록/저장버튼 끝  -->
                                </div>
                                
                                </form>
                                
                                <!-- 게시판 상세보기 -->
                              
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