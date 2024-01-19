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
import java.io.FileOutputStream;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author user
 */
public class PDFGenerator extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("application/pdf");
        try {
            HttpSession session=request.getSession();
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Set font for the document
            Font font = new Font(Font.FontFamily.HELVETICA, 12);
            Paragraph title=new Paragraph("TICKET",font);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            // Add details
            document.add(new Paragraph("Train Name: "+session.getAttribute("TrainName"), font));
            document.add(new Paragraph("From: "+session.getAttribute("from"), font));
            document.add(new Paragraph("To: "+session.getAttribute("to"), font));
            document.add(new Paragraph("Date: "+session.getAttribute("date"), font));
            document.add(new Paragraph("Departure: "+session.getAttribute("TrainDeparture")+" PM", font));
            document.add(new Paragraph("Arrival: "+session.getAttribute("TrainArrival")+" AM", font));
            document.add(new Paragraph("Coach: "+session.getAttribute("coach"), font));
            String passengers=(String) session.getAttribute("no_passengers");
            int no=Integer.parseInt(passengers);
            String firstName[]=new String[no];
            String lastName[]=new String[no];
            int age[]=new int[no];
            firstName=(String[]) session.getAttribute("FName");
            lastName=(String[]) session.getAttribute("LName");
            age= (int[]) session.getAttribute("Age");
            for(int i=0;i<no;i++)
            {
                
            document.add(new Paragraph("Passenger"+(i+1), font));
            // Create a table for passenger information
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            table.setWidths(new int[]{1, 1, 1});

            PdfPCell cell1 = new PdfPCell(new Phrase("First Name", font));
            PdfPCell cell2 = new PdfPCell(new Phrase("Last Name", font));
            PdfPCell cell3 = new PdfPCell(new Phrase("Age", font));

            table.addCell(cell1);
            table.addCell(cell2);
            table.addCell(cell3);

            // Add passengers (You can iterate over your passenger data here)
            table.addCell(new Phrase(firstName[i], font));
            table.addCell(new Phrase(lastName[i], font));
            table.addCell(new Phrase(Integer.toString(age[i]), font));


            // Add the passenger table to the document
            document.add(table);
            }
            // Add total price
            document.add(new Paragraph("Amount paid: "+session.getAttribute("price"), font));

            document.close();
        } catch (DocumentException ex) {
            Logger.getLogger(PDFGenerator.class.getName()).log(Level.SEVERE, null, ex);
        }
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
