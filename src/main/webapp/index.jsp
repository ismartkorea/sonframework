<%--
  Class Name : index.jsp
  Description : 최초화면으로 메인화면으로 이동한다.(system)
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31  JJY       경량환경 버전 생성

    author   : 실행환경 개발팀 JJY
    since    : 2011.08.31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<!--<script type="text/javaScript">document.location.href="<c:url value='/uat/uia/egovLoginUsr.do'/>"</script>-->
<script type="text/javaScript">
	<%
	LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
	if(loginVO == null){
	%>
 document.location.href="<c:url value='/login/loginView.do'/>"
 
	 <% } else { %>
 document.location.href="<c:url value='/blog/main/mainPage.do'/>"
	 
	 <% } %>

</script>