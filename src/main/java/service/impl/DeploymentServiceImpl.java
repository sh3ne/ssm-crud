package service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.DeploymentMapper;
import pojo.Deployment;
import service.DeploymentService;

@Service
public class DeploymentServiceImpl implements DeploymentService{

	@Resource
	private DeploymentMapper deploymentMapper;
	
	@Override
	public List<Deployment> getDepts() {
		
		return deploymentMapper.selectByExample(null);
	}

}
