package com.hogwarts;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class RegisterForAClassServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        if(user == null){
        	resp.sendRedirect("/Test.jsp");
        	return;
        }
        String classId = req.getParameter("id");

        PersistenceManager pm = PMF.get().getPersistenceManager();
        String queryStr = "select from " + ClassType.class.getName() + " where id == :p1";
    	Long id = Long.parseLong(classId);
    	List<ClassType> classList  = (List<ClassType>)pm.newQuery(queryStr).execute(id);
        classList.get(0).getstudents().add(user);
        try {
            pm.makePersistent(classList.get(0));
        } finally {
            pm.close();
        }
        resp.sendRedirect("/class.jsp?id="+classId);
    }
}