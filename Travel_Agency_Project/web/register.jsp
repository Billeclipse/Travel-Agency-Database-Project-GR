
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");    
    String Username=request.getParameter("user");
    String Password= request.getParameter("pass");
    String RePassword= request.getParameter("rePass");
    String Email= request.getParameter("email");
    int num=0,id;
    boolean flag=false;
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
        <title>Register Page</title>       
    </head>
    <body class="my-Register-Body">
        <%              
            int ids[] = new int[5000];
            String u[] = new String[5000];
            if (Username.trim().length() > 0 && Password.trim().length() > 0){
                if (Password.equals(RePassword)){
                    String sqlString = "SELECT * FROM users;";
                    ResultSet rs=myStatement.executeQuery(sqlString);
                    while(rs.next()){
                        ids[num]=rs.getInt("U_id");
                        u[num]=rs.getString("username");
                        num++;
                    }
                    if(u[0]!=null){
                        for(int i=0; i<num; i++) { 
                            if(u[i].equals(Username)){
                                flag=true;                    
                                break;
                            }
                        }
                        id = ids[num-1]+1;
                    }else
                        id = 1;
                    if(flag==false){
                        String values= String.valueOf(id) + ",'" + Username + "','" + Password + "','" + Email + "',1";
                        String sqlString2="INSERT INTO users VALUES(" + values + ");";
                        myStatement.executeUpdate(sqlString2);
                        out.println("Η εγγραφή σας ολοκληρώθηκε επιτυχώς."+ "<br>");
        %>
                    <p><center><a class="btn btn-default btn-lg" href="register.html">Έγινε</a></center>
                    <%
                    }
                    else {
                        out.println("Το Username που επιλέξατε υπάρχει ήδη."+ "<br>");
        %>
                    <p><center><a class="btn btn-default btn-lg" href="register.html">Πίσω</a></center>
        <%
                    }
                }else{ 
                    out.println("Τα πεδία Password και Re-Enter Password είναι διαφορετικά."+ "<br>");
        %>
                    <p><center><a class="btn btn-default btn-lg" href="register.html">Πίσω</a></center>    
        <%
                }
            }
            else if (Username.trim().length() <= 0 && Password.trim().length() <= 0){
                out.println("Τα πεδία Username και Password είναι άδεια."+ "<br>"); 
        %>
                <p><center><a class="btn btn-default btn-lg" href="register.html">Πίσω</a></center>
        <%
            }
            else if (Username.trim().length() <= 0){
                out.println("Το πεδίο Username είναι άδειο."+ "<br>"); 
        %>
                <p><center><a class="btn btn-default btn-lg" href="register.html">Πίσω</a></center>
        <%                    
            }
            else if (Password.trim().length() <= 0){
                out.println("Το πεδίο Password είναι άδειο."+ "<br>");
        %>
                <p><center><a class="btn btn-default btn-lg" href="register.html">Πίσω</a></center>
        <%
            }
            myStatement.close();
            myConnection.close();
        %> 
    </body>
</html>
