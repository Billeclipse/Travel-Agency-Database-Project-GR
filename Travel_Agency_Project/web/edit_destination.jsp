
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.setCharacterEncoding("UTF-8");
    String Id = request.getParameter("id");
    String Search=request.getParameter("search");
    String Category=request.getParameter("category");    
    String d_id=request.getParameter("d_id");
    String cs="",co="",to="",u="",user="",edited="no";
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <link rel="stylesheet" href="box.css" type="text/css"/>
        <title>Edit Destination Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>              
        <link rel="stylesheet" href="pop-up-box.css" type="text/css"/>
        <link href="select/select2.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="Javascript/jquery.min.js"></script>       
        <script src="select/select2.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/>
    </head>
    <body class="my-Main-Body">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-2 col-xs-0"></div>
                <div class="col-lg-6 col-md-6 col-sm-8 col-xs-12">
                    <div class="box-login">
                        <%
                            String sqlString = "SELECT country,town,url,username FROM Destinations,DD_Category ";
                            sqlString+= "WHERE Destinations.id=DD_Category.destination_id AND id=" + d_id + ";";            
                            ResultSet rs=myStatement.executeQuery(sqlString);            
                            while(rs.next()){
                                co = rs.getString("country");
                                to = rs.getString("town");
                                u = rs.getString("url");
                                user = rs.getString("username");
                            }
                            cs=Category;          
                            if(request.getParameter("edited")!=null)edited=request.getParameter("edited");            
                            if (edited.equals("yes")){                                
                                String c2=cs,co2=co,to2=to,u2=u,user2=user,sqlString2;
                                if(request.getParameter("Username")!=null)user2=request.getParameter("Username");
                                if(request.getParameter("country")!=null)co2=request.getParameter("country");
                                if(request.getParameter("town")!=null)to2=request.getParameter("town");
                                if(request.getParameter("cat")!=null)c2=request.getParameter("cat");
                                if(request.getParameter("url")!=null)u2=request.getParameter("url");
                                if(!cs.equals(c2)){ 
                                    String cos[] = new String[5000], tos[] = new String[5000];
                                    int cts[]= new int[5000],i=0;
                                    boolean flag=false;
                                    String sqlString1 = "SELECT category_id,country,town FROM Destinations,DD_Category WHERE Destinations.id=DD_Category.destination_id";                                    
                                    ResultSet rs1 = myStatement.executeQuery(sqlString1);
                                    while(rs1.next()){
                                        cts[i]=rs1.getInt("category_id");
                                        cos[i]=rs1.getString("country");
                                        tos[i]=rs1.getString("town");
                                        i++;
                                    }
                                    for(int j=0; j<i; j++){
                                        if(String.valueOf(cts[j]).equals(c2) && cos[j].equals(co2) && tos[j].equals(to2)){
                                            flag=true;
                                            break;
                                        }    
                                    }
                                    if(flag==false){ 
                                        sqlString2 = "UPDATE DD_Category SET category_id='" + c2;
                                        sqlString2+= "' WHERE destination_id=" + d_id + " AND category_id=" + cs + ";";                                    
                                        myStatement.executeUpdate(sqlString2);
                                        cs=c2;
                                    }else
                                        out.println("Η εγγραφή που θέλετε να εκχωρήσεται υπάρχει ήδη!");
                                }
                                if(!co.equals(co2) || !to.equals(to2) || !u.equals(u2)){
                                    out.println("Η επεξεργασία πραγματοποιήθηκε!");
                                    if(!user.equals(user2)){                
                                        sqlString2 = "UPDATE Destinations SET username='" + user2;
                                        sqlString2+= "' WHERE id=" + d_id + ";";                
                                        myStatement.executeUpdate(sqlString2);
                                        user=user2;
                                    }
                                    if(!co.equals(co2)){                
                                        sqlString2 = "UPDATE Destinations SET country='" + co2;
                                        sqlString2+= "' WHERE id=" + d_id + ";";                
                                        myStatement.executeUpdate(sqlString2);
                                        co=co2;
                                    }
                                    if(!to.equals(to2)){                
                                        sqlString2 = "UPDATE Destinations SET town='" + to2;
                                        sqlString2+= "' WHERE id=" + d_id + ";";                
                                        myStatement.executeUpdate(sqlString2);
                                        to=to2;
                                    }
                                    if(!u.equals(u2)){                
                                        sqlString2 = "UPDATE Destinations SET url='" + u2;
                                        sqlString2+= "' WHERE id=" + d_id + ";";                
                                        myStatement.executeUpdate(sqlString2);
                                        u=u2;
                                    }
                                }
                                edited="no";
                            }
                        %>
                        <form name="edit" method="post" action="edit_destination.jsp">
                            <input type="hidden" name="id" value="<%=Id%>">
                            <input type="hidden" name="d_id" value="<%=d_id%>">
                            <input type="hidden" name="search" value="<%=Search%>">
                            <input type="hidden" name="category" value="<%=Category%>">
                            <table>
                                <input type="hidden" name="Username" value="<%=Id%>" required/>
                                <tr>
                                    <td>                            
                                        Χώρα Προορισμού:<p>
                                    </td>
                                    <td>
                                        <input class="box-input" type="text" placeholder="Ελλάδα" name="country" maxlength="20" value="<%=co%>" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Πόλη Προορισμού:<p>
                                    </td>
                                    <td>
                                        <input class="box-input" type="text" placeholder="Θεσσαλονίκη" name="town" maxlength="20" value="<%=to%>" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Κατηγορία Προορισμού:<p>
                                    </td>
                                    <td>
                                        <%if(cs.equals("100")){%>
                                            <select name="cat" class="sin select2-container" style="width:220px;" required>
                                                <option value="100" selected>Χειμερινοί</option>
                                                <option value="101">Χριστουγεννιάτικοι</option>
                                                <option value="102">Καλοκαιρινοί</option>
                                            </select>
                                        <%}else if(cs.equals("101")){%>
                                            <select name="cat" class="sin select2-container" style="width:220px;" required>
                                                <option value="100">Χειμερινοί</option>
                                                <option value="101" selected>Χριστουγεννιάτικοι</option>
                                                <option value="102">Καλοκαιρινοί</option>
                                            </select>
                                        <%}else{%>
                                            <select name="cat" class="sin select2-container" style="width:220px;" required>
                                                <option value="100">Χειμερινοί</option>
                                                <option value="101">Χριστουγεννιάτικοι</option>
                                                <option value="102" selected>Καλοκαιρινοί</option>
                                            </select>
                                        <%}%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Url Embed Youtube Βίντεου:<p>
                                    </td>
                                    <td>
                                        <input class="box-input" type="url" placeholder="https://www.youtube.com/embed/something" name="url" value="<%=u%>" maxlength="50">
                                    </td>
                                </tr>
                                </table>
                                <center>
                                    <table>
                                        <tr> 
                                            <td>
                                                <button class="btn btn-primary btn-lg" name="edited" type="submit" value="yes">Υποβολή</button>
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                        </form>
                        <form name="back" method="post" action="search.jsp">            
                            <input type="hidden" name="id" value="<%=Id%>">
                            <input type="hidden" name="search" value="<%=Search%>">
                            <input type="hidden" name="category" value="<%=Category%>">
                            <input class="btn btn-default btn-lg" type="submit" value="Πίσω">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(".sin").select2();
        </script>
    </body>
</html>
