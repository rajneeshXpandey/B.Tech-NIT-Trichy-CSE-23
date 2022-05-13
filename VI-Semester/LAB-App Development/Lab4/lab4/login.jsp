<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
    String id=request.getParameter("loginid");
    String pwd=request.getParameter("password");
    Connection connect=null; Statement stmt=null; ResultSet rs=null;
    String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab4/bookDB.accdb"; // Insert your DB's location here 
    String databaseURL="jdbc:ucanaccess://" + location;
    connect = DriverManager.getConnection(databaseURL); 
    stmt = connect.createStatement();
    String sqlstmt="select loginid,password from login";
    rs = stmt.executeQuery(sqlstmt);
    int flag=0;
    while(rs.next()){
        if(id.equals(rs.getString(1)) && pwd.equals(rs.getString(2))){
            flag=1;
        }   
    }
    if(flag==0){
        out.println("<br><br>SORRY INVALID ID TRY AGAIN ID<br><br>");
        out.println("<a href=\"login.html\">press LOGIN to RETRY</a>");
    }
    else
    {
        out.println("<br><br>VALID LOGIN ID<br><br>");
        out.println("<h3><ul>");
        out.println("<li><a href=\"profile.html\"><fontcolor=\"black\">USER PROFILE</font></a></li><br><br>");
        out.println("<li><a href=\"catalog.html\"><fontcolor=\"black\">BOOKS CATALOG</font></a></li><br><br>");
        out.println("<li><a href=\"order.html\"><fontcolor=\"black\">ORDER CONFIRMATION</font> </a></li></ul><br><br>");
    }
    connect.close();
%>
