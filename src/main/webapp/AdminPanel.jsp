<%-- 
    Document   : AdminPanel
    Created on : 17 sty 2022, 13:13:37
    Author     : Piotr
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            table{
                border-collapse: collapse;
            }
            tr{
                border: 1px solid black;
            }
            td,th{
                border: 1px solid black;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <table>
            <tr>
                <th>ID</th>
                <th>Tytul</th>
                <th>Data dodania</th>
                <th>Uzytkownik</th>
            </tr>
        <%
                Statement st = null;            
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    ResultSet rs1 = null;
                    st = con.createStatement();
                    String qry ="select * from `Posts`;"; 
                    rs1 = st.executeQuery(qry);
                    while(rs1.next()){
                %>
                <tr>
                    <td><%=rs1.getInt(1)%></td>
                     <td><%=rs1.getString(2)%></td>
                      <td><%=rs1.getString(3)%></td>
                       <td><%=rs1.getInt(4)%></td>
                       <form method="get" action="RemovePostServlet">
                           <input name="ID" style="display: none;" type="text" value="<%=rs1.getString(1)%>"/> 
                       <td><input type="submit" value="USUN"/></td>
                       </form>
                </tr>
                <%
                    }
                    st.close();
                    con.close();
                    }catch(Exception err){}
                %>
                                </table><br><br>
                            <table>
                                <tr>
                <th>ID</th>
                <th>Tytul</th>
                <th>Data dodania</th>
                <th>Uzytkownik</th>
            </tr>
        <%
                Statement st1 = null;            
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    ResultSet rs1 = null;
                    st = con.createStatement();
                    String qry ="select * from `Posts`;"; 
                    rs1 = st.executeQuery(qry);
                    while(rs1.next()){
                %>
                    <tr>
                                        <form method="get" action="EditPostServlet">
                    <td><%=rs1.getInt(1)%></td>
                     <td><input type="text" value="<%=rs1.getString(2)%>" name="getHeader"/></td>
                      <td><%=rs1.getString(3)%></td>
                       <td><%=rs1.getInt(4)%></td>
                    <input name="ID" style="display: none;" type="text" value="<%=rs1.getInt(1)%>"/> 
                       <td><input type="submit" value="EDYTUJ"/></td>
                </form>
                       </tr>
                                       <%
                    }
                    st.close();
                    con.close();
                    }catch(Exception err){}
                %>
    </table><br><br>
                     <table>
            <tr>
                <th>Post</th>
                <th>Tresc</th>
                <th>Użytkownik</th>
                <th>Data dodania</th>
            </tr>
        <%
                st = null;            
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    ResultSet rs1 = null;
                    st = con.createStatement();
                    String qry ="select * from `Responses`;"; 
                    rs1 = st.executeQuery(qry);
                    while(rs1.next()){
                %>
                <tr>
                    <td><%=rs1.getInt(2)%></td>
                     <td><%=rs1.getString(3)%></td>
                      <td><%=rs1.getInt(4)%></td>
                       <td><%=rs1.getString(5)%></td>
                       <form method="get" action="RemoveResponseServlet">
                           <input name="ID" style="display: none;" type="text" value="<%=rs1.getString(1)%>"/> 
                       <td><input type="submit" value="USUN"/></td>
                       </form>
                </tr>
                <%
                    }
                    st.close();
                    con.close();
                    }catch(Exception err){}
                %>
                                </table><br><br>
                            <table>
                                <tr>
                <th>Post</th>
                <th>Tresc</th>
                <th>Użytkownik</th>
                <th>Data dodania</th>
            </tr>
        <%
                st1 = null;            
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    ResultSet rs1 = null;
                    st = con.createStatement();
                    String qry ="select * from `Responses`;"; 
                    rs1 = st.executeQuery(qry);
                    while(rs1.next()){
                %>
                                <form method="get" action="EditResponseServlet">
                    <tr>
                    <td><%=rs1.getInt(2)%></td>
                     <td><input type="text" value="<%=rs1.getString(3)%>" name="getHeader"/></td>
                      <td><%=rs1.getInt(4)%></td>
                       <td><%=rs1.getString(5)%></td>
                    <input name="ID" style="display: none;" type="text" value="<%=rs1.getInt(1)%>"/> 
                       <td><input type="submit" value="EDYTUJ"/></td>
                </form>
                       </tr>
                                       <%
                    }
                    st.close();
                    con.close();
                    }catch(Exception err){}
                %>
                    </table>
    </body>
</html>
