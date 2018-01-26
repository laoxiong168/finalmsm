package com.zjj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.zjj.service.AccessCountsService;
import com.zjj.service.UserService;
import com.zjj.utils.HttpUtils;
import com.zjj.utils.SpringContextHelper;

import net.sf.json.JSONArray;

@Controller
public class UserController {
	private static Logger logger = Logger.getLogger(UserController.class);
	@Autowired
	private UserService userService;
	// 定时时长
	private static long intevalPeriod = 5 * 1000;
	/**
	 * 定时任务
	 */
//	static {
//		TimerTask task = new TimerTask() {
//			@Override
//			public void run() {
//				sendSMS();
//			}
//		};
//		Timer timer = new Timer();
//		long delay = 0;
//		timer.scheduleAtFixedRate(task, delay, intevalPeriod);
//	}

	/**
	 * 静态方法里实例化bean
	 */
	private static void updateAccessCounts() {
		AccessCountsService accessCountsService = (AccessCountsService) SpringContextHelper
				.getBean("accessCountsService");
		Map<String, Object> resultMap = accessCountsService.queryExistData();

	}

	/**
	 * 定时任务的发送短信
	 * 
	 * @param request
	 * @return
	 */
	public static void sendSMS() {
		String url = "http://localhost:8080/numberone/a/sys/log/getHttpGridInf";
		String url1 = "http://localhost:8080/numberone/a/sys/log/getHttpPhoneNumInf";
		String param = "";

		String httpResult = HttpUtils.sendPost(url, param);
		String phoneResult = HttpUtils.sendPost(url1, param);
		JSONArray myJsonArray = JSONArray.fromObject(phoneResult);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < myJsonArray.size(); i++) {
			String phoneNumber = (String) myJsonArray.getJSONObject(i).get("phone_number");
			sb.append(phoneNumber);
			if (i!=myJsonArray.size()-1) {
				sb.append(",");
			}
		}
//		System.out.println(sb);
		// Map<String, Object> map=(Map<String, Object>)JSON.parse(httpResult);
/*		System.out.println("获取到的http的值：" + httpResult);
		System.out.println("获取到的电话号码：" + phoneResult);*/
	}

	/**
	 * 查询数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryData")
	public String queryData() {
		return "queryData";
	}

	/**
	 * 有界面的用户查询数据
	 * 
	 * @param name
	 * @param idCode
	 * @param verificationCode
	 * @return
	 */
	@RequestMapping(value = "/query")
	@ResponseBody
	public Map<String, Object> queryInf(String name, String idCode, String verificationCode) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();

		List<Map<String, Object>> list = userService.getData(queryMap);
		if (list.size() == 0) {
			resultMap.put("isSuccess", false);
			resultMap.put("msg", "没找到相应数据！");
		} else {
		}
		return resultMap;
	}

}
