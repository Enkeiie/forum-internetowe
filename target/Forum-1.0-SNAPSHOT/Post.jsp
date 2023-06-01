<%-- 
    Document   : Post
    Created on : 29 lis 2021, 11:57:23
    Author     : Piotr
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <div class="container">
            <div class="view" style="margin-top: 15px; height: 80px; overflow-y: hidden">
            <ul>
                <%
                    int pid = 0;
                    try{
                        pid=Integer.parseInt(request.getParameter("id"));
                    }catch(Exception err){}
                    Statement st = null;
                    ResultSet rs = null;
                    try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    st = con.createStatement();
                    String qry ="select * from `Posts` where postID="+pid+";"; 
                    rs = st.executeQuery(qry);
                    while(rs.next()){
                    Statement st1 = null;
                    ResultSet rs1 = null;
                    st1 = con.createStatement();
                    String qry1 = "select Login from `Users` where userID="+rs.getString(4)+";";
                    rs1 = st1.executeQuery(qry1);
                    rs1.next();
                    %>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="3"><%=rs.getString(1)%>.<%=rs.getString(2)%></td>
                                    </tr>
                                    <tr>
                                        <td>Dodane przez: <%=rs1.getString(1)%></td>
                                    </tr>
                                    <tr>
                                        <td>Data dodania: <%=rs.getString(3)%></td>
                                    </tr>
                                </table>
                            </li>
                    <%
                        }
                        st.close();
                        con.close();
                        }
                        catch(Exception ex){
                        out.println(ex);
                        }
                    %>
                    </ul>
                    </div>
                    <h1 style="margin-left: 2%">Odpowiedzi:</h1>
                    <%
                     if(user!=null){
                    %>
                    <div class="ans">
                        <form class="ans" method="post" action="ResponseServlet?postID=<%=pid%>">
                            <textarea name="Answer" placeholder="Odpowiedz" ></textarea><input value="Prześlij" type="submit">
                        </form>
                    </div>
                    <%
                        }
                    %>
                    <div class="answers">
                        <ul>
                    <%
                    Statement st0 = null;
                    ResultSet rs0 = null;
                    try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    st0 = con.createStatement();
                    String qry ="select * from `Responses` where Post="+pid+";"; 
                    rs0 = st0.executeQuery(qry);
                    while(rs0.next()){
                    Statement st1 = null;
                    ResultSet rs1 = null;
                    st1 = con.createStatement();
                    String qry1 = "select Login from `Users` where userID="+rs0.getString(4)+";";
                    rs1 = st1.executeQuery(qry1);
                    rs1.next();
                    %>
                        <li>Użytkownik: <%=rs1.getString(1)%> dnia: <%=rs0.getString(5)%><br><br>
                        <%=rs0.getString(3)%></li>
                    <%
                        }
                        st0.close();
                        con.close();
                        }
                        catch(Exception ex){
                        out.println(ex);
                        }
                    %>
                    </ul>
                    </div>
                    </div>
                <%
                int nP=0;
                int nA=0;
                try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                ResultSet rs1 = null;
                st = con.createStatement();
                String qry ="select COUNT(*) FROM `Posts`"; 
                rs1 = st.executeQuery(qry);
                rs1.next();
                nP = rs1.getInt(1);
                st.close();
                st = con.createStatement();
                ResultSet rs2 = null;
                qry ="select COUNT(*) FROM `Responses`"; 
                rs2 = st.executeQuery(qry);
                rs2.next();
                nA = rs2.getInt(1);
                st.close();
                con.close();     
        }catch(Exception err){}
                %>
                <ul class="info">
                    <li>W naszym serwisie znajdziesz <%=nP%> problemów</li>
                    <li>Nasza społeczność udzieliła <%=nA%> odpowiedzi</li>
                </ul>
                <div class="posts">
                    <h1>Najnowsze posty</h1>
                    <ul>
                <%
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    ResultSet rs1 = null;
                    st = con.createStatement();
                    String qry ="select postId,Header from `Posts` order by Post_Date desc limit 3;"; 
                    rs1 = st.executeQuery(qry);
                    while(rs1.next()){
                %>
                    <a href="Post.jsp?id=<%=rs1.getInt(1)%>"><li><%=rs1.getString(2)%></li></a>
                <%
                    }
                    st.close();
                    con.close();
                    }catch(Exception err){}
                %>
                   
                    </ul>
                </div>
                <div class="footer">
                <%if(user!=null){%>
                    <ul>
                       <a href="Profile.jsp"><li>Moje konto</li></a>
                       <a href="Posts.jsp"><li>Moje pytania</li></a>
                       <a href="Comments.jsp"><li>Moje odpowiedzi</li></a>
                    </ul>
                <%}%>
                </div>
    </body>
</html>

