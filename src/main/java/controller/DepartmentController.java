package controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import pojo.Deployment;
import pojo.Msg;
import service.DeploymentService;

@Controller
public class DepartmentController {
	
	@Resource
	private DeploymentService deploymentServiceImpl;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Deployment> list=deploymentServiceImpl.getDepts();
		return Msg.success().add("depts", list);
	}

}
