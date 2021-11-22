
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.setCharacterEncoding("UTF-8");
    String Username=request.getParameter("user");
    String Password=request.getParameter("pass");
    String id=request.getParameter("Id");
    String u="",p="",e="",edited="no";
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link rel="stylesheet" href="box.css" type="text/css"/>
        <title>Edit Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>               
        <link rel="stylesheet" href="pop-up-box.css" type="text/css"/>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/>        
    </head>
    <body class="my-Main-Body">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-3 col-sm-2 col-xs-0"></div>
                <div class="col-lg-5 col-md-6 col-sm-8 col-xs-12">
                    <div class="box-login">        
                        <%              
                            String sqlString = "SELECT * FROM users WHERE U_id=" + id + ";";            
                            ResultSet rs=myStatement.executeQuery(sqlString);            
                            while(rs.next()){
                                u = rs.getString("username");
                                p = rs.getString("password");
                                e = rs.getString("email");
                            }
                            if(request.getParameter("edited")!=null)edited=request.getParameter("edited");            
                            if (edited.equals("yes")){
                                String u2=u,p2=p,e2=e,sqlString2;
                                if(request.getParameter("user")!=null)u2=request.getParameter("user");
                                if(request.getParameter("pass")!=null)p2=request.getParameter("pass");
                                if(request.getParameter("mail")!=null)e2=request.getParameter("mail");
                                if(!u.equals(u2)){                
                                    sqlString2 = "UPDATE users SET username='" + u2;
                                    sqlString2+= "' WHERE U_id=" + id + ";";                
                                    myStatement.executeUpdate(sqlString2);
                                    u=u2;
                                }
                                if(!p.equals(p2)){                
                                    sqlString2 = "UPDATE users SET password='" + p2;
                                    sqlString2+= "' WHERE U_id=" + id + ";";                
                                    myStatement.executeUpdate(sqlString2);
                                    p=p2;
                                }
                                if(!e.equals(e2)){                
                                    sqlString2 = "UPDATE users SET email='" + e2;
                                    sqlString2+= "' WHERE U_id=" + id + ";";                
                                    myStatement.executeUpdate(sqlString2);
                                    e=e2;
                                }
                                out.println("Η επεξεργασία πραγματοποιήθηκε!"+"<br>");
                                edited="no";
                            }
                        %>
                        <center>
                            <table>
                                <form name="edit" method="post">             
                                    <tr>
                                        <td>                            
                                            Username:<p>
                                        </td>
                                        <td> 
                                            <input type="text" name="user" value="<%=u%>" required/><p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>                            
                                            Password:<p>
                                        </td>
                                        <td>
                                            <input type="text" name="pass" value="<%=p%>" required/><p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>                            
                                            Email:<p>
                                        </td>
                                        <td>
                                            <input type="text" name="mail" value="<%=e%>" required/><p>
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td></td>
                                        <td>
                                            <button class="btn btn-primary btn-lg" name="edited" type="submit" value="yes">Υποβολή</button>                   
                                        </td>
                                    </tr>
                                </form>
                            </table>
                        </center>
                        <table>
                            <form name="back" method="post" action="main.jsp">
                                    <input type="hidden" name="user" value="<%=Username%>">
                                    <input type="hidden" name="pass" value="<%=Password%>">
                                    <tr>
                                    <td>
                                        <input class="btn btn-default btn-lg" type="submit" value="Πίσω">
                                    </td>            
                                    </tr>
                            </form>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
