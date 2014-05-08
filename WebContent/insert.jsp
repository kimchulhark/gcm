<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>	
<%

	String regId = request.getParameter("regId");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	Connection con = null;
	String DB_URL = "jdbc:mysql://211.174.146.92:3306/testgcm?characterEncoding=utf8";
	String DB_USERID = "gcm12";
	String DB_USERPWD = "gcm12";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(DB_URL, DB_USERID, DB_USERPWD);
		Statement stmt = con.createStatement();	
		boolean rs =  false;
		String sql = "insert into t_gcminfo (id, passwd,regId) values ('"+id+"', '"+passwd+"', '"+regId+"')";
		rs = stmt.execute(sql);
		out.print("success");
		con.close();
	}catch (Exception e) {
		System.out.print(e);		
		out.print("fail");		
	}
%>