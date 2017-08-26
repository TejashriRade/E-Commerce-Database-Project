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
<form >

 <!--if edit button is pressed-->
<form method="get">
<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Model No 
        <td> <select name="modelno" id="plist"  class="inputtxt" onchange=pvalueselect() >
                        <option value='none'> </option>
                        <%
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from laptop_accessories order by model_no");
                        while(rs.next())
                        {
                         out.println("<option value='"+rs.getString("model_no")+"'>" + rs.getString("model_no"));
                         
                        }
                            }catch(Exception e){ out.println(e);}
                        %>
            </select></tr>
            <tr>
        <td><input type="submit" name="View" value="View Details" class="bttxt">
    </tr>
</table>
</form>
            <table width="400"> 
                      
                       <%
                       if(request.getParameter("View")!=null)
                       {
                           int totalqty=0,sqty,aqty;
                   
                           String modelno=request.getParameter("modelno");
                        try
                        {
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select count(*) from stockacc where model_no='"+modelno +"'");
                        if(rs.next())
                        {
                            totalqty=Integer.parseInt(rs.getString(1));
                             out.println("<tr><td class=rptstyle> Total Quantity Purchased <td class=rptstyle>"+totalqty+"</td></tr>"); 
                        }
                        
                        ResultSet rs1=st.executeQuery("select count(*) from stockacc where model_no='"+modelno +"' and order_id =0");
                        if(rs1.next())
                        {
                            sqty=Integer.parseInt(rs1.getString(1));
                             out.println("<tr><td class=rptstyle> Total Quantity Sold <td class=rptstyle>"+sqty+"</td></tr>"); 
                        
                        aqty=totalqty-sqty;
                        out.println("<tr><td class=rptstyle> Total Quantity Available <td class=rptstyle>"+aqty+"</td></tr></table>"); 
                        }
                        ResultSet rs2=st.executeQuery("select srno,order_id from stockacc where model_no='"+modelno +"'");
                        out.println("<h2>Sr No</h2><h3>");
                             
                        while(rs2.next())
                        {
                            if(rs2.getString(2).equals("0"))
                            {
                                out.println(rs2.getString(1)+","); 
                            }
                            else
                            out.println("<font color=red>"+rs2.getString(1)+"</font>"+","); 
                                
                        }
                        
                        }catch(Exception e){ out.println(e);}
                           
                       }
                       %>
                                         
    </body>
</html>