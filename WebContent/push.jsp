<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.android.gcm.server.*" %>
<%
	ArrayList<String> regid = new ArrayList<String>();	
	String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);	
	boolean SHOW_ON_IDLE = true;	
	int LIVE_TIME = 1;
	int RETRY = 2;

	String simpleApiKey = "AIzaSyDTM3E2vZJmLukMm3umSQLl9hm0Loe6XnE";
	String gcmURL = "https://android.googleapis.com/gcm/send";	
	Connection con = null;
	String DB_URL = "jdbc:mysql://211.174.146.92:3306/testgcm?characterEncoding=utf8";
	String DB_USERID = "gcm12";
	String DB_USERPWD = "gcm12";
	String id = request.getParameter("id");
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(DB_URL, DB_USERID, DB_USERPWD);
		Statement stmt = con.createStatement();	
		ResultSet rs = null;
		String sql = "select * from t_gcminfo where id='"+id+"'";
		rs = stmt.executeQuery(sql);
	
		while(rs.next()){
			System.out.println(rs.getString("regId"));
			regid.add(rs.getString("regId"));
		}
		con.close();
		Sender sender = new Sender(simpleApiKey);
		Message message = new Message.Builder()
		.collapseKey(MESSAGE_ID)
		.delayWhileIdle(SHOW_ON_IDLE)
		.timeToLive(LIVE_TIME)
		.addData("test","메시지 받음!!! 통신 가능!!!!")
		.build();
		MulticastResult result = sender.send(message,regid,RETRY);
	}
	catch(Exception e) {
		System.out.println(e);
		System.out.println("Connection Failed : " + e.getStackTrace());
	}
	
%>
