<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.hogwarts.Greeting" %>
<%@ page import="com.hogwarts.PMF" %>
<%@page import="com.hogwarts.ClassType"%>
<%@page import="javax.jdo.Query"%>
<html>
	<head>
		<title> Hogwarts </title>
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
		
	</head>
	<body>
		
		<div class="mainContainer">
<%
    PersistenceManager pm = PMF.get().getPersistenceManager();
	String queryStr = "select from " + ClassType.class.getName() + " where id == :p1";
	Long id = Long.parseLong(request.getParameter("id"));
	List<ClassType> classList  = (List<ClassType>) pm.newQuery(queryStr).execute(id);
	
	
    if(classList!= null && classList.size() <= 0){
    	%>
    	<p> We didn't find any class </p>
    	<% 
    } else {
    	ClassType className = classList.get(0);
    		%>
    		<p> Name: <%= className.getName()%></p>
    		<%
    			for(User user: className.getstudents())
    			{
    		%>
    		<div> <p> <%= user.getNickname() %> </p>
    		<p> Email: <%= user.getEmail() %> </p>
    		</div>
 			<%
    			}
    } pm.close();
%>
		</div>
	</body>
</html>

