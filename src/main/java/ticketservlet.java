
import java.sql.*;
import java.io.IOException;
import java.io.Serial;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.util.JDBCUtil;


/**
 * Work in progress......
 */

@WebServlet("/ticketServlet")
public class ticketServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
   

    
     /* Default constructor.*/
     
    public ticketServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html");
    	
    	 Cookie ck[] = request.getCookies();
    	 String Email = "";
    	 if (ck != null) {
    	 	for (int i = 0; i < ck.length; ++i) {
    	 		if (ck[i].getName().equals("GEmail") && !(ck[i].getValue().contentEquals(""))) {
    	 			Email = java.net.URLDecoder.decode(ck[i].getValue(), "UTF-8");
    	 		} else if (ck[i].getName().equals("Email") && !(ck[i].getValue().contentEquals(""))) {
    	 			Email = ck[i].getValue().replace("&"," " );
    	 		}
    	 	}
    	 }
    	
    	String error = "";
    	
    	String name = request.getParameter("name");
    	if (name == null) name = "";
    	
    	String date = request.getParameter("date");
    	if (date == null) date = "";
    	
    	String airport = request.getParameter("airport");
    	if (airport == null) airport = "";

    	String time = request.getParameter("time");
    	if (time == null) time = "";
    	
    	String location = request.getParameter("location");
    	if (location == null) location = "";
    	
    	String number = request.getParameter("number");
    	if (number == null) number = "";
    	
    	
    	
    	// do Error Checking
    	
    	if (error.contentEquals("")) {

    		try {

    			Class.forName("com.mysql.cj.jdbc.Driver");
    			Connection con= new JDBCUtil().getConnection();

    			PreparedStatement addTicket = con.prepareStatement("INSERT INTO SHAIRPORT.tickets(pickupdate, airport, pickuptime, location, phonenumber) VALUES (?, ?, ?, ?, ?)");
    			
    			addTicket.setString(1, date);
    			addTicket.setString(2, airport);
    			addTicket.setString(3, time);
    			addTicket.setString(4, location);
    			addTicket.setString(5, number);
    			addTicket.executeUpdate();
    			
    			
    			addTicket = con.prepareStatement("SELECT ticketID from SHAIRPORT.tickets where pickupdate = ? and airport = ? and pickuptime = ? and location = ? and phonenumber = ?");
    			addTicket.setString(1, date);
    			addTicket.setString(2, airport);
    			addTicket.setString(3, time);
    			addTicket.setString(4, location);
    			addTicket.setString(5, number);
    			ResultSet rs = addTicket.executeQuery();
    			rs.next();
    			String ticketID = rs.getString(1);
    			
    			addTicket = con.prepareStatement("INSERT INTO SHAIRPORT.userticketbridge(email, rideID) VALUES (?, ?)");
    			addTicket.setString(1, Email);
    			addTicket.setString(2, ticketID);
    			addTicket.executeUpdate();
    		} catch(SQLException e) {
    			System.out.println(e);
    		}
    		catch(ClassNotFoundException e) {
    			System.out.println(e);    			
    		}
	}
	else {
    	request.setAttribute("error", error);
		request.getRequestDispatcher("form.html").include(request, response);
		
	}
}
	    	
    	
    	
    	
    	
    	
    	
    	
    	
    
    	/*
    	boolean termsandconditions;
    	if (request.getParameter("checkbox") == null) {
    		termsandconditions = false;
    	} else { termsandconditions = true;}
    	
    	
    	if (!termsandconditions) {
    		error += "You Must Agree to the Terms and Conditions to Register. ";
    	}
    	
    	else if (email.contentEquals("") || name.contentEquals("") 
    			|| password.contentEquals("") || confirmpassword.contentEquals("")) {
    		
    		error += "You Must Fill out all Forms to Register. ";
    		
    	} else {
    	
	    	if (!password.contentEquals(confirmpassword)){
	    		error += "Passwords Must Match During Registration. ";
	    	}
	    	
			Pattern p = Constant.emailPattern;
			Matcher m = p.matcher(email);
	    	if (!m.matches()) {
	    		error += "Invalid Email. ";    		
	    	}
	    	
	    	
	    	Pattern pname = Constant.namePattern;
	    	Matcher mname = pname.matcher(name);
	    	if (!mname.matches()) {
	    		error += "Invalid Name. ";
	    	}
    	}
    	
    
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	doGet(request,response);
    }


}