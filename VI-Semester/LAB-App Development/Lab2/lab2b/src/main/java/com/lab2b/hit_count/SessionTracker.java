package com.lab2b.hit_count;

import java.util.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SessionTracker extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        HttpSession session = req.getSession();

        Integer count = (Integer) session.getAttribute("tracker.count");
        if (count == null)
            count = 1;
        else
            count++;
        session.setAttribute("tracker.count", count);

        out.println("<HTML><HEAD><TITLE>Session Tracker</TITLE></HEAD>");
        out.println("<BODY><H1>Session Tracking by Hit Count</H1>");

        out.println("You've visited this page " + count +
                ((count.intValue() == 1) ? " time." : " times."));

        out.println("<P>");

        out.println("<H2>Here is your session data: </H2>");
        Enumeration e = session.getAttributeNames();
        while (e.hasMoreElements()) {
            String name = (String) e.nextElement();
            out.println(name + ": " + session.getAttribute(name) + "<BR>");
        }
        out.println("</BODY></HTML>");
    }
}
