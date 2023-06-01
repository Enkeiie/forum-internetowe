<%-- 
    Document   : Login
    Created on : 28 lis 2021, 21:14:24
    Author     : Piotr
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Login Page</title>
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
                <div class="form">
                    <form action="RegisterServlet" method="post">
                        Username: <input type="text" name="user"><br><br>
                        Password: <input type="text" name="pwd"><br><br>
                        <input type="submit" value="Zarejestruj mnie!"><br>
                        Posiadasz konto? <a href="Login.jsp">Zaloguj się.</a>
                    </form>
                </div>
            </div>
    </body>
</html>