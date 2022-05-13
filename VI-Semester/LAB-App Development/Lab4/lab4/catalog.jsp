<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<% 
    String title=request.getParameter("title");
    Connection connect=null; Statement stmt=null; ResultSet rs=null;
    String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab4/bookDB.accdb"; // Insert your DB's location here 
    String databaseURL="jdbc:ucanaccess://" + location;
    connect = DriverManager.getConnection(databaseURL); 
    stmt = connect.createStatement();
    String sqlstmt="select * from books where title='"+title+"'"; 
    rs=stmt.executeQuery(sqlstmt);
    int flag=0;
    while(rs.next()){
        out.println("<div align=\"center\">");
        out.println("TITLE:"+rs.getString(1)+"<br>");
        out.println("AUTHOR :"+rs.getString(2)+"<br>"); 
        out.println("VERSION:"+rs.getString(3)+"<br>");
        out.println("COST:"+rs.getString(4)+"<br>");
        out.println("PUBLISHER :"+rs.getString(5)+"<br>"); 
        out.println("</div>");
        flag=1;
    }
    if(flag==0){
        out.println("<br><br>SORRY INVALID TITLE TRY AGAIN <br><br>");
        out.println("<a href=\"catalog.html\">press HERE to RETRY</a>");
    }
    connect.close();
%>