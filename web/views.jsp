<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title></title>
		<link rel="stylesheet" href="css/style.css" type="text/css" />
		<!--[if IE 7]>
			<link rel="stylesheet" href="css/ie7.css" type="text/css" />
		<![endif]-->
	</head>
	<body>
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
			</div>
<!--                        select * from (select a.*,rownum rnum from(select * from stock order by srno) a where rownum<=10) where rnum>=4;-->
			<div class="body">
				<ul>
				                <% String mn="",ptype="";
                                                    if(request.getParameter("modelno")!=null)
                                                    {       mn=(request.getParameter("modelno"));
                                                    }
                                                    if(request.getParameter("ptype")!=null)
                                                    {       ptype=(request.getParameter("ptype"));
                                                    }
                                                    if(ptype.equals("laptop"))
                                                    {
                                                        try
                                                        {
                                                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                                                                PreparedStatement ps;
                                                            ps = con.prepareStatement("select laptop_system_info.*,brand.brand_name,brand.brandimage from  laptop_System_info,brand where brand.brandid = laptop_system_info.brandid and model_no=? order by model_no ");                                                        
                                                            ps.setString(1,mn);
                                                            ResultSet rs1 = ps.executeQuery();
                                                                while(rs1.next())
                                                                {
                                                out.println("<li><div>");
                                    
                                                        String in="images/"+rs1.getString("images");
                                                        String bimg="images/"+rs1.getString("brandimage");

                                                        String pr=rs1.getString("price");
                                                
							//out.println("<a href=views.jsp?modelno="+mn.replace(" ","%20")+">");
                                                %>
							     </div>
						
                                                        <h3 style="float:right;color: brown"><%=rs1.getString("category")%></h3>
                                                        <h3 style="text-align: center"><%=mn%></h3>
                                                        <img src="<%=bimg%>" style="float: right;width:80px;height:80px">
                                                        <p><form action='addtocart.jsp'><Table border="0" cellspacing="10" style="float:right">
                                                            <tr><td rowspan="14"><img src="<%=in%>" height="500" width="500" alt="" style="float:left"/>

                                                            <tr><td> Model No <td>:<td><input type="text" name="modelno" value="<%=mn%>" readonly style='text-decoration: none;background-color: gainsboro'>
                                                            <tr><td> Product Id <td>:<td><input type="text" name="productid" value="<%=rs1.getInt("productid")%>" readonly style='text-decoration: none;background-color: gainsboro'>

                                                            <tr><Td> Brand           <td> :<td><%=rs1.getString("brand_name")%> </tr>
                                                            <tr><td>Operating System <td>:<td> <%=rs1.getString("operating_system")%></tr>
                                                            <Tr><td>Processor <td>:<td> <%=rs1.getString("processor")%></tr>
                                                            <tr><td>RAM <td>:<td> <%=rs1.getString("ram")%></tr>
                                                            <tr><td>warranty <td>:<td> <%=rs1.getString("warrenty")%> Years</tr>
                                                            <tr><Td>Screen Size <td>:<td> <%=rs1.getString("screensize")%> inch</tr>
                                                            <tr><td>Other Description<td>:<td> <%=rs1.getString("other_description")%> </tr>
                                                            <tr><th>Price<td>:<th> $<%=pr%> </tr>
                                                            
                                                            <% if(rs1.getInt("quantity")>=1) out.println("<tr><Td>Available <td>:<td> Yes"); else out.println("out of Stock");%><br>
                                                            <tr> <td>Enter Quantity <br>(if > 1)<td>:<td><input type="qty" name="qty" value='1' alt="enter quantity if more than 1"></tr>
                                                            <tr><td colspan="3" align=Center> <% if(rs1.getInt("quantity")>=1){ %> <input type=submit style="background-image    : url(images/addtocart.gif);width:150px;height: 40px;background-repeat: no-repeat;background-position: center center" value=''> <% } else {out.println("Out Of Stock"); } %> </tr>
                                                        </table>
                                                        </form>
                                                            </P>
                                                            
                                                            
                                                            
						</div>
					</li>

                                                <% }
                                                    }
                                            
                                                        catch(Exception e){ out.println(e);}
                                                    }
                                                     else
                                                      {
                                                        try
                                                        {
                                                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                                                                PreparedStatement ps;
                                                            ps = con.prepareStatement("select laptop_accessories.*,brand.brand_name,brand.brandimage from  laptop_accessories,brand where brand.brandid = laptop_accessories.brandid and model_no=? order by model_no");                                                        
                                                            ps.setString(1,mn);
                                                            ResultSet rs1 = ps.executeQuery();
                                                                while(rs1.next())
                                                                {
                                                out.println("<li><div>");
                                    
                                                        String in="images/"+rs1.getString("images");
                                                        String bimg="images/"+rs1.getString("brandimage");

                                                        String pr=rs1.getString("price");
                                                
							//out.println("<a href=views.jsp?modelno="+mn.replace(" ","%20")+">");
                                                %>
							     </div>
						
                                                        <h3 style="float:right;color: brown"><%=rs1.getString("item_name")%></h3>q
                                                        <h3 style="text-align: center"><%=mn%></h3>
                                                        <img src="<%=bimg%>" style="float: right;width:80px;height:80px">
                                                        <p><form action='addtocart.jsp'><Table border="0" cellspacing="10" style="float:right">
                                                            <tr><td rowspan="13"><img src="<%=in%>" height="500" width="500" alt="" style="float:left"/>

                                                            <tr><td> Model No <td>:<td><input type="text" name="modelno" value="<%=mn%>" readonly style='text-decoration: none;background-color: gainsboro'>
                                                            <tr><td> Product Id <td>:<td><input type="text" name="productid" value="<%=rs1.getInt("productid")%>" readonly style='text-decoration: none;background-color: gainsboro'>

                                                            <tr><Td> Brand           <td> :<td><%=rs1.getString("brand_name")%> </tr>
                                                            <tr><td>Other Description<td>:<td> <%=rs1.getString("other_description")%> </tr>
                                                            <tr><th>Price<td>:<th> $<%=pr%> </tr>
                                                            
                                                            <% if(rs1.getInt("quantity")>=1) out.println("<tr><Td>Available <td>:<td> Yes"); else out.println("out of Stock");%><br>
                                                            <tr> <td>Enter Quantity <br>(if > 1)<td>:<td><input type="qty" name="qty" value='1' alt="enter quantity if more than 1"></tr>
                                                            <tr><td colspan="3" align=Center> <% if(rs1.getInt("quantity")>=1){ %> <input type=submit style="background-image    : url(images/addtocart.gif);width:150px;height: 40px;background-repeat: no-repeat;background-position: center center" value=''> <% } else {out.println("Out Of Stock"); } %> </tr>
                                                        </table>
                                                        </form>
                                                            </P>
                                                            
                                                            
                                                            
						</div>
					</li>

                                                <% }
                                                    }
                                            
                                                        catch(Exception e){ out.println(e);}

                                                      }
                                            %>
				</ul>
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
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">youtube</a>
				</div>
			</div>
		</div>
	</body>
</html>  