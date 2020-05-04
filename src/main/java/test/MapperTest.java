package test;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.aspectj.apache.bcel.util.ClassPath;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//�Ƽ�spring����Ŀ�Ϳ���ʹ��spring�ĵ�Ԫ����
//1������springtestģ��
//2��@ContextConfigurationָ��spring�����ļ���λ��
//3��ֱ��autowiredҪʹ�õ��������

import dao.DeploymentMapper;
import dao.EmployeeMapper;
import pojo.Deployment;
import pojo.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Resource
	EmployeeMapper em;
	
	@Resource
	DeploymentMapper dm;
	
	@Resource
	SqlSession sqlSession;

	@Test
	public void testC() {

		/*
		 * ApplicationContext ac=new
		 * ClassPathXmlApplicationContext("applicationContext.xml");
		 * 
		 * DeploymentMapper dm=ac.getBean(DeploymentMapper.class);
		 */

		System.out.println(dm);

		dm.insertSelective(new Deployment(null,"�߻���"));
		em.insertSelective(new Employee(null,1,"������","1","2@.com")); 
		
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			mapper.insertSelective(new Employee(null,1,"������","M","@qq.com"));
		}

	}

}
