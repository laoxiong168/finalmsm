package com.zjj.dao;

import java.util.Map;

public interface AccessCountsDao {

	Integer insertAccessCounts(Long counts);
	
	Map<String, Object>  queryExistData();
	
	Integer updateData(Map<String, Object> map);

}
