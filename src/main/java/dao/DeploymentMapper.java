package dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import pojo.Deployment;
import pojo.DeploymentExample;

public interface DeploymentMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    long countByExample(DeploymentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int deleteByExample(DeploymentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int deleteByPrimaryKey(Integer depId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int insert(Deployment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int insertSelective(Deployment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    List<Deployment> selectByExample(DeploymentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    Deployment selectByPrimaryKey(Integer depId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int updateByExampleSelective(@Param("record") Deployment record, @Param("example") DeploymentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int updateByExample(@Param("record") Deployment record, @Param("example") DeploymentExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int updateByPrimaryKeySelective(Deployment record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_dept
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    int updateByPrimaryKey(Deployment record);
}