
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    request.setCharacterEncoding("UTF-8");
    String Username=request.getParameter("user");
    String Password=request.getParameter("pass");
    String c_id=request.getParameter("c_id");    
    String d_id=request.getParameter("d_id");
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/>
        <title>Delete Destination Page</title>
    </head>
    <body class="my-Main-Body">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-2 col-xs-0"></div>
                <div class="col-lg-6 col-md-6 col-sm-8 col-xs-12">
                    <div class="box-login">
                        <center>
                            <%       
                                int i=0;
                                String sqlString0 = "SELECT * FROM DD_Category WHERE destination_id=" + d_id + ";";
                                ResultSet rs = myStatement.executeQuery(sqlString0);
                                while(rs.next()){
                                    i++;
                                }
                                //Πραγματοποιείται μόνο για την εξισορρόπηση του delete trigger, μιας και έχουμε
                                //ήδη κάνει το count - 1 στο λογικό delete
                                String sqlString2 = "UPDATE Destinations_Category SET count = count + 1";
                                sqlString2 += " WHERE id=" + c_id + ";";
                                myStatement.executeUpdate(sqlString2);
                                String sqlString = "DELETE FROM DD_Category ";
                                sqlString += "WHERE destination_id=" + d_id + " AND category_id=" + c_id + ";";
                                myStatement.executeUpdate(sqlString);                                
                                if(i<=1){
                                    String sqlString1 = "DELETE FROM Destinations ";
                                    sqlString1 += "WHERE id=" + d_id + ";";
                                    myStatement.executeUpdate(sqlString1);
                                }
                                out.println("Η διαγραφή πραγματοποιήθηκε!"+"<p>");
                            %>
                            <form name="back" method="post" action="main.jsp">            
                                <input type="hidden" name="user" value="<%=Username%>">
                                <input type="hidden" name="pass" value="<%=Password%>">
                                <input class="btn btn-default btn-lg" type="submit" value="Πίσω">
                            </form>
                        </center>   
                    </div>
            </div>
        </div>
    </body>
</html>
