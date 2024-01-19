/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author user
 */
public class bookticket extends HttpServlet 
{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html");
        PrintWriter out=response.getWriter();
        out.println("<h3 align=\"center\">Ticket Confirmation</h3>");
        HttpSession session=request.getSession();
        
        out.println("<p><strong>From:</strong>"+session.getAttribute("from")+"</p>");
        out.println("<p><strong>To:</strong>"+session.getAttribute("to")+"</p>");
        out.println("<p><strong>Coach:</strong>"+session.getAttribute("coach")+"</p>");
        out.println("<p><strong>Date:</strong>"+session.getAttribute("date")+"</p>");
        String pr=(String) session.getAttribute("price");
        int final_price=Integer.parseInt(pr);
        String passengers=(String) session.getAttribute("no_passengers");
        int no=Integer.parseInt(passengers);
        System.out.println(no);
        final_price*=no;
        String firstName[]=new String[no];
        String lastName[]=new String[no];
        int age[]=new int[no];
        int i=1;
        for(i=1;i<=no;i++)
        { 
            firstName[i-1]=request.getParameter("first_name"+i);
            lastName[i-1]=request.getParameter("last_name"+i);
            String dummy=request.getParameter("age"+i);
            age[i-1]=Integer.parseInt(dummy);
        }
        session.setAttribute("FName", firstName);
        session.setAttribute("LName", lastName);
        session.setAttribute("Age", age);
        out.println("Passenger details : ");
        for(i=1;i<=no;i++)
        { 
            
        out.println("<p><strong>First Name :</strong>"+firstName[i-1]+"</p>");
        out.println("<p><strong>Last Name:</strong>"+lastName[i-1]+"</p>");
        out.println("<p><strong>Age:</strong>"+age[i-1]+"</p>");
            //out.println(firstName[i-1]);
            //out.println(lastName[i-1]);
            //out.println(age[i-1]);
        }
        out.println("Amount : "+final_price);
        session.setAttribute("price", final_price);
        response.getWriter().println("<form method=\"post\" action=\"PDFGenerator\">");
        response.getWriter().println("<input type=\"submit\" value=\"Book Ticket\">");
        response.getWriter().println("</form>");
        //response.sendRedirect("PDFGenerator");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        doGet(request,response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
