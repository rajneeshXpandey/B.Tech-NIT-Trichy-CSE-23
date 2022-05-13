<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<% 
    String name=request.getParameter("name");
    String addr=request.getParameter("address");
    String phno=request.getParameter("phoneno");
    String id1=request.getParameter("loginid");
    String pwd1=request.getParameter("password");
    Connection connect=null; Statement stmt=null; ResultSet rs=null;
    String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab4/bookDB.accdb"; // Insert your DB's location here 
    String databaseURL="jdbc:ucanaccess://" + location;
    connect = DriverManager.getConnection(databaseURL); 
    stmt = connect.createStatement();
    String sqlstmt = "select loginid,password from login";
    rs = stmt.executeQuery(sqlstmt);
    int flag=0;
    while(rs.next()){
         if(id1.equals(rs.getString(1)) && pwd1.equals(rs.getString(2))){
            flag=1;
        }
    }
    if(flag==1){ 
        out.println("<br><br>SORRY INVALID ID ALREADY EXITS TRY AGAIN WITH NEW ID<br><br>");
        out.println("<a href=\"registration.html\">press REGISTER to RETRY</a>");
    }
    else{
        Statement stmt1=connect.createStatement();
        stmt1.executeUpdate("insert into login values('"+name+"','"+addr+"',"+phno+",'"+id1+"','"+pwd1+"');");
        out.println("<br><br>YOUR DETAILS ARE ENTERED<br><br>");
        out.println("<a href=\"login.html\">press LOGIN to login</a>");
    }
    connect.close();
%>