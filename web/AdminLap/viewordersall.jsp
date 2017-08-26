<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
    <body >
        <%@include file="order_links.jsp" %>
        <div style="margin-top: 7.0%;position: absolute;margin-left: 20%">

            <!--delete logic-->
            <%
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
            %>      

                <!--if edit button is pressed-->
                <%
                    String ostatus="ordered";
                    if(request.getParameter("ostatus")!=null)
                    {    ostatus=request.getParameter("ostatus");
                         session.setAttribute("ostatus",ostatus);
                    }
                    if(ostatus.equals("ordered"))
                            out.println("<Center><h1>New Orders</h1></center>");
                    if(ostatus.equals("Shipped"))
                            out.println("<Center><h1>Orders in Shipping Process</h1></center>");
                    if(ostatus.equals("Delivered"))
                            out.println("<Center><h1>Confirmed & Completed Orders</h1></center>");

                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select orderid,order_number,status_id from orders where status_id in (select status_id from order_status where status = '"+ostatus+"')");
                while(rs.next())
                {
                 String orderid=rs.getString(1);
                 out.println("<h3><a href=viewproductlist.jsp?orderid="+orderid+">Order id : "+orderid);  
                 String orderno=rs.getString(2);
                 out.println("&nbsp;&nbsp;&nbsp;&nbsp;Number : "+orderno+"</a></h3>");  
                   PreparedStatement ps = con.prepareStatement("select * from  orders where orderid="+rs.getInt(1)+"and status_id="+rs.getInt("status_id"));
                ResultSet rs1 = ps.executeQuery();
                ResultSetMetaData rsmd=rs1.getMetaData();
                out.println("<table><tr class=\"edth\">");
                        
                for(int i=3;i<=rsmd.getColumnCount();i++)
                   out.println("<td >"+rsmd.getColumnName(i));
                out.println("</tr>");
        
//               out.println("<table border=0>");
                while(rs1.next())
                {
                    out.println("<tr>");
                   for(int i=3;i<=rsmd.getColumnCount();i++)
                     out.println("<td>"+rs1.getString(i));
                out.println("</tr>");
                }
                        out.println("</table>");
                }
                      
                %>
            </table>  

 </body>
</html>