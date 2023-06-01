<%-- 
    Document   : index
    Created on : 27 lis 2021, 16:38:42
    Author     : Piotr
--%>

<%@page import="java.util.List"%>
<%@page import="java.io.Console"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>myForum.pl</title>
    </head>
   <%
        String color="white";
        try{
            request.getSession(false);
            color = request.getSession().getAttribute("browser").toString();
            }catch(java.lang.NullPointerException err){}
    %>
    <body style="background-color: <%=color%>">
        <ul class="menu">
            <a href="index.jsp"><li>myForum.pl</li></a>
            <ol>
                <%
                String user;
                try{
                request.getSession(false);
                user = request.getSession().getAttribute("user").toString();
                }catch(java.lang.NullPointerException err){ user=null;}
                if(user==null){
            %>
                <a href="Login.jsp"><li>Logowanie</li></a>
                <a href="Register.jsp"><li>Rejestracja</li></a>
            <%
                }else{
            %>
                <a href="#"><li><%=user%></li></a>
                <a href="LogoutServlet"><li>Wyloguj</li></a>
            <%
                }
            %>
            </ol>
        </ul>
            <div class="holder">
                <div class="view" style="width: 50%; height: 89.5vh; overflow-y: auto;">
                     <h1>Znalezione posty:</h1>
                    <ul>
                <%
                    String phrase="";
                    int limiter = 5;
                    try{
                    String lt = application.getInitParameter("limiter");
                    limiter = Integer.parseInt(lt);
                    phrase = request.getParameter("phrase");
                    }catch(Exception err){}
                    Statement st = null;
                    ResultSet rs = null;
                    try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    st = con.createStatement();
                    String qry ="select * from `Posts` where Header like '%"+phrase+"%';"; 
                    rs = st.executeQuery(qry);
                    while(rs.next()){
                    Statement st1 = null;
                    ResultSet rs1 = null;
                    st1 = con.createStatement();
                    String qry1 ="select count(responseID) from Responses where Post="+rs.getInt(1)+";";
                    rs1 = st1.executeQuery(qry1);
                    rs1.next();
                    %>
                     <a href="Post.jsp?id=<%=rs.getInt(1)%>"><li style="margin-top: 15px;">
                                <table>
                                    <tr>
                                        <td rowspan="3"><%=rs.getString(1)%>.<%=rs.getString(2)%></td>
                                    </tr>
                                    <tr>
                                        <td>Ilość odpowiedzi: <%=rs1.getString(1)%></td>
                                    </tr>
                                    <tr>
                                        <td>Data dodania: <%=rs.getString(3)%></td>
                                    </tr>
                                </table>
                            </li></a>
                    <%
                        }
                        con.close();
                        st.close();
                        }
                        catch(Exception ex){
                        out.println(ex);
                        }
                    %>
                       </ul>
                </div>
            </div>
    </body>
</html>
