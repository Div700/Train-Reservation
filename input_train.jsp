<%-- 
    Document   : input_train
    Created on : 29-Oct-2023, 10:17:55 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Reservation Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; 
            background-image: url('backiee-85638.jpg');
           background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            height: 100vh;
        }

        .content-container {
            background-color: rgba(255, 255, 255, 0.8); /* Background opacity with rgba */
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
            text-align: center;
            /*transform: translateX(-50%);*/
            margin: 50px;
            display:flex;
        }

        .reservation-form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
        }

        .reservation-form h2 {
            text-align: center;
        }

        .reservation-form form {
            display: flex;
            flex-direction: column;
        }

        .reservation-form label {
            margin: 10px 0;
            font-weight: bold;
        }

        .reservation-form select, .reservation-form input[type="date"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .reservation-form input[type="submit"] {
            background: #007BFF;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        .reservation-form input[type="submit"]:hover {
            background: #0056b3;
        }
        .train-list {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .train-item {
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 10px;
            padding: 10px;
            width: 300px;
            text-align: center;
            background-color: #f9f9f9;
        }

        .train-name {
            font-weight: bold;
        }

        .train-details {
            margin-top: 10px;
        }
        .moving-message {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: #ff6666; /* Coral red background */
            color: #fff; /* White text color */
            text-align: center;
            padding: 10px;
            font-size: 24px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            animation: moveMessage 10s ease-in-out infinite;
        }

        /* Additional styles */
        .moving-message::before {
            content: "🚄 ";
            font-size: 30px;
            margin-right: 10px;
        }

        .moving-message:hover {
            background-color: #ff3366; /* Darker coral red on hover */
        }

        .moving-message:active {
            background-color: #ff0033; /* Darkest coral red on click */
        }

        .moving-message:hover::before {
            content: "🛤️ ";
        }

        @keyframes moveMessage {
            0% {
                transform: translateX(100%);
            opacity: 0;
                transform: scaleY(0.2);
            }
            50% {
                transform: translateX(0);
                opacity: 1;
                transform: scaleY(1.2);
            }
            100% {
                transform: translateX(-100%);
                opacity: 0;
                transform: scaleY(0.2);
            }
        }
        .logout-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #ff6666;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="moving-message">The updated information of your bookings will show here.</div>
    <%--<c:out value="${sessionScope.name}"></c:out>--%>
    <div class="content-container">
        <div class="reservation-form">
            <h2>Train Reservation Form</h2>
            <form method="post">
                <label for="from">From:</label>
                <select id="from" name="from" required>
                    <option value="ADI">Ahmedabad Jn Station</option>
                    <option value="NDLS">New Delhi Station</option>
                    <option value="MAS">Mgr Chennai Central Station</option>
                </select>
                <c:set var="from" value="${param.from}" scope="session"></c:set>

                <label for="to">To:</label>
                <select id="to" name="to" required>
                    <option value="ADI">Ahmedabad Jn Station</option>
                    <option value="NDLS">New Delhi Station</option>
                    <option value="MAS">Mgr Chennai Central Station</option>
                </select>
                <c:set var="to" value="${param.to}" scope="session"></c:set>

                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
                <c:set var="date" value="${param.date}" scope="session"></c:set>

                <label for="coach">Class:</label>
                <select id="coach" name="coach" required>
                    <option value="AC1">AC1</option>
                    <option value="AC2">AC2</option>
                    <option value="AC3">AC3</option>
                    <option value="Sleeper">Sleeper</option>
                </select>
                <c:set var="coach" value="${param.coach}" scope="session"></c:set>

                <input type="submit" value="Submit">
            </form>
        </div>
    </div>

    <sql:setDataSource 
        var="con" driver="com.mysql.jdbc.Driver" 
        url="jdbc:mysql://localhost/train_reservation" user="root" password="Password67*"/>
    <sql:query dataSource="${con}" var="result">
        Select * from train_details;
    </sql:query>
    <c:forEach var="row" items="${result.rows}">
        <c:set var="s1" value="${row.FromStation}" scope="page"></c:set>
        <c:set var="s2" value="${row.ToStation}" scope="page"></c:set>
        <c:if test="${s1 eq from && s2 eq to}">   
        <div class="train-list">
        <div class="train-item">
            <div class="${row.train_name}">Train ${row.train_name}</div>
            <div class="train-details">
                <p>From: ${from}</p>
                <p>To: ${to}</p>
                <p>Departure: ${row.departure} PM</p>
                <p>Expected Arrival: ${row.expected_arrival} AM</p>
                <sql:query dataSource="${con}" var="innerresult">
                    Select price from price where train_id = ? and coach_name=?;
                    <sql:param value="${row.train_id}"></sql:param>
                    <sql:param value="${coach}"></sql:param>
                </sql:query>
                    <c:set var="pr" value="${innerresult.rows[0].price}"></c:set>
                <p>Price: ${pr}</p>
                <form action="booking.jsp" method="post">
                    <input type="hidden" name="booked_train" value="${row.train_name}">
                    <input type="hidden" name="arrival_time" value="${row.expected_arrival}">
                    <input type="hidden" name="departure_time" value="${row.departure}">
                    <input type="hidden" name="price" value="${pr}">
                    <label for="number">Select a number between 1 and 4:</label>
                    <select id="number" name="number">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    </select>
                    <input type="submit" action="booking.jsp">
                    
                </form>
            </div>
        </div>
        </c:if>
    </c:forEach>
            <button class="logout-button" onclick="confirmLogout()">Logout</button>
            <script>
        function confirmLogout() {
            const logoutConfirmed = confirm("Are you sure you want to logout?");
            if (logoutConfirmed) {
                // Redirect to the home page (replace 'home.html' with the actual URL)
                window.location.href = 'index.html';
            }
        }
</script>
        
</body>
</html>


