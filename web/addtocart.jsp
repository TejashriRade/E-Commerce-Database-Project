<%@page import="java.util.ArrayList"%>
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
				                <%
                                                    ArrayList<String> modelcartv;
                                                    
                                                  
                                                    if(session.getAttribute("Userid")==null)
                                                    {   
                                                         if(request.getParameter("modelno")!=null)
                                                         {
                                                             session.setAttribute("modelno",request.getParameter("modelno"));
                                                             session.setAttribute("productid",request.getParameter("productid"));
                                                             
                                                             if(request.getParameter("qty")!=null)
                                                             session.setAttribute("qty",request.getParameter("qty"));
                                                             else
                                                             session.setAttribute("qty","1");
                                                                 
                                                         }
                                                         response.sendRedirect("customerLogin.jsp");
                                                    }
                                                    else
                                                        
                                                    {
                                                    String modelno=null;
                                                    String qty="1";
                                                    String productid=null;
                                                    if(request.getParameter("modelno")!=null)
                                                        {    modelno=request.getParameter("modelno");
                                                             qty=request.getParameter("qty");
                                                             productid=request.getParameter("productid");
                                                             response.sendRedirect("addtocart.jsp");
                                                        }
                                                    else
                                                    {
                                                         modelno=(String)session.getAttribute("modelno");
                                                         qty=(String)session.getAttribute("qty");
                                                         productid=(String)session.getAttribute("productid");

                                                         session.setAttribute("modelno",null);
                                                         session.setAttribute("qty",null);
                                                         session.setAttribute("productid",null);

                                                    } 
                                                    
                                                        
                                                    if(session.getAttribute("cart")!=null)
                                                        modelcartv=(ArrayList<String>)session.getAttribute("cart");
                                                    else
                                                        modelcartv=new ArrayList<String>(); 
                                                 
                                                    if(modelno!=null)
                                                      modelcartv.add(modelno+","+qty+","+productid);
                                                    
                                                    session.setAttribute("cart", modelcartv);
                                                    
                                                    
                                                   
                                                 
                                                    if(modelcartv.size()==0)
                                                        out.println("No Items Selected");
                                                    else
                                                    {
                                                %>
			
                        <div style="background-color: white;width:800px;border-radius: 20px;margin-left: 70px;padding:20px">
                            <form>
                            <table width=700>
                                <tr> <td> Model No <Td> Brand <td> Product Type <td> Rate per unit <td> Qty <td> Amount <Td>select to remove </td></tr>
                                <tr>
                                   <% 
                                        double Totalamt=0,total;
                                        for(int i=0;i<modelcartv.size();i++)
                                        {
                                           String data=modelcartv.get(i);
                                           String mn=data.substring(0,data.indexOf(","));
                                           int pos=data.indexOf(",");
                                          String q=data.substring(pos+1,data.indexOf(",",pos+1));
                                           
                                          String pt=data.substring(data.lastIndexOf(",")+1, data.length());
                                            
                                            try
                                                        {
                                                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                                                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                                                                PreparedStatement ps;
                                                                if(pt.equals("2"))
                                                                {
                                                            ps = con.prepareStatement("select laptop_system_info.*,products.product_name,brand.brand_name from  laptop_System_info,brand,products where (brand.brandid = laptop_system_info.brandid and products.productid = laptop_system_info.productid )and model_no=? order by model_no ");                                                        
                                                            ps.setString(1,mn);
                                                            ResultSet rs1 = ps.executeQuery();
                                                                if(rs1.next())
                                                                 {
                                                                      total=rs1.getDouble("price")*Integer.parseInt(q);
                                                                 out.println("<tr><td>"+mn+"<td>"+rs1.getString("brand_name")+"<td>"+rs1.getString("product_name")+"<td>"+rs1.getString("price")+"<td>"+q+"<td>"+total+"<Td><input type=checkbox name=vj value="+ i +" > </tr>");
                                                                 Totalamt+=total;
                                         
                                                                 }
                                                                }
                                                                else
                                                                {
                                                            ps = con.prepareStatement("select laptop_accessories.*,products.product_name,brand.brand_name from  laptop_accessories,brand,products where (brand.brandid = laptop_accessories.brandid and products.productid = laptop_accessories.productid )and model_no=? order by model_no ");                                                        
                                                            ps.setString(1,mn);
                                                            ResultSet rs1 = ps.executeQuery();
                                                                if(rs1.next())
                                                                 {
                                                                      total=rs1.getDouble("price")*Integer.parseInt(q);
                                                                 out.println("<tr><td>"+mn+"<td>"+rs1.getString("brand_name")+"<td>"+rs1.getString("product_name")+"<td>"+rs1.getString("price")+"<td>"+q+"<td>"+total+"<Td><input type=checkbox name=vj value="+ i +" > </tr>");
                                                                 Totalamt+=total;
                                         
                                                                 }
                                                                    
                                                                }
                                                                               }
                                            catch(Exception e) { }
                                        }
                                                out.println("<tr><th colspan=5 > Payment to be done <td>"+Totalamt+"<td><input type=submit value=\"Remove\" name=\"remove\"></tr>");

                                                %>   
                                </tr>
                                <tr><td> <input type=submit value="Continue Shopping" name="cnt"> <td><input type="submit" value="Proceed to Check Out" name="checkout"></tr>
                            </table>
                            </form>
                                <% 
                                    }//end else

                                  if(request.getParameter("remove")!=null)
                                    {
                                 modelcartv=(ArrayList<String>)session.getAttribute("cart");
                                        for(int i=0;i<modelcartv.size();i++)
                                        {
                                           String data=modelcartv.get(i);
                                           String mn=data.substring(0,data.indexOf(","));
                                         //  String q=data.substring(data.indexOf(",") +1, data.length());
                                           String q=data.substring(data.indexOf(",") +1, data.lastIndexOf(","));
                                           String pt=data.substring(data.lastIndexOf(",")+1, data.length()-1);

                                            out.println(data);
                                        }
                                     String v[]=request.getParameterValues("vj");
                                      
                                      for(int i=0;i<v.length;i++)
                                      {
//                                          out.println(v[i]);
                                       modelcartv.remove(i);
                                      }
                                         //session.setAttribute("cart", modelcartv);
                                      response.sendRedirect("addtocart.jsp");
                                    }
                                    if(request.getParameter("cnt")!=null)
                                    {
                                    response.sendRedirect("index.jsp");
                                           
                                    }
                                    if(request.getParameter("checkout")!=null)
                                    {
                                        response.sendRedirect("customerOrder.jsp");
                                    }}
                                    %>
                        </div>
			</div>
                                                <div class="footer">
				<ul>
					
					<li><a href="index.jsp">Home</a></li>
					<li><a href="about.jsp">About</a></li>
					<li><a href="contactus.jsp">Contact Us</a></li>
				</ul>
				<p>&#169; Copyright &#169; 2016. The little Laptop shops all rights reserved</p>
				<div class="connect">
					<a href="http://facebook.com/freewebsitetemplates" id="facebook">facebook</a>
					<a href="http://twitter.com/fwtemplates" id="twitter">twitter</a>
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">youtube</a>
				</div>
			</div>
		</div>
	</body>
</html>  