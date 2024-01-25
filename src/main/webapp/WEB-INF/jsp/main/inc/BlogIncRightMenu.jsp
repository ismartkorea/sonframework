<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
    	
    	function srchBtn() {
    		alert("개발중입니다.");
    	}
    
    </script>

     <!-- Side widgets-->
     <div class="col-lg-4">
         <!-- Search widget-->
         <div class="card mb-4">
             <div class="card-header">Search</div>
             <div class="card-body">
                 <div class="input-group">
                     <input class="form-control" type="text" aria-describedby="button-search" />
                     <button class="btn btn-primary" id="button-search" type="button" onclick="srchBtn();">검색</button>
                 </div>
             </div>
         </div>
         <!-- Categories widget-->
         <div class="card mb-4">
             <div class="card-header">태그</div>
             <div class="card-body">
                 <div class="row">
                     <div class="col-sm-6">
                         <ul class="list-unstyled mb-0">
                            <!-- 
                             <li><a href="#!">Web Design</a></li>
                             <li><a href="#!">HTML</a></li>
                             <li><a href="#!">Freebies</a></li>
                             --> 
                         </ul>
                     </div>
                     <div class="col-sm-6">
                         <ul class="list-unstyled mb-0">
                            <!-- 
                             <li><a href="#!">JavaScript</a></li>
                             <li><a href="#!">CSS</a></li>
                             <li><a href="#!">Tutorials</a></li>
                             --> 
                         </ul>
                     </div>
                 </div>
             </div>
         </div>
         <!-- Side widget-->
         <div class="card mb-4">
             <div class="card-header">Side Widget</div>
             <div class="card-body">
             	<!-- 게시판 -->
                 <div class="row">
                     <div class="col-sm-6">
                         <ul class="list-unstyled mb-0">
                             <li><a href="/blog/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항</a></li>
                             <li><a href="/blog/bbs/selectBoardList.do?bbsId=BBSMSTR_CCCCCCCCCCCC">Q&A</a></li>
                         </ul>
                     </div>
                 </div>             	
             </div>
         </div>
     </div>