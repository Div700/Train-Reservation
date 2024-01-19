<%-- 
    Document   : login_process
    Created on : 29-Oct-2023, 9:49:34 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Ticket</title>
    </head>
    <body>
        
    <c:set var="user_number" value="${param.Number}"/>
    <c:set var="pass" value="${param.Password}"/>
    <c:out value="user_number"></c:out>
    <c:out value="pass"></c:out>
        <sql:setDataSource 
        var="con" driver="com.mysql.jdbc.Driver" 
         url="jdbc:mysql://localhost/train_reservation" user="root" password="Password67*"/>
        <sql:query dataSource="${con}" var="result">
            Select * from users;
        </sql:query>
           
         <c:forEach var = "row" items = "${result.rows}">
                 
             <c:set var="s1" value="${row.Number}" scope="page"></c:set>
             <c:set var="s2" value="${row.Password}" scope="page"></c:set>
             <c:out value="s1"></c:out>
             <c:out value="s2"></c:out>
             <c:if test="${s1 eq user_number && s2 eq pass}">   
                 <c:set var="name" value="${row.Name}" scope="session"></c:set>
                 <c:redirect url="input_train.jsp"></c:redirect>
            </c:if>
         </c:forEach>
                 <c:redirect url="invalid.html"></c:redirect>
    </body>
</html>