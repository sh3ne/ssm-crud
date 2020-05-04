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

<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.0.min.js"></script>
<!--<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap-theme.css" type="text/css" rel="stylesheet">-->
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
     
</head>
<body>

<!--员工添加  -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
			        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="empEmail_add_input" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="empEmail_add_input" placeholder="empEmail">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			 <div class="form-group">
			    <label for="empEmail_add_input" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender1_add_input" value="1"> 男
					</label>
					
					<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender2_add_input" value="2"> 女
					</label>
			    </div>
			  </div>
			  
			   <div class="form-group">
			    <label for="empEmail_add_input" class="col-sm-2 control-label">depName</label>
			    <div class="col-sm-10">
			    	
					<select class="form-control" name="dId">
					</select>
			    </div>
			  </div>
			
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
      </div>
    </div>
  </div>
</div>

<!--员工修改  -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
			        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_update_input" class="col-sm-2 control-label">员工姓名</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="empEmail_update_input" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="empEmail_update_input" placeholder="Email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  
			 <div class="form-group">
			    <label for="empEmail_update_input" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender1_update_input" value="1"> 男
					</label>
					
					<label class="radio-inline">
					  	<input type="radio" name="gender" id="gender2_update_input" value="M"> 女
					  	<!--由于存入的数据为M，所以将这里设置为M，可以重新设置为2  -->
					</label>
			    </div>
			  </div>
			  
			   <div class="form-group">
			    <label for="empEmail_update_input" class="col-sm-2 control-label">depName</label>
			    <div class="col-sm-10">
			    	
					<select class="form-control" name="dId">
					</select>
			    </div>
			  </div>
			
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
      </div>
    </div>
  </div>
</div>

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
			<button type="button" class="btn btn-primary" id="emp_add_modal_btn">增添</button>
			<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
		</div>
	</div>
	<!--显示数据  -->
	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover" id="emps_table">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="check_all" />
						</th>
						<th>#</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
				
			</table>
		</div>
	</div>
	<!--分页内容  -->
	<div class="row">
		<!--分页信息  -->
		<div class="col-md-6" id="page_info_area">
		
		</div>
		<!--分页条  -->
		<div class="col-md-6" id="page_nav_area">
				
	 </div>
  </div>

</div>

<script type="text/javascript">

var totalRecord,currentNum;

