
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    request.setCharacterEncoding("UTF-8");
    String Id = request.getParameter("id");
    String Search=request.getParameter("search");
    String Category=request.getParameter("category");    
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
                                String sqlString = "UPDATE DD_Category SET deleted='" + Id;
                                sqlString += "' WHERE destination_id=" + d_id + " AND category_id=" + Category + ";";
                                myStatement.executeUpdate(sqlString);
                                String sqlString2 = "UPDATE Destinations_Category SET count = count - 1";
                                sqlString2 += " WHERE id=" + Category + ";";
                                myStatement.executeUpdate(sqlString2);
                                out.println("Η διαγραφή πραγματοποιήθηκε!"+"<p>");
                            %>
                            <form name="back" method="post" action="search.jsp">            
                                <input type="hidden" name="id" value="<%=Id%>">
                                <input type="hidden" name="search" value="<%=Search%>">
                                <input type="hidden" name="category" value="<%=Category%>">
                                <input class="btn btn-default btn-lg" type="submit" value="Πίσω">
                            </form>
                        </center>   
                    </div>
            </div>
        </div>
    </body>
</html>
