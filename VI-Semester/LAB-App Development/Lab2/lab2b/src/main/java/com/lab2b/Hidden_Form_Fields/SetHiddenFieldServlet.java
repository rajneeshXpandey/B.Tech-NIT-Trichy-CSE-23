package com.lab2b.Hidden_Form_Fields;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SetHiddenFieldServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SetHiddenFieldServlet() {
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String userName = request.getParameter("userName").trim();
        String password = request.getParameter("password").trim();
        if (userName == null || userName.equals("") ||
                password == null || password.equals("")) {
            out.print("Please enter both username " +
                    "and password. <br/><br/>");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/login.html");
            requestDispatcher.include(request, response);
        } else if (userName.equals("rajneesh") && password.equals("1234")) {
            out.println("Logged in successfully.<br/>");
            out.println("Click on the below button to see " +
                    "the values of Username and Password !!.<br/>");
            out.print("<form action='GetHiddenFieldServlet'" +
                    " method='POST'>");
            out.print("<input type='hidden' name='userName'" +
                    " value='" + userName + "'>");
            out.print("<input type='hidden' name='password'" +
                    " value='" + password + "'>");
            out.print("<input type='submit' value='See Values'>");
            out.print("</form>");
            out.close();
        } else {
            out.print("Wrong username or password. <br/><br/>");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/login.html");
            requestDispatcher.include(request, response);
        }
    }
}
