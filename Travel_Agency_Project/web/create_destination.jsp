
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String Country=request.getParameter("country");
    String Town= request.getParameter("town");
    String Url= request.getParameter("url");
    String Category[] = new String[3];
    Category=request.getParameterValues("category");
    String User= request.getParameter("user");
    int num=0,id,old_id=0;
    boolean flag=false,flag2=false,flag3=false;
    int ids[] = new int[5000];
    int c_ids[] = new int[5000];
    String countries[] =  new String[5000];
    String towns[] =  new String[5000];
    String del[] =  new String[5000];
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
        <title>Create Destination Page</title>       
    </head>
    <body class="my-Register-Body">
        <%
            int u_id=0;
            String sqlString0 = "SELECT U_id FROM users WHERE username='"+ User +"';";
            ResultSet rs0=myStatement.executeQuery(sqlString0);
            while(rs0.next())
            {
                u_id=rs0.getInt("U_id");
            }
            if (Country.trim().length() > 0 && Town.trim().length() > 0){
                String sqlString = "SELECT destination_id,category_id,country,town,deleted FROM Destinations,DD_Category WHERE destinations.id=dd_category.destination_id;";
                ResultSet rs=myStatement.executeQuery(sqlString);
                while(rs.next()){
                    ids[num]=rs.getInt("destination_id");
                    c_ids[num]=rs.getInt("category_id");
                    countries[num]=rs.getString("country");
                    towns[num]=rs.getString("town"); 
                    del[num]=rs.getString("deleted");
                    num++;
                }
                if(countries[0] != null){
                    id = ids[num-1]+1;
                    for (int i=0; i<num; i++){                        
                        if(countries[i].equals(Country) && towns[i].equals(Town)){                                
                            old_id = ids[i];
                            break;
                        }                        
                    }
                    if (old_id != 0){
                        for (int i=0; i<num; i++){
                            for(int j=0; j<Category.length; j++){
                                if(ids[i]==old_id && String.valueOf(c_ids[i]).equals(Category[j])){
                                    if(del[i]==null)  
                                        flag=true;
                                    else
                                        flag3=true;
                                    break;                                        
                                }         
                            }
                            if (flag==true) break;
                        }
                        id=old_id;
                        flag2=true;
                    }                     
                }else
                    id = 1;
                if (flag==false && flag2==false && flag3==false){                                   
                    String values= String.valueOf(id) + ",'" + Country + "','" + Town + "','" + Url + "'," + u_id;
                    String sqlString2="INSERT INTO Destinations VALUES(" + values + ");";
                    myStatement.executeUpdate(sqlString2);
                    for(int j=0; j<Category.length; j++){
                        values= String.valueOf(id) + "," + Category[j];
                        sqlString2 = "INSERT INTO DD_Category (destination_id,category_id) VALUES (" + values + ");";
                        myStatement.executeUpdate(sqlString2);
                    }
            %>
            <center>
            <%
                    out.println("Η Εγγραφή σας πραγματοποιήθηκε!"+ "<p>");                
            %>
                <a class="btn btn-default" href="create_destination.html?user=<%=User%>">Έγινε</a></center>
            <%    
                }else if (flag==false && flag2==true && flag3==false){
                    String values,sqlString2;
                    for(int j=0; j<Category.length; j++){
                        values= String.valueOf(id) + "," + Category[j];
                        sqlString2 = "INSERT INTO DD_Category (destination_id,category_id) VALUES (" + values + ");";
                        myStatement.executeUpdate(sqlString2);
                    }
            %>
            <center>
            <%        
                    out.println("Η Εγγραφή σας πραγματοποιήθηκε!"+ "<p>");
            %>
                <a class="btn btn-default btn-lg" href="create_destination.html?user=<%=User%>">Έγινε</a></center>
            <%
                }else if (flag==false && flag2==true && flag3==true){
                    String sqlString2;
                    for(int j=0; j<Category.length; j++){
                        sqlString2 = "UPDATE DD_Category SET deleted=null WHERE destination_id=" + String.valueOf(id) + " AND category_id=" + Category[j] + ";";
                        myStatement.executeUpdate(sqlString2);
                        sqlString2 = "UPDATE Destinations_Category SET count = count + 1 WHERE id=" + Category[j] + ";";
                        myStatement.executeUpdate(sqlString2);
                    }
            %>
            <center>
            <%        
                    out.println("Η Εγγραφή σας πραγματοποιήθηκε!"+ "<p>");
            %>
                <a class="btn btn-default btn-lg" href="create_destination.html?user=<%=User%>">Έγινε</a></center>
            <%    
                }
                else{
            %>
            <center>
            <%
                   out.println("Η Εγγραφή που προσπαθείτε να πραγματοποιήσετε υπάρχει ήδη"+"<p>");
            %>
                <a class="btn btn-default btn-lg" href="create_destination.html?user=<%=User%>">Πίσω</a></center>
            <%
                }                
            }
            else{
            %>
            <center>
            <%
                    out.println("Η Χώρα ή/και η Πόλη προορισμού είναι άδεια πεδία"+"<p>");
            %>
                <a class="btn btn-default btn-lg" href="create_destination.html?user=<%=User%>">Πίσω</a></center>
            <%
            }
            myStatement.close();
            myConnection.close();
        %>
        
    </body>
</html>
