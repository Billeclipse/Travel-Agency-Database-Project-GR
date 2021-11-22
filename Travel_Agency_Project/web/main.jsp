
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String Username = request.getParameter("user");
    String Password = request.getParameter("pass");
    int num=0;
    int id=0;
    String u[]= new String[5000];
    String p[]= new String[5000];
    int d[]= new int[5000];
    String em="";
    boolean flag=false,flag2=false,flag3=false;
    Class.forName("com.mysql.jdbc.Driver");
    String myDatabase= "jdbc:mysql://localhost:3306/mydb?user=root&password=2524";
    Connection myConnection = DriverManager.getConnection(myDatabase);
    Statement myStatement = myConnection.createStatement();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">             
        <link rel="stylesheet" href="pop-up-box.css" type="text/css"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css"/>
        <script type="text/javascript" src="Javascript/jquery.min.js"></script>                
        <script type="text/javascript" src="Javascript/bootstrap.min.js"></script>
        <link href="select/select2.min.css" rel="stylesheet" type="text/css"/>     
        <script src="select/select2.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="fancybox/jquery.fancybox.css" type="text/css" media="screen" />
        <script type="text/javascript" src="fancybox/jquery.fancybox.pack.js"></script>
        <link rel="stylesheet" href="MyCSS.css" type="text/css"/> 
        <title>Main Page</title>
        <script type="text/javascript">            
                function toggle_visibility(id) {
                   var e = document.getElementById(id);
                   if(e.style.display === 'block')
                      e.style.display = 'none';
                   else
                      e.style.display = 'block';
                }
        </script>
    </head>
    <body class="my-Main-Body">
        <div id="popupBoxOnePosition">
            <div class="popupBoxWrapper">
                    <div class="popupBoxContent">
                        <p><a style="margin-left:92%;" href="javascript:void(0)" onclick="toggle_visibility('popupBoxOnePosition');"><span class="closeX glyphicon glyphicon-remove"></span></a></p>
                        <iframe style="border: 0px #fff solid; border-radius: 5%;" src="create_destination.html?user=<%=Username%>" height="470" width="500" allowTransparency="true" scrolling="no" frameborder="0"></iframe>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-0"></div>
                    <div class="col-lg-9 col-md-9 col-sm-11 col-xs-12">
                        <div class="box-main">                            
                            <%
                            String sqlString = "SELECT username,password,deleted FROM users;";
                            ResultSet rs=myStatement.executeQuery(sqlString);
                            while(rs.next()){
                                u[num]=rs.getString("username");
                                p[num]=rs.getString("password");
                                d[num]=rs.getInt("deleted");
                                num++;
                            }
                            for(int i=0; i<num; i++) { 
                                if (Username.equals("admin") && Password.equals("pass") && d[i]==1)
                                {
                                    flag3=true;
                                    flag2=true;
                                    break;
                                }
                                if(u[i].equals(Username) && p[i].equals(Password) && d[i]==1){
                                    flag=true;
                                    flag2=true;
                                    break;
                                }
                                else if (u[i].equals(Username) && d[i]==1){
                                    flag=true;
                                    break;
                                }
                            }
                            if(flag3==true){
                                String sqlString2 = "SELECT * FROM users;";            
                                ResultSet rs2=myStatement.executeQuery(sqlString2);
                                int i=0,j,id2[]=new int[5000];         
                                String em2[]= new String[5000];
                                int d2[]= new int[5000];
                                while(rs2.next()){
                                    id2[i]=rs2.getInt("U_id");
                                    em2[i]=rs2.getString("email");
                                    d2[i]=rs2.getInt("deleted");
                                    i++;
                                }
                                String sqlString3 = "SELECT destination_id,category_id,country,town,url,toUsername(username),toUsername(deleted) FROM Destinations,DD_Category ";
                                sqlString3+= "WHERE Destinations.id=DD_Category.destination_id";            
                                ResultSet rs3=myStatement.executeQuery(sqlString3);
                                int m=0,d_id[]=new int[5000],c_id[]=new int[5000];         
                                String co[]= new String[5000];
                                String to[]= new String[5000];
                                String url[]= new String[5000];
                                String n[]= new String[5000];
                                String del[]= new String[5000];
                                while(rs3.next()){
                                    d_id[m]= rs3.getInt("destination_id");
                                    c_id[m]= rs3.getInt("category_id");
                                    co[m]= rs3.getString("country");
                                    to[m]= rs3.getString("town");
                                    url[m]= rs3.getString("url");
                                    n[m]= rs3.getString("toUsername(username)");
                                    del[m]= rs3.getString("toUsername(deleted)");
                                    m++;
                                }
                            %>
                                <div class="row">
                                    <div class="col-lg-5 col-md-6 col-sm-6 col-xs-9">
                                        <% out.println("Καλώς Όρισες, " + Username + "<br>");%>
                                    </div>
                                    <div class="col-lg-5 col-md-4 col-sm-4 col-xs-0"></div>
                                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-3">
                                        <a class="btn btn-danger btn-lg" href="index.html">Έξοδος</a>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <h3>Χρήστες</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <hr>
                                    </div>
                                </div>
                                <table>
                                    <tr>
                                    <td>ID</td>
                                    <td>USERNAME</td>
                                    <td>EMAIL</td>
                                    </tr>
                            <%                      
                                    for (j=1; j<i; j++){
                                        if(d2[j]==1){
                            %>
                                    <tr>
                                        <td><%out.println(id2[j]+" ");%></td>
                                        <td><%out.println(u[j]+" ");%></td>
                                        <td><%out.println(em2[j]+" ");%></td>
                                        <td>
                                            <form method="post" action="edit.jsp">
                                                <input type="hidden" name="user" value="<%=Username%>">
                                                <input type="hidden" name="pass" value="<%=Password%>">
                                                <input type="hidden" name="Id" value="<%=id2[j]%>">
                                                <input class="btn btn-register btn-lg" type="submit" value="ΕΠΕΞΕΡΓΑΣΙΑ">
                                            </form>
                                        </td>
                                        <td class="visible-lg visible-md visible-sm"><a class="btn btn-danger btn-lg" href=<%= "\"delete.jsp?Id=" + String.valueOf(id2[j]) + "\"" %> >ΔΙΑΓΡΑΦΗ</a></td>
                                    </tr>
                            <%
                                        }
                                    }
                            %>  
                                </table>
                                <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <h3>Προορισμοί</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <hr>
                                    </div>
                                </div>
                                <table>
                                    <tr>
                                        <td>ΧΩΡΑ</td>
                                        <td>ΠΟΛΗ</td>
                                        <td>ΚΑΤΗΓΟΡΙΑ</td>
                                        <td>URL</td>
                                        <td>ΧΡΗΣΤΗΣ</td>
                                        <td></td>
                                    </tr>
                            <%                      
                                    for (j=0; j<m; j++){
                            %>
                                    <tr>                                        
                                        <td><%out.println(co[j]+" ");%></td>
                                        <td><%out.println(to[j]+" ");%></td>
                                        <td>
                                            <%switch(c_id[j]){
                                                case 100:out.println("Χειμερινοί");break;
                                                case 101:out.println("Χριστουγεννιάτικοι");break;
                                                case 102:out.println("Καλοκαιρινοί");break;
                                            }%>
                                        </td>
                                        <td>
                                            <%if(!url[j].equals("")){%>                                        
                                                <a class="various fancybox.iframe" href="<%=url[j]%>?autoplay=1">                                            
                                                    <span class="glyphicon glyphicon-globe"></span>
                                                </a>
                                            <%}%>
                                        </td>
                                        <td><%out.println(n[j]+" ");%></td>
                                        <td class="visible-lg visible-md visible-sm">
                                            <%if(del[j]!=null){%> 
                                                <form method="post" action="delete_destination_admin.jsp">
                                                    <input type="hidden" name="user" value="<%=Username%>">
                                                    <input type="hidden" name="pass" value="<%=Password%>">
                                                    <input type="hidden" name="d_id" value="<%=d_id[j]%>">
                                                    <input type="hidden" name="c_id" value="<%=c_id[j]%>">
                                                    <input class="btn btn-danger" type="submit" value="ΔΙΑΓΡΑΦΗ">
                                                </form>
                                        </td> 
                                        <td class="visible-lg visible-md">από <%=del[j]%></td>
                                        <%}%>
                                    </tr>
                            <%
                                    }
                            %>  
                                </table>
                            <%            
                            }
                            else if (flag==true && flag2==true){
                                String sqlString2 = "SELECT * FROM users WHERE username=('" + Username + "');";            
                                ResultSet rs2=myStatement.executeQuery(sqlString2);           
                                while(rs2.next()){
                                    id=rs2.getInt("U_id");
                                    em=rs2.getString("email");
                                }
                            %>                                              
                            <div class="row">
                                <div class="col-lg-5 col-md-6 col-sm-6 col-xs-8">
                                    <% out.println("Καλώς Όρισες, " + Username + "<br>");%>
                                </div>
                                <div class="col-lg-5 col-md-4 col-sm-4 col-xs-0"></div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-4">
                                    <a class="btn btn-danger btn-lg" href="index.html">Έξοδος</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <h3>Αναζήτηση προορισμών</h3>
                                </div>
                                <div style="margin-top:20px;" class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                    <form name="create_destination" method="get" action="javascript:void(0)">                                        
                                        <input class="btn btn-default btn-lg" type="submit" value="Εισαγωγή νέου προορισμού" onclick="toggle_visibility('popupBoxOnePosition');">   
                                    </form> 
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-10 col-md-11 col-sm-11 col-xs-12">
                                    <hr>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">                                        
                                    <div id="col" style="padding:10px;margin-bottom:20px;border:0px;border-radius:5px;" class="bg-info collapse">
                                    Για αναζήτηση ενός συγκεκριμένου προορισμού συμπληρώστε το textbox ενώ για αναζήτηση κατηγορίας 
                                    προορισμών αφήστε κενό το textbox και επιλέξτε κατηγορία.
                                    </div>
                                </div>
                            </div>
                            <div class="row">                                
                                <form name="search" method="post" action="search.jsp" >
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                                        <a href="#col" data-toggle="collapse" style="margin-left:10px;">                                            
                                            <span class="glyphicon glyphicon-info-sign"></span>
                                        </a>                                        
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <input class="box-input" type="text" name="search" maxlength="20" style="height:42px;">
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <select name="category" class="sin select2-container" multiple="" style="width:220px;">
                                            <option value="100">Χειμερινοί</option>
                                            <option value="101">Χριστουγεννιάτικοι</option>
                                            <option value="102">Καλοκαιρινοί</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                                        <input class="btn btn-default btn-lg" type="submit" value="Αναζήτηση">
                                    </div>
                                </form>                                    
                            </div>                                
                            <%
                            }            
                            else if (flag==false && flag2==false){
                            %>
                                <center>
                            <%
                                out.println("Το Username και το password είναι λάθος!" + "<br>");
                                out.println("Μπορείτε να εγγραφτείτε αν θέλετε..." + "<br>");
                            %>
                                <a class="btn btn-default btn-lg" href="index.html">Πίσω</a>
                                </center>
                            <%
                            }
                            else if (flag2==false){
                            %>
                                <center>
                            <%
                                out.println("Το Password είναι λάθος" + "<br>"); 
                            %>
                                <a class="btn btn-default btn-lg" href="index.html">Πίσω</a>
                                </center>
                            <%
                            }
                            myStatement.close();
                            myConnection.close();
                            %>
                    </div>       
                </div>        
            </div>             
        </div>
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
        <script type="text/javascript">
            $(".sin").select2();
        </script>            
    </body>
</html>
