package service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.EmployeeMapper;
import pojo.Employee;
import pojo.EmployeeExample;
import pojo.EmployeeExample.Criteria;
import service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Resource
	public EmployeeMapper employeeMapper;
	
//	��ѯ����Ա��
	@Override
	public List<Employee> getAll() {
	
		return employeeMapper.selectByExampleWithDept(null);
	}

//	����Ա��
	@Override
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}

	
	//�����û����Ƿ����
	@Override
	public boolean checkUser(String empName) {
		
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count=employeeMapper.countByExample(example);
		return count==0;
	}

	@Override
	public Employee getEmp(Integer id) {
		
		return employeeMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	@Override
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void deleteEmp(List<Integer> ids) {
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
