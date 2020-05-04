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
	
	
	//ɾ���û�
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
	
	//����Ա������
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println(employee);
		employeeServiceImpl.updateEmp(employee);
		return Msg.success();
	}
	
	//����Ա��id��ѯԱ��
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee=employeeServiceImpl.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	//����û����Ƿ����
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName) {
		//���ж��û����Ƿ��ǺϷ���
		String regx= "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "�û���������6-16λ��2-5������"); 
		}
		boolean boo=employeeServiceImpl.checkUser(empName);
		if(boo) {
			return Msg.success(); 
		}else {
			return Msg.fail().add("va_msg", "�û���������"); 
		}
	}
	
//	����Ա������
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//У��ʧ�ܣ�Ӧ�÷���ʧ��,��ģ̬����ʾʧ����Ϣ 
			Map<String, Object> map=new HashMap<>();
			List<FieldError> fieldErrors=result.getFieldErrors();
			for (FieldError fileError:fieldErrors) {
				System.out.println("������ֶ�����"+fileError.getField());
				System.out.println("������Ϣ��"+fileError.getDefaultMessage());
				map.put(fileError.getField(), fileError.getDefaultMessage());
			}
			 return Msg.fail().add("errorFields", map);
		}else {
			employeeServiceImpl.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
//	��ҳ��ѯԱ������
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
		PageHelper.startPage(pn,5);
		List<Employee> emps=employeeServiceImpl.getAll();
		PageInfo page=new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	
//	��ѯԱ������(��ҳ��ѯ)
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		
//		����pagehelper��ҳ���
//		��ѯǰֻҪ���ã�����ҳ�룬�Լ�ÿҳ�Ĵ�С
		PageHelper.startPage(pn,5);
//		startPage�����ŵĲ�ѯ�����Ƿ�ҳ��ѯ
		List<Employee> emps=employeeServiceImpl.getAll();
//		ʹ��pageinfo��װ���ѯ�Ľ����ֻ�轫pageinfo����ҳ��ͺã��ڶ�������Ϊ������ʾ��ҳ��
		PageInfo page=new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		//����web-inf�ļ����µ�jsp������ֱ�ӷ���
//		return "redirect:/WEB-INF/views/list.jsp";
		return "list";

	}

}
