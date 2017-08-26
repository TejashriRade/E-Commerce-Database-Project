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
				                <% int sn,en;
                                                    if(request.getParameter("sn")!=null && request.getParameter("en")!=null)
                                                    {       sn=Integer.parseInt(request.getParameter("sn"));
                                                            en=Integer.parseInt(request.getParameter("en"));
                                                    }
                                                    else
                                                    {
                                                           sn=1;
                                                           en=3;
                                                    
                                                    }
                                                        try
                                                        {
                                                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                                                                PreparedStatement ps;
                                                                    // PreparedStatement ps = con.prepareStatement("select * from (select a.*,rownum rnum from(select laptop_system_info.*,brand.*,products.* from  laptop_System_info,brand,products where laptop_system_info.productid=products.productid and brand.brandid = laptop_system_info.brandid order by model_no) a where rownum<=4 ) where rnum >= 2 ");
                                                             ps = con.prepareStatement("select * from (select a.*,rownum rnum from(select laptop_accessories.*,brand.brand_name,brand.brandimage from  laptop_accessories,brand where brand.brandid = laptop_accessories.brandid order by model_no) a where rownum<=?) where rnum>=?");
                                                              ps.setInt(1,en);
                                                              ps.setInt(2,sn);
                                                            
                                                              ResultSet rs1 = ps.executeQuery();
                                                                while(rs1.next())
                                                                {
                                                out.println("<li><a href=#><div class=featured>");
                                    
                                                                    /* ResultSetMetaData rsmd=rs1.getMetaData();
                        out.println("<tr class=\"edth\">");
                        out.println("<td>Action");
                        
                        for(int i=1;i<=rsmd.getColumnCount();i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                        out.println("</tr>");*/
                                                        String in="images/"+rs1.getString("images");
                                                        String bimg="images/"+rs1.getString("brandimage");

                                                        String mn=rs1.getString("model_no");
                                                        String pr=rs1.getString("price");
                                                
							out.println("<a href=views.jsp?modelno="+mn.replace(" ","%20")+"&ptype=accessories>");
                                                %>
                                                <img src="<%=in%>" height="200" width="250" alt=""/>
								</a>
                                                                <Center>Price : <%=pr%></center>
                        </div>
						<div>
                                                        <h3 style="float:right;color: brown"><%=rs1.getString("item_name")%></h3>
							<h3><%=mn%></h3>
                                                        <img src="<%=bimg%>" style="float: right;width:80px;height:80px">
                                                        <p> Brand            :<%=rs1.getString("brand_name")%> <br>
                                                            Item Name : <%=rs1.getString("item_name")%><br>
                                                            warranty : <%=rs1.getString("warrenty")%> <br>
                                                             <% if(rs1.getInt("quantity")>1) out.println("Available : Yes"); else out.println("out of Stock");%><br>
                                                        </P>
                                                            
                                                            
                                                            
						</div>
					</li>

                                                <% }%>
                                        <ul class="paging">
				   
                                        <% 
                                            Statement st2=con.createStatement();
                                            ResultSet rs2;
                                            rs2=st2.executeQuery("select count(*) from laptop_accessories ");
                                                
                                            if(rs2.next())
                                            {
                                            int total=rs2.getInt(1);
                                            int pages=total/3;
                                            int k=1;
                                            for(int i=1;i<=pages;i++)
                                            {
                                                out.println("<li><a href=accessories.jsp?sn="+k+"&en="+(2+k)+">"+i+"</a></li>");
                                                k=k+3;
                                            }
                                            }
                                            }
                                            
                                                        catch(Exception e){ out.println(e);}
                                                                
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