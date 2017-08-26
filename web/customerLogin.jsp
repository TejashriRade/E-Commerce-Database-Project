<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

   <link rel="stylesheet" type="text/css" href="style.css"/>
    
    </head>
    <body>
        
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
                        </div>
			<div class="body">
	 <body >
         <center>           <div style="background-color: white;border-radius: 25px; width: 800px;">
        <table class="tbstyle" align="center" style="width: 400px;padding:20px;border-radius: 20px" cellpadding="10">
            <form>
            <tr align="center"><td colspan="2"><h1>Customer Login</h1></tr>
            <tr align="center"><td>Email :<td><input type="text" name="email" class="inputtxt" placeholder="email" required="email" style="text-align: center"></tr>
            <tr align="center"><td>Password :<td><input type="password" name="password" class="inputtxt" placeholder="Password" required="Password" style="text-align: center"></tr>
            <tr align="center"><td align="right"><input type="submit" value="Login" name="login" class="bttxt" style="width:100px">
                <td><input type="submit" value="Clear"  class="bttxt" style="width:100px"></tr>
            <tr><td colspan="3" align="center"> New Member <a href=Register.jsp>Register Here</a></tr>
        </form>
        </table>
             </div>
<% 
if(request.getParameter("login")!=null)
{
   String email=request.getParameter("email");
   String pwd=request.getParameter("password");
           try{
           Class.forName("oracle.jdbc.driver.OracleDriver");
           Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");

                        PreparedStatement st=con.prepareStatement("select * from customers where email=? and password=?");
                        st.setString(1,email);
                        st.setString(2,pwd);
                        
                        ResultSet rs=st.executeQuery();
                        if(rs.next())
                        {
                            int cusid=rs.getInt(1);
                            session.setAttribute("Userid",cusid);
                            //session.setAttribute("Logindate", new Date());
                            response.sendRedirect("addtocart.jsp");
                        }
           }
           catch(Exception e){out.println(e);}

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
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">video</a>
				</div>
			</div>
</body>
</html>