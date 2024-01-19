<%--
    Document   : booking
    Created on : 04-Nov-2023, 3:13:11 am
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking</title>
        <style>
            .input-field {
                border: 1px solid #000;
                padding: 5px;
            }
        </style>
    </head>
    <body>
        <h1 align="center">Booking ticket</h1>
        <c:set var="price" value="${param.price}" scope="session"></c:set>
        <!-- Display Booking Information -->
        <div>
            <h2>Booking Information</h2>
            <p>Date: <c:out value="${date}"></c:out></p>
            <c:set var="TrainName" value="${param.booked_train}" scope="session"></c:set>
            <p>Train Name: <c:out value="${TrainName}"></c:out></p>
            <c:set var="TrainDeparture" value="${param.departure_time}" scope="session"></c:set>
            <p>Departure Time: <c:out value="${TrainDeparture} PM"></c:out></p>
            <c:set var="TrainArrival" value="${param.arrival_time}" scope="session"></c:set>
            <p>Arrival Time: <c:out value="${TrainArrival} AM"></c:out></p>
        </div>
        
        
        <c:set var="no_passengers" value="${param.number}" scope="session"></c:set>
        <h1>Passenger Information Form</h1>
        
        <%--<c:forEach var="i" begin="1" end="${no_passengers}">--%>  
        
        <form action="bookticket" method="post">
            <c:forEach var="i" begin="1" end="${no_passengers}">
                <div class="input-field">
        <label for="first_name${i}">First Name:</label>
        <input type="text" id="first_name${i}" name="first_name${i}" required><br><br>
        
        <label for="last_name${i}">Last Name:</label>
        <input type="text" id="last_name${i}" name="last_name${i}" required><br><br>
        
        <label for="age${i}">Age:</label>
        <input type="number" id="age${i}" name="age${i}" required><br><br>
                </div>
        </c:forEach>
        <input type="submit" value="submit">
          </form>
    </body>
</html>
