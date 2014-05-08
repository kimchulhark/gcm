<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>	
<%
	Connection con = null;
	String DB_URL = "jdbc:mysql://211.174.146.92:3306/testgcm?characterEncoding=utf8";
	String DB_USERID = "gcm12";
	String DB_USERPWD = "gcm12";
	try {
		String id = request.getParameter("id");
		if(id!=null){
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(DB_URL, DB_USERID, DB_USERPWD);
			Statement stmt = con.createStatement();	
			ResultSet rs = null;
			String sql = "select * from t_gcminfo";
			rs = stmt.executeQuery(sql);
			int i = 0;
			JSONObject jsonMain = new JSONObject();
			JSONArray jArray = new JSONArray();
			while(rs.next())
			{
				if(!id.equals(rs.getString("id"))){
					JSONObject jObject= new JSONObject();
					jObject.put("id", rs.getString("id"));
					jObject.put("regId", rs.getString("regId"));
					jObject.put("passwd", rs.getString("passwd"));
					jArray.add(i, jObject);
				
				 	i++;
				}
			}
			con.close();
			jsonMain.put("gcmList", jArray);
			out.println(jsonMain.toJSONString());
			System.out.println(jsonMain.toJSONString());
		}else{
			out.print("fail");		
		}
		
	}catch (Exception e) {
		System.out.print(e);		
		out.print("fail");		
	}
%>