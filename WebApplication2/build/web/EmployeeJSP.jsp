<%-- 
    Document   : EmployeeJSP
    Created on : 11-May-2022, 16:16:16
    Author     : Dell
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="obj" class="classes.NewClass" type="classes.NewClass" scope="session"/>
<jsp:setProperty  property="name" name="obj" param="emName" />
<jsp:setProperty name="obj" property="salary" value="<%= Double.parseDouble(request.getParameter("emSalary"))%>"/>
<jsp:setProperty name="obj" property="ssn" param="emID"/>
<%  
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system" ,"1234" );
    Statement s=c.createStatement();
    s.executeUpdate("create table employee (ename varchar(25),salary decimal,ssn char(9),primary key(ssn) )");
    
    PreparedStatement ps=c.prepareStatement("insert into employee values(?,?,?)");
    ps.setString(1, obj.getName());
    ps.setDouble(2, obj.getSalary());
    ps.setLong(3, obj.getSsn());
    ps.execute();
    
ResultSet rs=s.executeQuery("select * from employee");

while (rs.next())
{%>
    <%=rs.getString(1)%>
<%}
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
