package com.zjj.service;

import java.util.List;
import java.util.Map;

public interface UserService {

	List<Map<String, Object>> getData(Map<String, Object> map);
	
	Integer resultCounts(Map<String, Object> map);
	
	
}
