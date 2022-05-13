package com.lab2a;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;

public class server extends GenericServlet {
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        PrintWriter pw = res.getWriter();
        res.setContentType("text/html");
        pw.println("<h2>"+"Registration Successful..."+"</h2><br>");
        pw.println("<h3>"+"These are the details filled by you...!"+"</h3><br>");
        Enumeration e = req.getParameterNames();
        while (e.hasMoreElements()) {
            String str1 = (String) e.nextElement();
            String str2 = req.getParameter(str1);
            pw.println("<br>"+ str1 + " = " + str2 + "<br>");
        }
        pw.close();
    }
}
