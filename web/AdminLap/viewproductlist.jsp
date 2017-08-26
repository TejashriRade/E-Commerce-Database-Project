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
    <div style="margin-top: 7.0%;position: absolute;margin-left: 13%">
        
<!--delete logic-->
<%
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
%>      

<Center><h1>Product List </h1></center>

 <!--if edit button is pressed-->
                        <%
                            int orderid=Integer.parseInt(request.getParameter("orderid"));
                            String ostatus=(String)session.getAttribute("ostatus");
                     out.println("<table>");      
     try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select order_products.*,order_status.status,order_status.handledby,order_status.dateofprocess from order_products,order_status where order_products.orderid=order_status.orderid and order_products.orderid ="+orderid+" and order_status.status='"+ostatus+"'");
                        ResultSetMetaData rsmd=rs.getMetaData();
                        out.println("<tr class=\"edth\">");
                        
                        
                        for(int i=1;i<=rsmd.getColumnCount();i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                        out.println("</tr>");
                         out.println("<tr class=\"edt\">");
                           
                        while(rs.next())
                        {
                            out.println("<tr>");
//                            out.println("<tr><td><a href=supplier.jsp?act=e&sid="+rs.getString(1)+ "&cn="+rs.getString(2)+"&contactname="+rs.getString(3)+"&contacttitle="+rs.getString(4)+"&contactno="+rs.getLong(11)+"&email="+rs.getString(12)+"&address1="+rs.getString(5)+"&address2="+rs.getString(6)+"&city="+rs.getString(7)+"&state="+rs.getString(8)+"&postalcode="+rs.getString(9)+"&country="+rs.getString(10)+">Edit</a> / <a href=supplier.jsp?act=d&sid=" + rs.getString(1) +"> Delete </a>");
                           for(int i=1;i<=rsmd.getColumnCount();i++)
                             out.println("<td>"+rs.getString(i));
                        out.println("<tr>");
                        }
                        }
                      
                           catch(Exception e){out.println(e);}
                       %>
</table>  
    </body>
</html>