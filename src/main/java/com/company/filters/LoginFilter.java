package com.company.filters;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Piotr
 */
public class LoginFilter implements Filter {
    
@Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {    
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String user=null;
        String pwd=null;
       try{
            user=request.getParameter("user");
            pwd=request.getParameter("pwd");
        }catch(Exception err){
            response.sendRedirect(request.getContextPath()+"/Login.jsp");
        }
        Statement st = null;
        ResultSet rs = null;
        try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3308/forum?autoReconnect=true&useSSL=false","root","root");
                    st = con.createStatement();
                    String qry ="select count(*),userID from `Users` where  Login='"+user+"' AND Passwd='"+pwd+"';"; 
                    rs = st.executeQuery(qry);
                    rs.next();
                    int rso =rs.getInt(1);
                    String uid = rs.getString(2);
                    if(rso==0){
                        String strPath = "d:\\filter.txt";
                        File strFile = new File(strPath);
                        InetAddress uIP=InetAddress.getLocalHost();
                        FileWriter objWriter = new FileWriter(strFile,true);
                        objWriter.write(uIP.getHostAddress()+"\n");
                        objWriter.close(); 
                        response.sendRedirect(request.getContextPath()+"/Login.jsp");
                    }else{
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user",user);
                        session.setAttribute("uid",uid);
                        response.sendRedirect(request.getContextPath()+"/");
                    }
        }catch(Exception err){}
        chain.doFilter(req,res);
    }
    
}
