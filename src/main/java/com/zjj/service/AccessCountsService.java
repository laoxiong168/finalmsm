package com.zjj.service;

import java.util.Map;

public interface AccessCountsService {
	Integer insertAccessCounts(Long counts);

	Map<String, Object> queryExistData();

	Integer updateData(Map<String, Object> map);
	
}
