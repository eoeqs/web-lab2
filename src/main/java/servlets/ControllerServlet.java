package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ControllerServlet")
public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(request.getParameter("X"));
        try {
            if (request.getParameter("X") == null || request.getParameter("Y") == null || request.getParameter("R") == null) {
                doGet(request, response);
            } else if (Double.parseDouble(request.getParameter("Y")) < -3 || Double.parseDouble(request.getParameter("Y")) > 5) {
                doGet(request, response);
            } else {
                double x = Double.parseDouble(request.getParameter("X"));
                double y = Double.parseDouble(request.getParameter("Y"));
                int r = Integer.parseInt(request.getParameter("R"));
                System.out.println(x + " " + y + " " + r);
                if (request.getParameter("action").equals("checkPoint")) {
                    response.sendRedirect(request.getContextPath() + "/AreaCheckServlet?" + "X=" + x + "&Y=" + y + "&R=" + r + "&action=checkPoint");
                } else {
                    response.sendRedirect(request.getContextPath() + "/AreaCheckServlet?" + "X=" + x + "&Y=" + y + "&R=" + r + "&action=submitForm");

                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            doGet(request, response);
        }
    }
}


