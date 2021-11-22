
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    request.setCharacterEncoding("UTF-8");
    String Id = request.getParameter("id");
    String Search="";
    if(request.getParameter("search")!=null) Search= request.getParameter("search");
    String Category[]= new String[3];
    if (request.getParameterValues("category")!=null) Category=request.getParameterValues("category");
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>              
        <link rel="stylesheet" href="pop-up-box.css" type="text/css"/>
        <script type="text/javascript" src="Javascript/jquery.min.js"></script>                
        <script type="text/javascript" src="Javascript/bootstrap.min.js"></script>
        <link rel="stylesheet" href="fancybox/jquery.fancybox.css" type="text/css" media="screen" />
        <script type="text/javascript" src="fancybox/jquery.fancybox.pack.js"></script>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/>
        <script>
            $(document).ready(function() {
                $(".various").fancybox({
                        maxWidth	: 800,
                        maxHeight	: 600,
                        fitToView	: false,
                        width		: '70%',
                        height		: '70%',
                        autoSize	: false,
                        closeClick	: false,
                        openEffect	: 'none',
                        closeEffect	: 'none'
                });
            });
        </script>
    </head>
    <body class="my-Main-Body">
        <div class="container">
           <div class="row">
               <div class="col-lg-1 col-md-0 col-sm-0 col-xs-0"></div>
               <div class="col-lg-9 col-md-11 col-sm-12 col-xs-12">
                   <div class="box-main">
                       <%
                        String Username="",Password="";
                        String sqlString0 = "SELECT username,password FROM users WHERE U_id=" + Id + ";"; 
                        ResultSet rs0 = myStatement.executeQuery(sqlString0);
                        while(rs0.next()){
                            Username=rs0.getString("username");
                            Password=rs0.getString("password");
                        }
                        if (Search.trim().length() > 0){
                            String sqlString = "SELECT destination_id,category_id,country,town,url,toUsername(username),count,deleted FROM Destinations,DD_Category,Destinations_Category ";                         
                            sqlString += "WHERE Destinations.id=DD_Category.destination_id AND Destinations_Category.id=DD_Category.category_id ";
                            sqlString += "AND (country LIKE '%" + Search + "%' OR town LIKE '%" + Search + "%');";
                            ResultSet rs = myStatement.executeQuery(sqlString);
                            int i=0,j,id[]= new int[5000];
                            int c_id[]= new int[5000];
                            int count[] = new int [5000];
                            String cou[]= new String[5000];
                            String to[]= new String[5000];
                            String u[]= new String[5000];
                            String un[]= new String[5000];
                            String del[]= new String[5000];
                            while(rs.next()){
                                id[i]=rs.getInt("destination_id");
                                c_id[i]=rs.getInt("category_id");
                                cou[i]=rs.getString("country");
                                to[i]=rs.getString("town");
                                u[i]=rs.getString("url");
                                un[i]=rs.getString("toUsername(username)");
                                count[i]=rs.getInt("count");
                                del[i]=rs.getString("deleted");
                                i++;
                            }
                        %>
                        <table>
                            <tr>
                                <td>ΧΩΡΑ</td>
                                <td>ΠΟΛΗ</td>
                                <td>ΚΑΤΗΓΟΡΙΑ</td>
                                <td class="visible-lg visible-md visible-sm">URL</td>
                                <td class="visible-lg visible-md visible-sm">ΧΡΗΣΤΗΣ</td>
                                <td class="visible-lg visible-md visible-sm"></td>
                                <td class="visible-lg visible-md"></td>
                            </tr>
                        <%          
                             for (j=0; j<i; j++){
                                 if(del[j]==null){
                        %>
                                <tr>                                    
                                    <td><%out.println(cou[j]+" ");%></td>
                                    <td><%out.println(to[j]+" ");%></td>
                                    <td>
                                        <%switch(c_id[j]){
                                            case 100:out.println("Χειμερινοί ");out.println("("+count[j]+") ");break;
                                            case 101:out.println("Χριστουγεννιάτικοι ");out.println("("+count[j]+") ");break;
                                            case 102:out.println("Καλοκαιρινοί ");out.println("("+count[j]+") ");break;
                                        }%>
                                    </td>
                                    <td class="visible-lg visible-md visible-sm">
                                        <%if(!u[j].equals("")){%>                                        
                                            <a class="various fancybox.iframe" href="<%=u[j]%>?autoplay=1">                                            
                                                <span class="glyphicon glyphicon-globe"></span>
                                            </a>
                                        <%}%>
                                    </td>
                                    <td class="visible-lg visible-md visible-sm"><%out.println(un[j]+" ");%></td>
                                    <td class="visible-lg visible-md visible-sm">
                                        <form method="post" action="edit_destination.jsp">
                                            <input type="hidden" name="id" value="<%=Id%>">
                                            <input type="hidden" name="d_id" value="<%=id[j]%>">
                                            <input type="hidden" name="search" value="<%=Search%>">
                                            <input type="hidden" name="category" value="<%=c_id[j]%>">
                                            <input class="btn btn-register" type="submit" value="ΕΠΕΞΕΡΓΑΣΙΑ">
                                        </form>
                                    </td>                                
                                    <td class="visible-lg visible-md">
                                        <form method="post" action="delete_destination.jsp">
                                            <input type="hidden" name="id" value="<%=Id%>">
                                            <input type="hidden" name="d_id" value="<%=id[j]%>">
                                            <input type="hidden" name="search" value="<%=Search%>">
                                            <input type="hidden" name="category" value="<%=c_id[j]%>">
                                            <input class="btn btn-danger" type="submit" value="ΔΙΑΓΡΑΦΗ">
                                        </form>
                                    </td>                                
                                </tr>
                        <%
                                }
                            }
                        %>
                            </table>
                            <br>
                        <%
                        }
                        else{                            
                            String sqlString1 = "SELECT destination_id,category_id,country,town,url,toUsername(username),count,deleted FROM Destinations,DD_Category,Destinations_Category ";                         
                            sqlString1 += "WHERE Destinations.id=DD_Category.destination_id AND Destinations_Category.id=DD_Category.category_id ";
                            if (Category.length==1)
                                sqlString1 += "AND category_id LIKE '%" + Category[0] + "%';";
                            else if (Category.length==2)
                                sqlString1 += "AND (category_id LIKE '%" + Category[0] + "%'" + " OR category_id LIKE '%" + Category[1] + "%');";
                            else
                               sqlString1 += "AND (category_id LIKE '%" + Category[0] + "%'" + " OR category_id LIKE '%" + Category[1] + "%'" + " OR category_id LIKE '%" + Category[2] + "%');";                             
                            ResultSet rs1 = myStatement.executeQuery(sqlString1);
                            int id[]= new int[5000];
                            int i=0,j;
                            int c_id[]= new int[5000];
                            int count[] = new int [5000];
                            String cou[]= new String[5000];
                            String to[]= new String[5000];
                            String u[]= new String[5000];
                            String un[]= new String[5000];
                            String del[]= new String[5000];
                            while(rs1.next()){
                                id[i]=rs1.getInt("destination_id");
                                c_id[i]=rs1.getInt("category_id");
                                cou[i]=rs1.getString("country");
                                to[i]=rs1.getString("town");
                                u[i]=rs1.getString("url");
                                un[i]=rs1.getString("toUsername(username)");
                                count[i]=rs1.getInt("count");
                                del[i]=rs1.getString("deleted");
                                i++;
                            }
                        %>
                         <table>
                            <tr>
                                <td>ΧΩΡΑ</td>
                                <td>ΠΟΛΗ</td>
                                <td>ΚΑΤΗΓΟΡΙΑ</td>                                
                                <td class="visible-lg visible-md visible-sm">URL</td>
                                <td class="visible-lg visible-md visible-sm">ΧΡΗΣΤΗΣ</td>
                                <td class="visible-lg visible-md visible-sm"></td>
                                <td class="visible-lg visible-md"></td>
                            </tr>
                        <%          
                             for (j=0; j<i; j++){
                                 if(del[j]==null){
                        %>
                                <tr>                                    
                                    <td><%out.println(cou[j]+" ");%></td>
                                    <td><%out.println(to[j]+" ");%></td>
                                    <td>
                                        <%switch(c_id[j]){
                                            case 100:out.println("Χειμερινοί ");out.println("("+count[j]+") ");break;
                                            case 101:out.println("Χριστουγεννιάτικοι ");out.println("("+count[j]+") ");break;
                                            case 102:out.println("Καλοκαιρινοί ");out.println("("+count[j]+") ");break;
                                        }%>
                                    </td>
                                    <td class="visible-lg visible-md visible-sm">
                                        <%if(!u[j].equals("")){%>                                        
                                            <a class="various fancybox.iframe" href="<%=u[j]%>?autoplay=1">                                            
                                                <span class="glyphicon glyphicon-globe"></span>
                                            </a>
                                        <%}%>
                                    </td>
                                    <td class="visible-lg visible-md visible-sm"><%out.println(un[j]+" ");%></td>
                                    <td class="visible-lg visible-md visible-sm">
                                        <form method="post" action="edit_destination.jsp">
                                            <input type="hidden" name="id" value="<%=Id%>">
                                            <input type="hidden" name="d_id" value="<%=id[j]%>">
                                            <input type="hidden" name="search" value="<%=Search%>">
                                            <input type="hidden" name="category" value="<%=c_id[j]%>">
                                            <input class="btn btn-register" type="submit" value="ΕΠΕΞΕΡΓΑΣΙΑ">
                                        </form>
                                    </td>
                                    <td class="visible-lg visible-md">
                                        <form method="post" action="delete_destination.jsp">
                                            <input type="hidden" name="id" value="<%=Id%>">
                                            <input type="hidden" name="d_id" value="<%=id[j]%>">
                                            <input type="hidden" name="search" value="<%=Search%>">
                                            <input type="hidden" name="category" value="<%=c_id[j]%>">
                                            <input class="btn btn-danger" type="submit" value="ΔΙΑΓΡΑΦΗ">
                                        </form>
                                    </td>
                                </tr>
                        <%
                                }
                            }
                        %>
                        </table>
                        <br>
                        <%
                        }   
                        %>
                        <form name="go_back" method="post" action="main.jsp">
                            <input type="hidden" name="user" value="<%=Username%>">
                            <input type="hidden" name="pass" value="<%=Password%>">
                            <center><input class="btn btn-default btn-lg" type="submit" value="Πίσω"></center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
