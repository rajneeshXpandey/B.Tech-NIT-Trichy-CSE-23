<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<% 
    int count;
    String id=request.getParameter("loginid");
    String pwd=request.getParameter("password");
    String title=request.getParameter("title");
    String count1=request.getParameter("numberofbooks");
    String date=request.getParameter("date");
    String cno=request.getParameter("cardno");
    count=Integer.parseInt(count1);
    Connection connect=null; Statement stmt=null; ResultSet rs=null;
    String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab4/bookDB.accdb"; // Insert your DB's location here 
    String databaseURL="jdbc:ucanaccess://" + location;
    connect = DriverManager.getConnection(databaseURL); 
    stmt = connect.createStatement();
    String sqlstmt="select loginid,password from login";
    rs=stmt.executeQuery(sqlstmt);
    int flag=0,amount,x;
    while(rs.next()){
            if(id.equals(rs.getString(1))&&pwd.equals(rs.getString(2)))
            flag=1;
    }
    if(flag==0){
        out.println("<br><br>SORRY INVALID ID TRY AGAIN ID<br><br>");
        out.println("<a href= \"order.html \" >press HERE to RETRY</a>");
    }
    else{
        Statement stmt2=connect.createStatement();
        String s="select cost from books where title='"+title+"'"; 
        ResultSet rs1=stmt2.executeQuery(s);
        int flag1=0;
        while(rs1.next()){
            flag1=1;
            x=Integer.parseInt(rs1.getString(1));
            amount=count*x;
            out.println("<br><br>AMOUNT in dollars($):"+amount+"<br><br><br><br>");
            Statement stmt1=connect.createStatement();
            stmt1.executeUpdate("insert into details (loginid,title,amount,cardno) values ('"+id+"','"+title+"',"+amount+",'"+cno+"');");
            out.println("<br>YOUR ORDER has taken<br>");
        }
        if(flag1==0){
            out.println("<br><br><br>SORRY INVALID ID TRY AGAIN ID<br><br>");
            out.println("<a href=\"order.html\">press HERE to </a>");
        }
    }
    connect.close();
%>
