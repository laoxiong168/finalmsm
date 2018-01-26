package com.zjj.serviceImpl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zjj.dao.AccessCountsDao;
import com.zjj.service.AccessCountsService;

@Service("accessCountsService")
public class AccessCountsServiceImpl implements AccessCountsService {
	@Autowired
	private AccessCountsDao accessCountsDao;
	
	public AccessCountsServiceImpl() {
		
	};

	public Integer insertAccessCounts(Long counts) {
		return accessCountsDao.insertAccessCounts(counts);
	}

	public Map<String, Object> queryExistData() {
		return accessCountsDao.queryExistData();
	}

	public Integer updateData(Map<String, Object> map) {
		return accessCountsDao.updateData(map);
	}

}
