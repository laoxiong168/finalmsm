package com.zjj.test;

import static org.junit.Assert.*;

import org.junit.Test;

import com.zjj.utils.Md5Util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

public class UnitTestTest1 {
	
	private String customerUrl="120.25.107.130:9999";
	private String SONGUrl="120.25.107.130:9999";
	private String localUrl="localhost:8080";
	private String nginx="192.168.142.129:8888";
	

	@Test
	public void test() {
		
		String column1=Md5Util.md5("侯智文");
		String column2=Md5Util.md5("430802197908160716");
		
		String userName="湖南";
		String password="123456";
		Long timestamp=System.currentTimeMillis();
		String totalCharactor=userName+password+column1+column2+timestamp;
		String token=Md5Util.md5(totalCharactor);
//		System.out.println(column2);
		String url="http://"+customerUrl+"/api/getData.do?timestamp="+timestamp+"&token="+token+"&userName=湖南&column1="+column1+
				"&column2="+column2;
		
		System.out.println(url);
		
		
		
	}
}
