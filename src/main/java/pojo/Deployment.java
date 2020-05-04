package pojo;

public class Deployment {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_dept.dep_id
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    private Integer depId;

    public Deployment() {
		super();
	}

	public Deployment(Integer depId, String depName) {
		super();
		this.depId = depId;
		this.depName = depName;
	}

	@Override
	public String toString() {
		return "Deployment [depId=" + depId + ", depName=" + depName + "]";
	}

	/**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column tbl_dept.dep_name
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    private String depName;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_dept.dep_id
     *
     * @return the value of tbl_dept.dep_id
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    public Integer getDepId() {
        return depId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_dept.dep_id
     *
     * @param depId the value for tbl_dept.dep_id
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    public void setDepId(Integer depId) {
        this.depId = depId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column tbl_dept.dep_name
     *
     * @return the value of tbl_dept.dep_name
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    public String getDepName() {
        return depName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column tbl_dept.dep_name
     *
     * @param depName the value for tbl_dept.dep_name
     *
     * @mbg.generated Thu Apr 30 12:13:16 CST 2020
     */
    public void setDepName(String depName) {
        this.depName = depName == null ? null : depName.trim();
    }
}