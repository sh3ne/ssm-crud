<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>

<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!--绝对路径以/开始的，从服务器的路径为标准(http://localhost:3306)，

需要加上项目名 -->

<%-- <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.0.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap-theme.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
 --%>
 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
     
</head>
<body>

<div class="container">
	<!--标题  -->
	<div class="row">
		<div class="col-md-12">
			<h1>SSM</h1>
		</div>
	</div>
	<!--按钮  -->
	<div class="row">
		<div class="col-md-4 col-md-offset-8">
			<button type="button" class="btn btn-primary">增添</button>
			<button type="button" class="btn btn-danger">删除</button>
		</div>
	</div>
	<!--显示数据  -->
	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover">
				<tr>
					<th>#</th>
					<th>Name</th>
					<th>Gender</th>
					<th>Email</th>
					<th>Department</th>
					<th>操作</th>
				</tr>
				
				<c:forEach items="${pageInfo.list}" var="emp">
				<tr>
					<th>${emp.empId}</th>
					<th>${emp.empName}</th>
					<th>${emp.gender=="1"?"男":"女"}</th>
					<th>${emp.email}</th>
					<th>${emp.deployment.depName}</th>
					<th>
						<button class="btn btn-primary">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						编辑
						</button>
						<button class="btn btn-danger">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						删除</button>
					</th>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<!--分页内容  -->
	<div class="row">
		<!--分页信息  -->
		<div class="col-md-6">
			总记录数：${pageInfo.total}，当前页码${pageInfo.pageNum}，总页数${pageInfo.pages}
		</div>
		<!--分页条  -->
		<div class="col-md-6">
				<nav aria-label="Page navigation">
			  <ul class="pagination">
			  	<li><a href="${APP_PATH}/emps/?pn=1">首页</a></li>
			   <c:if test="${pageInfo.hasPreviousPage}">
			   	 <li>
			      <a href="${APP_PATH}/emps/?pn=${pageInfo.pageNum-1}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			   </c:if>
			    <!--导航页的页码和当前页码进行对比  -->
			    <c:forEach items="${pageInfo.navigatepageNums}" var="num">
			    	<c:if test="${num == pageInfo.pageNum}">
			    		<li class="active"><a href="#">${num}</a></li>
			    	</c:if>
			    	<c:if test="${num != pageInfo.pageNum}">
			    		<li><a href="${APP_PATH}/emps/?pn=${num}">${num}</a></li>
			    	</c:if>
			    </c:forEach>
			    <c:if test="${pageInfo.hasNextPage}">
			    <li>
			      <a href="${APP_PATH}/emps/?pn=${pageInfo.pageNum+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			    </c:if>
			    <li><a href="${APP_PATH}/emps/?pn=${pageInfo.pages}">末页</a></li>
			  </ul>
			</nav>
		</div>	
	</div>


</div>

</body>
</html>