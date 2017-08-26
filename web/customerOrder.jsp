<%@page import="java.util.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>Order Details</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" type="text/css" href="cssc/default.css"/>
    <link rel="stylesheet" type="text/css" href="style.css"/>
    <script>
    function setv()
    {
        if(document.getElementById("chk").checked==true)
        {
        document.f.saddress1.value=document.f.address1.value;
        document.f.saddress2.value=document.f.address1.value;
        document.f.scity.value=document.f.city.value;
        document.f.sstate.value=document.f.state.value;
        document.f.spostalcode.value=document.f.postalcode.value;
                document.getElementById("scountry").value=document.f.country.value;
            }
else
{
            document.f.saddress1.value="";
        document.f.saddress2.value="";
        document.f.scity.value="";
        document.f.sstate.value="";
        document.f.spostalcode.value="";
                document.getElementById("scountry").value="";

}
    }
    </script>
    </head>
    <body>
        
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
                        </div>
			<div class="body">
						                <%
                                                    ArrayList<String> modelcartv=null;
                                                        int oid=1;
                                                    String on="",odate="";
                                                  Connection con;
                                                    if(session.getAttribute("Userid")==null)
                                                    {   
                                                         response.sendRedirect("logout.jsp");
                                                    }
                                                    else
                                                    {
                                                    if(session.getAttribute("cart")!=null)
                                                        modelcartv=(ArrayList<String>)session.getAttribute("cart");
                                                    else
                                                        out.println("No Items in Cart..");
                                                    try
                                                    {
                                                        Class.forName("oracle.jdbc.driver.OracleDriver");
                                                         con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
 
            Statement st=con.createStatement();
            ResultSet rs5=st.executeQuery("Select max(orderid) from orders");
            if(rs5.next())
            {
            oid=rs5.getInt(1)+1;
            
            }
            on =  oid+"-"+session.getAttribute("Userid") + "-"+ new Date().getDate()+"-"+(new Date().getMonth()+1)+"-"+new Date().getYear()+"-"+new Date().getHours()+":"+new Date().getMinutes();
            out.println(on);
            odate=new Date().getDate()+"/"+(new Date().getMonth()+1)+"/"+new Date().getYear()+"-"+new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds();

                    
                                                    }
                                                    catch(Exception e){}
                                                    }
                                                %>

        <form action="checkout.jsp" class="register" name="f" >
            <h1>Order Details</h1>
            <fieldset class="row1">
                <legend>Order 
                </legend>
                <p>
                    <label>Order Id
                    </label>
                    <input type="text" name="orderno" value="<%=on%>"/>
                    <label>Order Date & Time
                    </label>
                    <input type="text" name="odate" value="<%=odate%>"/>
                </p>
                <%
                    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
 
            Statement st1=con.createStatement();
            int custid=(Integer)session.getAttribute("Userid");
            ResultSet rs1=st1.executeQuery("Select * from customers where customerid="+custid);
            if(rs1.next())
            {
           
            
                
                %>                
                
                 <p>
                    <label>First Name *
                    </label>
                    <input type="text" name="first_name" class="long" value="<%=rs1.getString("first_name")%>"/>
                </p>
                
                <p>
                    <label>Last Name *
                    </label>
                    <input type="text"  name="last_name" class="long" value="<%=rs1.getString("last_name")%>"/>
                </p>
                         
                
                
                <input type="checkbox" id="chk" onclick="setv()"/>
                    * Shipping address is same as customer Billing address <a href="#"></a>
                
               
            </fieldset>
            <fieldset class="row2">
                <legend>Billing Details
                </legend>
               
                
                
                <p>
                    <label >Billing Address Line 1
                    </label>
                    <input type="text" name="address1" class="long" value="<%=rs1.getString("address1")%>"/>
                </p>
                
                <p>
                    <label >Billing Address Line 2
                    </label>
                    <input type="text" name="address2" class="long" value="<%=rs1.getString("address2")%>"/>
                </p>
                
                <p>
                    <label>Billing City *
                    </label>
                    <input type="text" name="city" class="long" value="<%=rs1.getString("city")%>"/>
                </p>
                
                <p>
                    <label>Billing State *
                    </label>
                    <input type="text" name="state" class="long" value="<%=rs1.getString("state")%>"/>
                </p>
                
                <p>
                    <label>Billing Zip Code *      <!-- postal code-->
                    </label>
                    <input type="text" name="postalcode" class="long" value="<%=rs1.getString("postalcode")%>"/>
                </p>
                
                
                <p>
                    <label>Billing Country *

                    </label>
                    <input type="text" name="country" class="long" value="<%=rs1.getString("c_country")%>"/>

                </p>
               
            </fieldset>
            
            <% } %>
            
             <fieldset class="row3">
                <legend>Shipping Address
                </legend>
                 
                <p>
                    <label >Shipping Address Line 1
                    </label>
                    <input type="text" name="saddress1" class="long"/>
                </p>
                
                <p>
                    <label >Shipping Address Line 2
                    </label>
                    <input type="text" name="saddress2" class="long"/>
                </p>
                
                <p>
                    <label>Shipping City *
                    </label>
                    <input type="text" name="scity" class="long"/>
                </p>
                
                <p>
                    <label>Shipping State *
                    </label>
                    <input type="text" name="sstate" class="long"/>
                </p>
                
                <p>
                    <label>Shipping Zip Code *      <!-- postal code-->
                    </label>
                    <input type="text" name="spostalcode" class="long"/>
                </p>
                
                
                <p>
                    <label>Shipping Country *
                    </label>
                            <select name="scountry" id="scountry">
                        <option value="United States">United States</option>
                        <option value="India"> India</option>
                        <option value="China"> China</option>
                    </select>
                </p>
            </fieldset>
            
            
            <fieldset class="row4">
                <div><input type="submit" class="button" value="Check Out"></div>
                            <div><input type="reset" class="button" value="Reset"></div>
            </fieldset>
            
           
                   <br>
            
                           
        </form>
                            
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





