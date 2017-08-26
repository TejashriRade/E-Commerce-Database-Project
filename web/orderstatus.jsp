<%@page import="java.sql.Statement"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

   <link rel="stylesheet" type="text/css" href="style.css"/>
    
    </head>
    <body>
        <%
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
   %>      

		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
                        </div>
			<div class="body">
	 <body >
         <center>           <div style="background-color: white;border-radius: 25px; width: 800px;">
        <table class="tbstyle" align="center" style="width: 700px;padding:20px;border-radius: 20px" cellpadding="10" border="0">
            <form>
            <tr align="center"><td colspan="3"><h1>Order Status</h1></tr>
            <tr align="center"><td>Select  your Order No :
                <td colspan="2"> <select name="orderid" id="plist"  class="inputtxt" >
                        <option value='none'> </option>
                        <%
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from orders  where customerid="+session.getAttribute("Userid"));
                        while(rs.next())
                        {
                           out.println("<option value='"+rs.getString("orderid") + "'>" + rs.getString("Order_number"));
                         
                        }
                        
                            }catch(Exception e){ out.println(e);}
                        %>
            </select>
            </tr>
            <tr align="center"><td colspan="3" align="center"><input type="submit" value="View Status"  class="bttxt" style="width:100px" name="View"></tr>
            </form>
             </div>
<% 
if(request.getParameter("View")!=null)
{
   int orderid=Integer.parseInt(request.getParameter("orderid"));
           try{

                        PreparedStatement st=con.prepareStatement("select * from order_status where orderid=? ");
                        st.setInt(1,orderid);
                       
                        
                        ResultSet rs=st.executeQuery();
                        while(rs.next())
                        {
                            if(rs.getString("status").equals("ordered"))
                                out.println("<tr><Td>Ordered Date <Td>:<td>" +rs.getString("dateofprocess")+"</tr>");    

                            if(rs.getString("status").equals("Shipped"))
                            { 
                                out.println("<tr><td>Shipping Date         <td>:<Td> " +rs.getString("dateofprocess")+"</tr>");
                                out.println("<tr><td>Shipping In Charge Id <td>:<td> " +rs.getString("handledby")+"</tr>");
                            }    

                        }
           }
           catch(Exception e){out.println(e);}

}

    %>
         </table>          
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
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">video</a>
				</div>
			</div>
</body>
</html>