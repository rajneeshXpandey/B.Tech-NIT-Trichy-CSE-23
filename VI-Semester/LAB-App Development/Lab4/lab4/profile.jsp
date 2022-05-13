<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<% 
    String id = request.getParameter("loginid");
    Connection connect=null; 
    Statement stmt=null; 
    ResultSet rs=null;
    String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab4/bookDB.accdb"; // Insert your DB's location here 
    String databaseURL="jdbc:ucanaccess://" + location;
    connect = DriverManager.getConnection(databaseURL); 
    stmt = connect.createStatement();
    out.println("<h1>Welcome "+id+"</h1></br></br>");
    String sqlstmt= "select * from login where loginid='"+id+"'";
    rs = stmt.executeQuery(sqlstmt);
    int flag=0;
    out.println("<br><br><br>");
    while(rs.next()){
        out.println("<div align=\"center\">");
        out.println("NAME :"+rs.getString(1)+"<br>");
        out.println("ADDRESS:"+rs.getString(2)+"<br>");
        out.println("PHONE NO:"+rs.getString(3)+"<br>");
        out.println("</div>");
        flag=1;
    }
    if(flag==0){
        out.println("<br><br>SORRY INVALID ID TRY AGAIN ID<br><br>");
        out.println("<a href=\"profile.html\">press HERE to RETRY</a>");
    }
    connect.close(); 
%>
