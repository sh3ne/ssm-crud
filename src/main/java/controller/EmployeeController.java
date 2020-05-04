package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import pojo.Employee;
import pojo.Msg;
import service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Resource
	public EmployeeService employeeServiceImpl;
	
	
	//删除用户
	@RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpId(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids=new ArrayList();
			String[] str_ids=ids.split("-");
			for (String string:str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeServiceImpl.deleteEmp(del_ids);
		}else {
			Integer id=Integer.parseInt(ids);
			employeeServiceImpl.deleteEmp(id);
		}
		return Msg.success();
	}
	
	//更新员工数据
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println(employee);
		employeeServiceImpl.updateEmp(employee);
		return Msg.success();
	}
	
	//按照员工id查询员工
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee=employeeServiceImpl.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	//检查用户名是否可用
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName) {
		//先判断用户名是否是合法的
		String regx= "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名必须是6-16位或2-5的中文"); 
		}
		boolean boo=employeeServiceImpl.checkUser(empName);
		if(boo) {
			return Msg.success(); 
		}else {
			return Msg.fail().add("va_msg", "用户名不可用"); 
		}
	}
	
//	保存员工数据
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//校验失败，应该返回失败,在模态框显示失败信息 
			Map<String, Object> map=new HashMap<>();
			List<FieldError> fieldErrors=result.getFieldErrors();
			for (FieldError fileError:fieldErrors) {
				System.out.println("错误的字段名："+fileError.getField());
				System.out.println("错误信息："+fileError.getDefaultMessage());
				map.put(fileError.getField(), fileError.getDefaultMessage());
			}
			 return Msg.fail().add("errorFields", map);
		}else {
			employeeServiceImpl.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
//	分页查询员工数据
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		PageHelper.startPage(pn,5);
		List<Employee> emps=employeeServiceImpl.getAll();
		PageInfo page=new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	
//	查询员工数据(分页查询)
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		
//		引入pagehelper分页插件
//		查询前只要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn,5);
//		startPage紧跟着的查询，就是分页查询
		List<Employee> emps=employeeServiceImpl.getAll();
//		使用pageinfo包装后查询的结果，只需将pageinfo交给页面就好，第二个参数为连续显示的页数
		PageInfo page=new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		//放在web-inf文件夹下的jsp不可以直接访问
//		return "redirect:/WEB-INF/views/list.jsp";
		return "list";

	}

}
