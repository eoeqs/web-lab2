package servlets;


import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Point;
import models.Results;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AreaCheckServlet")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("get");
        try {
            var x = Double.parseDouble(request.getParameter("X"));
            var y = Double.parseDouble(request.getParameter("Y"));
            var r = Integer.parseInt(request.getParameter("R"));
            var point = new Point(x, y, r);

            HttpSession session = request.getSession();
            Results results = (Results) session.getAttribute("results");
            if (results == null) {
                results = new Results();
                session.setAttribute("results", results);
            }
            results.addPoint(point);


            var action = request.getParameter("action");
            if ("submitForm".equals(action)) {
                request.setAttribute("X", x);
                request.setAttribute("Y", y);
                request.setAttribute("R", r);
                request.setAttribute("result", point.isHit());

                request.getRequestDispatcher("./result.jsp").forward(request, response);

            } else if ("checkPoint".equals(action)) {
                var gson = new Gson();
                Map<String, Object> json = new HashMap<>();
                json.put("x", x);
                json.put("y", y);
                json.put("r", r);
                json.put("result", point.isHit());
                var msg = gson.toJson(json);
                System.out.println(msg);
                response.getWriter().write(msg);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("./index.jsp").forward(request, response);
        }
    }

}
