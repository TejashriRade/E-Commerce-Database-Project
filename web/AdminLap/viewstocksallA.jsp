<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
<body >
    <%@include file="product_links.jsp" %>
    <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">
        
<!--delete logic-->
<%
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
%>      
<Center><h1>View Stock</h1></center>


 <!--if edit button is pressed-->
                        <%
                           
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select model_no from laptop_accessories group by model_no");
                        while(rs.next())
                        {
                         String modelno=rs.getString(1);
                         out.println("<h1>Model No : "+modelno+"</h1>");  
                         
                         int totalqty=0,sqty,aqty;
                            out.println("<table class=\"tbstyle\" style=\"width:150%\">");                   
                            out.println("<tr><td>Purchased Qty<td>Sold Qty<td>Balance Qty</tr>");

                            Statement st1=con.createStatement();
                        ResultSet rs3=st1.executeQuery("select count(*) from stockacc where model_no='"+modelno +"'");
                        if(rs3.next())
                        {
                            totalqty=Integer.parseInt(rs3.getString(1));
                             out.println("<tr><td class=rptstyle>"+totalqty+"</td>"); 
                        }
                        Statement st3=con.createStatement();
                        
                        ResultSet rs1=st3.executeQuery("select count(*) from stockacc where model_no='"+modelno +"' and order_id != '0'");
                        if(rs1.next())
                        {
                            sqty=Integer.parseInt(rs1.getString(1));
                             out.println(" <td class=rptstyle>"+sqty+"</td>"); 
                        
                        aqty=totalqty-sqty;
                        out.println("<td class=rptstyle>"+aqty+"</td></tr>"); 
                        }
                          Statement st4=con.createStatement();
                      
                        ResultSet rs2=st4.executeQuery("select srno,order_id from stockacc where model_no='"+modelno +"'");
                        out.println("<tr><td><h4>Sr No</h4><h3><td colspan=3>");
                             
                        while(rs2.next())
                        {
                            if(rs2.getString(2).equals("0"))
                            {
                                out.println(rs2.getString(1)+","); 
                            }
                            else
                            out.println("<font color=red>"+rs2.getString(1)+"</font>"+","); 
                                
                        }
                        out.println("</tr></table>");
                        }
                            }catch(Exception e){ out.println(e);}
                           
                       
                       %>
</table>  
    </body>
</html>