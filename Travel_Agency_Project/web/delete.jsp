
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.setCharacterEncoding("UTF-8");
    String id =request.getParameter("Id");
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<html>
    <head>
        <link rel="stylesheet" href="box.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>             
        <link rel="stylesheet" href="pop-up-box.css" type="text/css"/>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/>
    </head>
    <body class="my-Main-Body">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-4 col-sm-3 col-xs-0"></div>
                    <div class="col-lg-4 col-md-5 col-sm-7 col-xs-12">
                    <div class="box-login"> 
                        <center>
                            <%                             
                                String sqlString = "UPDATE users SET deleted=0 WHERE U_id=" + id + ";";
                                myStatement.executeUpdate(sqlString);
                                out.println("Η διαγραφή πραγματοποιήθηκε!"+"<p>");   
                            %>                    
                            <form name="back" method="post" action="main.jsp">
                                    <input type="hidden" name="user" value="admin">
                                    <input type="hidden" name="pass" value="pass">
                                    <p><input class="btn btn-default btn-lg" type="submit" value="Πίσω">
                            </form>
                        </center>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
