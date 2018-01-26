package com.zjj.dao;

import java.util.List;
import java.util.Map;

public interface UserDao {

	Integer insertDate(List<Map<String, Object>> list);

	List<Map<String, Object>> getData(Map<String, Object> map);

	String queryPassword(String userName);

	Integer queryResultCounts(Map<String, Object> map);
}
