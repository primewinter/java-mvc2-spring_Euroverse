<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">
		 
		 <nav aria-label="Page navigation example">
		  <!-- 크기조절 :  pagination-lg pagination-sm-->
		  <ul class="pagination justify-content-center" >
		    
		    <!--  <<== 좌측 nav -->
		  	<c:if test="${ resultPage2.currentPage <= resultPage.pageUnit }">
		 		<li class="page-item">
			</c:if>
			<c:if test="${ resultPage2.currentPage > resultPage.pageUnit }">
				<li class="page-item">
		      <a  class="page-link" href="javascript:fncGetUserList2('${ resultPage2.currentPage-1}')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
			</c:if>
		    </li>
		    
		    <!--  중앙  -->
			<c:forEach var="i"  begin="${resultPage2.beginUnitPage}" end="${resultPage2.endUnitPage}" step="1">
				
				<c:if test="${ resultPage2.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
				    <li class="page-item">
				    	<a class="page-link" href="javascript:fncGetUserList2('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage2.currentPage != i}">	
					<li class="page-item">
						<a class="page-link" href="javascript:fncGetUserList2('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  우측 nav==>> -->
		     <c:if test="${ resultPage2.endUnitPage >= resultPage2.maxPage }">
		  		<li class="page-item">
			</c:if>
			<c:if test="${ resultPage2.endUnitPage < resultPage2.maxPage }">
				<li class="page-item">
		      <a class="page-link" href="javascript:fncGetUserList2('${resultPage2.endUnitPage+1}')" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
			</c:if>
		    </li>
		  </ul>
		</nav>
		
</div>
<br>