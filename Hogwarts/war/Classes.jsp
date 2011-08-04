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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new Class</title>
</head>
<body>
<%
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
%>
<p>Hello, <%= user.getNickname() %>! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to include your name with greetings you post.</p>
<%
    }
%>

<%
    PersistenceManager pm = PMF.get().getPersistenceManager();
    String query = "select from " + ClassType.class.getName() + " order by date desc range 0,5";
    List<ClassType> classList = (List<ClassType>) pm.newQuery(query).execute();
    if (classList.isEmpty()) {
%>
<p>There are no classes going on.</p>
<%
    } else {
        for (ClassType c : classList) {%>
<div style="border:thin solid #333; margin: 0 0 5px 0">
<p>
	Class Name:<%= c.getName() %> 
</p>
<p>
	Teacher:<%= c.getstudents().get(0).getNickname() %>
</p> 
<p>
<a href="register?id=<%= c.getId() %>"> Register </a>
</p>
</div>
<%
        }
    }
    pm.close();
%>
<form action="/create" method="post">
      <div>
      	Class Name:
      	<input type="text" name="className">
      	<input type="submit" value="Create Class">
      </div>
  </form>
</body>
</html>