//	页面加载完成后，直接发送ajax请求，拿到数据
	$(function(){
		to_page(1);		
	});
	
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn="+pn,
			type:"get",
			success:function(result){
				
				 //console.log(result);
				 build_emps_table(result);
				//1、解析并显示员工数据
				 build_page_info(result);
				 build_page_nav(result);
			}
	});
 }
	
	function build_emps_table(result){
		
		$("#emps_table tbody").empty();
		var emps=result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>");
			var empIdTd=$("<td></td>").append(item.empId);
			var empNameTd=$("<td></td>").append(item.empName);
			var empGenderTd=$("<td></td>").append(item.gender==1?'男':'女');
			var empEmailTd=$("<td></td>").append(item.email);
			var empDepartmentTd=$("<td></td>").append(item.deployment.depName);
			
			/*<button class="btn btn-danger">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
			删除</button>
			
			<button class="btn btn-primary">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
			编辑 </button>*/
			
			var editBtn=$("<button></button>").addClass("btn btn-primary edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
			//为编辑按钮添加一个自定义属性，来表示当前员工的id
			editBtn.attr("edit_id",item.empId);

			var delBtn=$("<button></button>").addClass("btn btn-danger delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
			
			delBtn.attr("delete_id",item.empId);
			
			var btnTd=$("<td></td>").append(editBtn).append(delBtn);
			
			$("<tr></tr>")
				.append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(empGenderTd)
				.append(empEmailTd)
				.append(empDepartmentTd)
				.append(btnTd)
				.appendTo("#emps_table tbody");
		})
		
	}
	
	function build_page_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("总记录数："+result.extend.pageInfo.total+"	当前页码："+result.extend.pageInfo.pageNum+"	总页数："+result.extend.pageInfo.pages);
		totalRecord=result.extend.pageInfo.pages+1;
		currentNum=result.extend.pageInfo.pageNum;
	}
	
	//2、解析并显示分页信息 
	function build_page_nav(result){
		
		$("#page_nav_area").empty();
		var ul=$("<ul></ul>").addClass("pagination");
		
		var firstPageLi=$("<li></li>").append($("<a></a>")).append($("<span></span>").append("首页").attr("href","#"));
		var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage==false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
		}
		
		
		var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi=$("<li></li>").append($("<a></a>")).append($("<span></span>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage==false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			});
		}
		
		
		
		ul.append(firstPageLi).append(prePageLi);
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
			var numLi=$("<li></li>").append($("<a></a>").attr("href","#").append(item));
			if(result.extend.pageInfo.pageNum==item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_page(item);
			});
			ul.append(numLi);
		});
		
		ul.append(nextPageLi).append(lastPageLi);
		
		var navEle=$("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}
	
	//清空表单及样式
	function reset_form	(ele){
		
		$(ele)[0].reset();
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
		
	}
	
	/*点击新增按钮弹出模态框  */
	$("#emp_add_modal_btn").click(function(){
		
		//清空表单数据
		reset_form("#empAddModal form");
		
		//获取部门数据
		getDepts("#empAddModal select");
		
		
		$("#empAddModal").modal({
			backdrop:"static"
		});
		
		$("#empAddModal select").empty();
		
	 }); 
	
	function getDepts(ele){
		$(ele).empty();
		$.ajax({
			url:"${APP_PATH}/depts",
			type:"GET",
			success:function(result){
				//console.log(result)
				/* {code: 100, msg: "获取数据成功", extend: {…}}
					code: 100
					extend:
					depts: Array(7)
					0: {depId: 1, depName: "开发部"}
					1: {depId: 2, depName: "开发部"}
					2: {depId: 3, depName: "开发部"}
					3: {depId: 4, depName: "开发部"}
					4: {depId: 5, depName: "策划部"}
					5: {depId: 6, depName: "策划部"}
					6: {depId: 7, depName: "策划部"}
					length: 7 */
					//下拉列表显示部门数据
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.depName).attr("value",this.depId);
						optionEle.appendTo(ele); 
					});
			}
		});
	}
	
	function validate_add_form(){
		//1、拿到要检验的数据，使用正则表达式
		var empName=$("#empName_add_input").val();
		var regName= /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
		if(!regName.test(empName)){
			//alert("用户名为2-5个中文或6到16个英文数字字符")
			//先清空原有样式
			show_validate_msg("#empName_add_input","error","用户名为2-5个中文或6到16个英文数字字符");
			return false;
		}else{
			show_validate_msg("#empName_add_input","success","");
		}
		
		//检验邮箱的值
		var email=$("#empEmail_add_input").val();
		var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(email)){
			//alert("邮箱格式错误")
			//先清空原有样式
			show_validate_msg("#empEmail_add_input","error","邮箱格式错误");
			return false;
		}else{
			show_validate_msg("#empEmail_add_input","success","");
		}
		return true;
	}
	
	function show_validate_msg(ele,status,msg){
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if("success"==status){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		}else if ("error"==status){
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}
	
	$("#empName_add_input").change(function(){
		//发送ajax请求检验用户名可用
		var empName=this.value;
		$.ajax({
			url:"${APP_PATH}/checkuser",
			type:"POST",
			data:"empName="+empName,
			success:function(result){
				if(result.code==100){
					show_validate_msg("#empName_add_input","success","用户名可用");
					$("#emp_save_btn").attr("ajax-va","success");
				}else if(result.code==200){
					console.log(result);
					show_validate_msg("#empName_add_input","error",result.extend.va_msg);
					$("#emp_save_btn").attr("ajax-va","error");
				}
			}
		});
	});
	
	
	$("#emp_save_btn").click(function(){
		//提交数据到服务器
		//对要提交的数据进行校验
		/* if(!validate_add_form()){
			return false;
		}; */
		
		if($(this).attr("ajax-va")=="error"){
			return false;
		}
		
		//发送ajax请求保存员工
		
		$.ajax({
			url:"${APP_PATH}/emps",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(result){
				
				if(result.code==100){
					//隐藏模态框
					alert(result.msg);
					$("#empAddModal").modal('hide');
					//发送ajax来到最后一页
					to_page(totalRecord);
				}else{
					//显示失败信息
					//console.log(result);
					//alert(result.extend.errorFields.email)
					if(undefined !=result.extend.errorFields.empName){
						show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
					}
					if(undefined !=result.extend.errorFields.email){
						show_validate_msg("#empEmail_add_input","error",result.extend.errorFields.email);
					}
				}
			}
		});
	});
	
	$(document).on("click",".edit_btn",function(){
		//alert("edit")
		//查出部门信息，显示员工信息
		getDepts("#empUpdateModal select");
		
		getEmp($(this).attr("edit_id"));
		//将员工的id传递给模态框的update按钮
		$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
		
		$("#empUpdateModal").modal({
			backdrop:"static"
		});
		//查出部门信息，并显示部门列表
	});
	
	function getEmp(id){
		$.ajax({
			url:"${APP_PATH}/emp/"+id,
			type:"GET",
			success:function(result){
				//console.log(result);
				var empData=result.extend.emp;
				$("#empName_update_static").text(empData.empName);
				$("#empEmail_update_input").val(empData.email);
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
				$("#empUpdateModal select").val(empData.dId);
			}
		});
	}
		
		$("#emp_update_btn").click(function(){
			var email=$("#empEmail_update_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式错误")
				//先清空原有样式
				show_validate_msg("#empEmail_update_input","error","邮箱格式错误");
				return false;
			}else{
				show_validate_msg("#empEmail_update_input","success","");
			}
		
			//发送ajax请求保存更新的数据
			//alert($("#empUpdateModal form").serialize());
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
				type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				success:function(result){
					//alert(result.msg)
					$("#empUpdateModal").modal('hide');
					//发送ajax来到最后一页
					to_page(currentNum);
				}
			}); 
			
		});
		
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//弹出是否确认删除对话框
			var empName=$(this).parents("tr").find("td:eq(1)").text();
			var empId=$(this).attr("delete_id");
			if(confirm("确认删除"+empName+"？")){
				//确认，发送ajax删除
				
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"POST",
					data:"&_method=DELETE",
					success:function(result){
						//alert(result.msg)
						to_page(currentNum);
					}
				});
			}
		});
		
		//完成全选/全不选
		$("#check_all").click(function(){
			//alert($(this).prop("checked"))
			$(".check_item").prop("checked",true);
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//当前选中的5元素
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，批量删除
		$("#emp_delete_all_btn").click(function(){
			$(".check_item:checked").parents("tr")
			var empNames="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			empNames=empNames.substring(0,empNames.length-1);
			del_idstr=del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】？")){
				//发送ajax删除数据
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"POST",
					data:"&_method=DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentNum);
					}
				});
			}
			
		});
		
</script>

</body>
</html>