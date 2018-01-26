package com.zjj.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.jar.Attributes.Name;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import com.zjj.service.UserService;
import com.zjj.utils.HttpUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TimerController implements ApplicationListener<ContextRefreshedEvent> {
	@Autowired
	private UserService userService;
	private static Logger logger = Logger.getLogger(TimerController.class);
	// 定时时长
	private static long intevalPeriod = 1800 * 1000;

	public void onApplicationEvent(ContextRefreshedEvent event) {
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				try {
					handData();
				} catch (Exception e) {
					logger.error("抛出异常：" + e);
				}
			}
		};
		Timer timer = new Timer();
		long delay = 0;
		timer.scheduleAtFixedRate(task, delay, intevalPeriod);

	}

	/**
	 * 定时任务的发送短信
	 * 
	 * @param request
	 * @return
	 */
	public void handData() {
		// String paraUrl = "http://localhost:8080/numberone/a/sys/log/getHttpGridInf";
		String paraUrl = "http://10.2.5.11:9995/NumberOne-MM/a/sys/log/getHttpGridInf";
		// String phoenUrl =
		// "http://localhost:8080/numberone/a/sys/log/getHttpPhoneNumInf";
		String phoenUrl = "http://10.2.5.11:9995/NumberOne-MM/a/sys/log/getHttpPhoneNumInf";
		String param = "";

		String paraResult = HttpUtils.sendPost(paraUrl, param);
		String phoneResult = HttpUtils.sendPost(phoenUrl, param);
		logger.info("http获取到的阈值参数：" + paraResult);
		logger.info("http获取到的电话号码：" + phoneResult);
		JSONArray paraJsonArray = JSONArray.fromObject(paraResult);
		JSONArray phoneJsonArray = JSONArray.fromObject(phoneResult);
		StringBuffer phones = new StringBuffer();
		for (int i = 0; i < phoneJsonArray.size(); i++) {
			String phoneNumber = (String) phoneJsonArray.getJSONObject(i).get("phone_number");
			phones.append(phoneNumber);
			if (i != phoneJsonArray.size() - 1) {
				phones.append(",");
			}
		}

		/**
		 * 遍历传过来的值，解析最大最小值
		 */
		List<Map<String, Object>> allParamList = new ArrayList<Map<String, Object>>();
		for (int j = 0; j < paraJsonArray.size(); j++) {
			JSONObject tempObject = paraJsonArray.getJSONObject(j);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("company", tempObject.get("monitor_position"));
			map.put("name", tempObject.get("monitor_category"));
			String max = tempObject.get("max_threshold").toString();
			if (StringUtils.isNotBlank(max)) {
				map.put("max", Float.parseFloat(max));
			}
			String min = tempObject.get("min_threshold").toString();
			if (StringUtils.isNotBlank(min)) {
				map.put("min", Float.parseFloat(min));
			}
			map.put("flag", tempObject.get("monitor_status"));
			allParamList.add(map);
		}

		/**
		 * 遍历所有参数查询出报警信息
		 */
		StringBuffer dbkjResultMsg = new StringBuffer();
		StringBuffer fytResultMsg = new StringBuffer();
		int dbkjSMSFlag = 0;
		int fytSMSFlag = 0;
		for (Map<String, Object> map : allParamList) {
			if ("1".equals(map.get("flag").toString())) {
				continue;
			}
			int resultCounts = userService.resultCounts(map);
			if (resultCounts > 0) {
				if ("广东丹邦科技".equals(map.get("company"))) {
					dbkjResultMsg.append(map.get("name") + " ");
					dbkjSMSFlag = 1;
				} else if ("泛亚太生物科技".equals(map.get("company"))) {
					fytResultMsg.append(map.get("name") + " ");
					fytSMSFlag = 1;
				}
				logger.info("超标：" + map.get("company") + " " + map.get("name") + " 次数：" + resultCounts);
			}

		}

		/**
		 * 由监测点flag状态判断是否需要发送报警短信
		 */
		if (dbkjSMSFlag == 1 && fytSMSFlag == 0) {
			String msg = "广东丹邦:" + dbkjResultMsg.toString() + "异常.";
			sendSMS(phones.toString(), msg);
		} else if (dbkjSMSFlag == 0 && fytSMSFlag == 1) {
			String msg = "泛亚太:" + fytResultMsg.toString() + "异常.";
			sendSMS(phones.toString(), msg);
		} else if (dbkjSMSFlag == 1 && fytSMSFlag == 1) {
			String msg = "广东丹邦:" + dbkjResultMsg + "异常." + "泛亚太:" + fytResultMsg.toString() + "异常.";
			sendSMS(phones.toString(), msg);
		}

	}

	/**
	 * 发送短信
	 * 
	 * @param phones
	 * @param msg
	 * @return
	 */
	private String sendSMS(String phones, String msg) {
		if (StringUtils.isBlank(phones)) {
			logger.info("电话号码为空，程序return");
			return null;
		}
		String url0 = "http://sms.253.com/msg/send";
		String param = "un=N2433411&pw=GkzJY235&phone=" + phones + "&msg=" + msg + "&rd=1";
		String url1 = "";
		String sendMesResponseStr = "";
		try {
			url1 = url0.replace(" ", "+");// 将空格转换成+号
			sendMesResponseStr = HttpUtils.sendPost(url1, param);
			logger.info("发送了一条短信");
		} catch (Exception e) {
			logger.error("短信模块抛出异常");
			e.printStackTrace();
		}
		return sendMesResponseStr;
	}
}
