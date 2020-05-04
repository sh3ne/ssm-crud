package test;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Result;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.test.web.servlet.setup.MockMvcConfigurer;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import pojo.Employee;

//ʹ��Spring����ģ����в��������ܣ�����crud����ȷ��

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml" , "classpath:springmvc.xml"})
public class mvcTest {
	
	@Autowired
	public WebApplicationContext context;
	
//	����mvc���󣬾��ܻ�ȡ������
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		
		MvcResult result= mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "50")).andReturn();
	
	
//		����ɹ����������л���pageInfo�����ǿ���ȡ��pageInfo������֤
		MockHttpServletRequest request=result.getRequest();
		PageInfo pi=(PageInfo)request.getAttribute("pageInfo");
		System.out.println("��ǰҳ�룺"+pi.getPageNum());
		System.out.println("��ҳ�룺"+pi.getPages());
		System.out.println("�ܼ�¼����"+pi.getTotal());
		System.out.println("������ʾ��ҳ����");
		int[] nums=pi.getNavigatepageNums();
		for(int i:nums) {
			System.out.println(" "+i);
		}
		
//		��ȡԱ������
		List<Employee> list=pi.getList();
		for (Employee employee:list) {
			System.out.println("ID:"+employee.getEmpId()+" name:"+employee.getEmpName());
		}
		
	}
	

}
