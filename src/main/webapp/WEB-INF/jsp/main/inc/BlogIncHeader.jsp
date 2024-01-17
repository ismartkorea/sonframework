<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <!-- Responsive navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#!">사내 BLOG</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="/">Home</a></li>
		<%
			LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
			if(loginVO == null){
		%>
	        <li class="nav-item"><a class="nav-link active" aria-current="page" href="<c:url value='/login/loginView.do'/>">login</a></li>
		<% } else { %>
		    <c:set var="loginName" value="<%= loginVO.getName()%>"/>
		    <c:set var="loginId" value="<%= loginVO.getId()%>"/>
		    <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">${loginId}(${loginName})</a></li>
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="<c:url value='/logout/actionLogout.do'/>">logout</a></li>
			<li class="nav-item"><a class="nav-link" aria-current="page" href="<c:url value='/logout/actionLogout.do'/>"></a></li>
			<li class="nav-item"><a class="nav-link active" aria-current="page" href="<c:url value='/blog/post/addBlogPostArticle.do'/>">글쓰기</a></li>
        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">s-onsystem Blog Home!</h1>
                    <p class="lead mb-0">즐거운 하루 되세요!</p>
                </div>
            </div>
        </header>
