<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.hogwarts.Greeting" %>
<%@ page import="com.hogwarts.PMF" %>
<html>
	<head>
		<title> Hogwarts </title>
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Tangerine">
		<style>
			body {
			}

			body{
				background-color:#CCCCCC;
				height:100%;
			}
			.mainContainer{
				background-color:#FFFFFF;
				width: 800px;
				height: 100%;
				margin-left:auto;
				margin-right: auto;
			}
			.header{
								margin-left:auto;
				background-color:#7D6585;
				margin-right: auto;
				width:800px;
				height: 100px;
			}
			.menu{
				display:inline-block;
				font-size:15px;
				margin: 45px 0 0 0;
				padding: 0 20px 0 0;
				font-family: Tahoma;
			}
			.menuContainer{
				float:right;
				margin: 0 10px 0 0;
			}
			.menu a:link {color: #F5EDF7; text-decoration: none;}
			.menu a:active {color: #FFFFFF;text-decoration: none;}
			.menu a:visited {color: #F5EDF7; text-decoration: none;}
			.menu a:hover {color: #4E3C54; text-decoration: none; }
			
			.logo{
				width:150px;
				float:left;
				margin:15px 0 0 15px;
font-family: 'Tangerine', serif;
				font-size: 75px;
				color: #32113D;

			}

		</style>
	</head>
	<body>
		<div class="header">
			<div class="logo">
				Hogwarts
			</div>
			<div class="menuContainer">
				<div class="menu">
					<a href="#"> HOME </a>
				</div>
				<div class="menu">
					<a href="#"> STUDENTS </a>
				</div>
				<div class="menu">
					<a href="#"> ALUMNI </a>
				</div>
				<div class="menu">
					<a href="#"> TEACHERS </a>
				</div>
				<div class="menu">
					<a href="#"> PARENTS </a>
				</div>
			</div>
		</div>	
		<div class="mainContainer">
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
    String query = "select from " + Greeting.class.getName() + " order by date desc range 0,5";
    List<Greeting> greetings = (List<Greeting>) pm.newQuery(query).execute();
    if (greetings.isEmpty()) {
%>
<p>The guestbook has no messages.</p>
<%
    } else {
        for (Greeting g : greetings) {
            if (g.getAuthor() == null) {
%>
<p>An anonymous person wrote:</p>
<%
            } else {
%>
<p><b><%= g.getAuthor().getNickname() %></b> wrote:</p>
<%
            }
%>
<blockquote><%= g.getContent() %></blockquote>
<%
        }
    }
    pm.close();
%>

    <form action="/sign" method="post">
      <div><textarea name="content" rows="3" cols="60"></textarea></div>
      <div><input type="submit" value="Post Greeting" /></div>
    </form>
			
		</div>
	</body>
</html>

