<%-- 
    Document   : Comments
    Created on : 13 gru 2021, 13:14:26
    Author     : Piotr
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="styles.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                int uid=-1;
                String user;
                try{
                request.getSession(false);
                user = request.getSession().getAttribute("user").toString();
                uid = Integer.parseInt(request.getSession().getAttribute("uid").toString());
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
                <div class="answers" style="width: 490px; height: 89.5vh; overflow-y: auto;">
                     <h1>Znalezione komentarze:</h1>
                    <ul>
                <%
                    Statement st = null;
                    ResultSet rs = null;
                    try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    st = con.createStatement();
                    String qry ="select * from `Responses` where User="+uid+";"; 
                    rs = st.executeQuery(qry);
                    while(rs.next()){
                    Statement st1 = null;
                    ResultSet rs1 = null;
                    st1 = con.createStatement();
                    String qry1 ="select Login from Users where userID="+uid+";";
                    rs1 = st1.executeQuery(qry1);
                    rs1.next();
                    %>
                    <a href="Post.jsp?id=<%=rs.getInt(2)%>"><li>Użytkownik: <%=rs1.getString(1)%> dnia: <%=rs.getString(5)%><br><br>
                    <%=rs.getString(3)%></li></a>
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
