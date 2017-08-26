<%@page import="java.util.Date"%>
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
    <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">
        
<!--delete logic-->
<%
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
%>      
<Center><h1>Update Order Status </h1></center>


 <!--if edit button is pressed-->
 <form method="get" name="frm" onload="f1()">
<table cellpadding="5" align="center" border="0" class="tbstyle" style="width:700px">
    <tr>
        <td class="lbstyle">Order No 
        <td colspan="3"> <select name="orderid" id="plist"  class="inputtxt" onchange=pvalueselect() >
                        <option value='none'> </option>
                        <%
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from orders order by orderid");
                        while(rs.next())
                        {
                           out.println("<option value='"+rs.getString("orderid") + "'>" + rs.getString("Order_number"));
                         
                        }
                            }catch(Exception e){ out.println(e);}
                        %>
            </select></tr>
            <tr>
                <td class="lbstyle">Staus <td><input type="radio" name="sts" value="Shipped" > Shipped  <input type="radio" name="sts" value="Delivered" > Delivered <input type="radio" name="sts" value="Pending" > Pending </tr>
            <tr> <td class="lbstyle">Order Handled by
        <td colspan="3"> <select name="handledby" class="inputtxt" >
                        <option value='none'> </option>
                        <%
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from employees order by empid");
                        while(rs.next())
                        {
                           out.println("<option value='"+rs.getString("empid") + "'>" + rs.getString("first_name")+" "+rs.getString("last_name"));
                         
                        }
                            }catch(Exception e){ out.println(e);}
                        %>
            </select></tr>
            <tr><td class="lbstyle">Process Date<Td><input type="text" class="inputtxt" value="<%=new Date().toLocaleString() %>" colspan="3" name="processdate"></tr>
            <tr>
        
                <td><input type="submit" name="Add" value="Add a New" class="bttxt">
    </tr>
</table>
</form>
                   <table>
                       
                       <%
                       if(request.getParameter("Add")!=null)
                       {
                   
                           int orderid=Integer.parseInt(request.getParameter("orderid"));
                          String status=request.getParameter("sts");
                          String empid=request.getParameter("handledby");
                          String processdate=request.getParameter("processdate");
                                                            int sid=1;
                                    Statement st=con.createStatement();
                                    ResultSet rs5=st.executeQuery("Select max(status_id) from order_status");
                                    if(rs5.next())
                                    {
                                    sid=rs5.getInt(1)+1;
                                    }
  out.println(status+","+empid);
                           
                        PreparedStatement ps1=con.prepareStatement("insert into order_status values(?,?,?,?,?)");
                        ps1.setInt(1,orderid);
                        ps1.setString(2,status);
                        ps1.setString(3,empid);
                        ps1.setString(4,processdate);
                        ps1.setInt(5,sid);
                        ps1.executeUpdate();
                        PreparedStatement ps2=con.prepareStatement("update orders set status_id=? where orderid=?");
                        ps2.setInt(1,sid);
                        ps2.setInt(2,orderid);
                        ps2.executeUpdate();
                        response.sendRedirect("status.jsp");
                       }
                       %>

                        </form>
                   </table>

    </body>
</html>