package com.hogwarts;

import java.io.IOException;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class CreateClassServlet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		if(user == null){
			resp.sendRedirect("/Classes.jsp");
			return;
		}
		String className = req.getParameter("className");
		Date date = new Date();
		ClassType newClass = new ClassType(className,date,user);

		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(newClass);
		} finally {
			pm.close();
		}
		resp.sendRedirect("/Classes.jsp");
	}

}
