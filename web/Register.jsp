<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>Customer Registration Form</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" type="text/css" href="cssc/default.css"/>
    <link rel="stylesheet" type="text/css" href="style.css"/>
    
    </head>
    <body>
        
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
                        </div>
			<div class="body">
		
        <form action="" class="register">
            <h1>Registration</h1>
            <fieldset class="row1">
                <legend>Account Details
                </legend>
                <p>
                    <label>Email *
                    </label>
                    <input type="text" name="email"/>
                    <label>Repeat email *
                    </label>
                    <input type="text"/>
                </p>
                <p>
                    <label>Password*
                    </label>
                    <input type="password" name="password"/>
                    <label>Confirm Password*
                    </label>
                    <input type="password" name="confirm password"/>
                    <label class="obinfo">* obligatory fields
                    </label>
                </p>
            </fieldset>
            <fieldset class="row2">
                <legend>Personal Details
                </legend>
                <p>
                    <label>First Name *
                    </label>
                    <input type="text" name="first_name" class="long"/>
                </p>
                
                <p>
                    <label>Last Name *
                    </label>
                    <input type="text"  name="last_name" class="long"/>
                </p>
                
                <p>
                    <label>Contact No *
                    </label>
                    <input type="text" name="contact_no" maxlength="10"/>
                </p>
                <p>
                    <label >Address Line 1
                    </label>
                    <input type="text" name="address1" class="long"/>
                </p>
                
                <p>
                    <label >Address Line 2
                    </label>
                    <input type="text" name="address2" class="long"/>
                </p>
                
                <p>
                    <label>City *
                    </label>
                    <input type="text" name="city" class="long"/>
                </p>
                
                <p>
                    <label>State *
                    </label>
                    <input type="text" name="state" class="long"/>
                </p>
                
                <p>
                    <label>Zip Code *      <!-- postal code-->
                    </label>
                    <input type="text" name="postalcode" class="long"/>
                </p>
                
                
                <p>
                    <label>Country *
                    </label>
                            <select name="country">
                        <option value="United States">United States</option>
                        <option value="India"> India</option>
                        <option value="China"> China</option>
                    </select>
                </p>
               
            </fieldset>
           <br>
            <fieldset class="row3">   
                <div class="infobox"><h4>Helpful Information</h4>
                    <p>Enter your personal information correctly. Your provided contact information will be used in case of delivery issues</p>
                </div>
            </fieldset>
                   <br><br>
            
                           <div><input type="submit" name="Register" class="button" value="Register"></div>
        </form>
                            <%
    if(request.getParameter("Register")!=null)
    {
    try
    {
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        String first_name=request.getParameter("first_name");
        String last_name=request.getParameter("last_name");
        String address1=request.getParameter("address1");
        String address2=request.getParameter("address2");
        String city=request.getParameter("city");
        String state=request.getParameter("state");
        String country=request.getParameter("country");
        Long l=Long.parseLong(request.getParameter("contact_no"));
        String postalcode=request.getParameter("postalcode");
        
      
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("Register").equals("Register"))
        {
            int cid=1;
            Statement st=con.createStatement();
            ResultSet rs5=st.executeQuery("Select max(customerid) from customers");
            if(rs5.next())
            {
            cid=rs5.getInt(1)+1;
            }
        PreparedStatement ps=con.prepareStatement("insert into customers  values(?,?,?,?,?,?,?,?,?,?,?,?)"); //,?,?,?,?,?,?,?)");
        ps.setInt(1,cid);
        ps.setString(2,first_name);
        ps.setString(3,last_name);
        ps.setString(4,address1);
        ps.setString(5,address2);
        ps.setString(6,city);
        ps.setString(7,state);
        ps.setString(8,country);
        ps.setLong(9,l);
        ps.setString(10,email);
       
        ps.setString(11,password);
        ps.setString(12,postalcode);

        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
        response.sendRedirect("customerLogin.jsp");        

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Product id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    }
    
 %>
                            
        		</div>
			<div class="footer">
				<ul>
					
					<li><a href="index.jsp">Home</a></li>
					<li><a href="about.jsp">About</a></li>
					<li><a href="contactus.jsp">Contact Us</a></li>
				</ul>
				<p>&#169; Copyright &#169; 2016. The little Laptop shop all rights reserved</p>
				<div class="connect">
					<a href="http://facebook.com/freewebsitetemplates" id="facebook">facebook</a>
					<a href="http://twitter.com/fwtemplates" id="twitter">twitter</a>
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">vimeo</a>
				</div>
			</div>
	                    
                            
    </body>
</html>





