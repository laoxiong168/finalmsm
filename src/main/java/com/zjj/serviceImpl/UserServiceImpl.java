package com.zjj.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zjj.dao.UserDao;
import com.zjj.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	public List<Map<String, Object>> getData(Map<String, Object> map) {
		return userDao.getData(map);
	}
    
	/**
	 * 获取超出指标次数
	 */
	public Integer resultCounts(Map<String, Object> map) {
		return userDao.queryResultCounts(map);
	}

}
