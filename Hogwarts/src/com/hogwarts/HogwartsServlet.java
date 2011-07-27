package com.hogwarts;

import java.io.IOException;
import javax.servlet.http.*;

/*Test*/
@SuppressWarnings("serial")
public class HogwartsServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
	}
}
