<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
    <% 
        String Seat_Number,Name;
        String ans1,ans2,ans3,ans4,ans5; 
        int score1,score2,score3,score4,a5;
        score1=score2=score3=score4=a5=0; 
        Connection connect=null; Statement stmt=null; ResultSet rs=null;
        String location="D:/Documents/Academics/NIT Trichy/Semesters/VI-Semester/LAB-App Development/Lab3/studentDB.accdb"; // Insert your DB's location here 
        String databaseURL="jdbc:ucanaccess://" + location;
        connect=DriverManager.getConnection(databaseURL); 
        if(request.getParameter("action")!=null) {
                Seat_Number=request.getParameter("Seat_No");
                Name=request.getParameter("Name");
                ans1=request.getParameter("group1"); 
                    if(ans1.equals("True")) score1=2; else score1=0;
                ans2=request.getParameter("group2"); 
                    if(ans2.equals("True")) score2=0; else score2=2;
                ans3=request.getParameter("group3"); 
                    if(ans3.equals("True")) score3=0; else score3=2;
                ans4=request.getParameter("group4"); 
                    if(ans4.equals("True")) score4=2; else score4=0;
                ans5=request.getParameter("group5"); 
                    if(ans5.equals("True")) a5=0; else a5=2; 
                int Total=score1+score2+score3+score4+a5; 
                stmt=connect.createStatement(); String
                query="INSERT INTO StudentTable (" + "Seat_No,Name,Marks" + ") 
                        VALUES ('" +Seat_Number + "', '" + Name + "', '" +Total+ "')" ;
                int result=stmt.executeUpdate(query);
                stmt.close();
                stmt=connect.createStatement(); 
                query="SELECT * FROM StudentTable" ; 
                rs=stmt.executeQuery(query); 
    %>

    <html>

    <head>
        <title>Student Marks List</title>
    </head>

    <body bgcolor=khaki>
        <center>
            <h2>Students Marksheet</h2>
            <h3>Name of the College : NIT Trichy</h3>
            <table border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td><b>Seat_No</b></td>
                    <td><b>Name</b></td>
                    <td><b>Marks</b></td>
                </tr>
                <% while(rs.next()) { %>
                    <tr>
                        <td>
                            <%=rs.getInt(2)%>
                        </td>
                        <td>
                            <%=rs.getString(3)%>
                        </td>
                        <td>
                            <%=rs.getString(4)%>
                        </td>
                    </tr>
                    <% } rs.close(); stmt.close(); connect.close(); %>
            </table>
        </center>
        <br /> <br /><br />
        <table>
            <tr>
                <td><b>Date:<%=new java.util.Date().toString() %>
                </td>
            </tr>
            <tr>
                <td><b>Signature: X.Y.Z. <b></td>
            </tr>
        </table>
        <div>
            <a href="http://127.0.0.1:8080/examples/jsp/lab3/exam.jsp">Click here to go back</a>
    </body>

    </html>
    <%}else{%>
        <html>

        <head>
            <title>Online Examination</title>
            <script language="javascript">
                function validation(Form_obj) {
                    if (Form_obj.Seat_No.value.length == 0) {
                        alert("Please,fill up the Seat Number");
                        Form_obj.Seat_No.focus();
                        return false;
                    }
                    if (Form_obj.Name.value.length == 0) {
                        alert("Please,fill up the Name");
                        Form_obj.Name.focus();
                        return false;
                    }
                    return true;
                }
            </script>
        </head>

        <body bgcolor=lightgreen>
            <center>
                <h1>OnLine Examination</h1>
            </center>
            <form action="exam.jsp" method="post" name="entry" onSubmit="return validation(this)">
                <input type="hidden" value="list" name="action">
                <table>
                    <tr>
                        <td>
                            <h3>Seat Number:</h3>
                        </td>
                        <td><input type="text" name="Seat_No"></td>
                    </tr>
                    <tr>
                        <td>
                            <h3>Name:</h3>
                        </td>
                        <td><input type="text" name="Name" size="50"></td>
                    </tr>
                    <hr />
                    <tr>
                        <td><b>Total Marks:10(Each question carries equal marks) </b></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><b>Time: 15 Min.</b></td>
                    </tr>
                </table>
                <hr />
                <b>1. Apache is an open source web server</b><br />
                <input type="radio" name="group1" value="True">True
                <input type="radio" name="group1" value="False">False<br>
                <br />

                <b>2. In Modern PC there is no cache memory.</b><br />
                <input type="radio" name="group2" value="True">True
                <input type="radio" name="group2" value="False">False<br>
                <br />

                <b>3. Tim-Berner Lee is the originator of Java.</b><br />
                <input type="radio" name="group3" value="True">True
                <input type="radio" name="group3" value="False">False<br>
                <br />
                <b>4.JPG is not a video file extension.</b><br />
                <input type="radio" name="group4" value="True">True
                <input type="radio" name="group4" value="False">False<br>
                <br />
                <b>5. HTTP is a statefull protocol</b><br />
                <input type="radio" name="group5" value="True">True
                <input type="radio" name="group5" value="False">False<br>
                <hr />

                <center>
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear"><br><br>
                </center>
            </form>
    <%}%>