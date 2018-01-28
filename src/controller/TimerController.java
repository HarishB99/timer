package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TimerController
 */
@WebServlet("/TimerController")
public class TimerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TimerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String timeParam = request.getParameter("timeEnded");
		if (timeParam != null) {
			if (timeParam.equals("true") || timeParam.equals("false")) {
				boolean timeHasEnded = Boolean.parseBoolean(timeParam);
				if (timeHasEnded) {
					response.getWriter().append("Timer Has Ended");
					return;
				}
			}
		}
		
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

}
