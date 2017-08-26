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
<Center><h1>Add New Stock</h1></center>
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
                        ResultSet rs=st.executeQuery("select * from laptop_system_info order by model_no");
                        while(rs.next())
                        {
                           out.println("<option value='"+rs.getString(1)+"'>" + rs.getString(1 ));
                         
                        }
                            }catch(Exception e){ out.println(e);}
                        %>
            </select></tr>
            <tr>
                <td class="lbstyle">Enter Quantity <td><input type="text" name="qty" class="inputtxt"></tr><tr>
        <td><input type="submit" name="Add" value="Add a New" class="bttxt">
    </tr>
</table>
</form>
                   <table>
                       <form >
                       <%
                       if(request.getParameter("Add")!=null)
                       {
                   
                           String modelno=request.getParameter("modelno");
                          
                           
                        int q=Integer.parseInt(request.getParameter("qty"));
                        PreparedStatement ps1=con.prepareStatement("update laptop_system_info set quantity=quantity+? where model_no=?");
                        ps1.setInt(1,q);
                        ps1.setString(2,modelno);
                        ps1.executeUpdate();
                       out.println("<tr><td class=lbstyle>Enter Serial Number of this Model No :<td> <input type=text name=modelno class=inputtxt value='"+modelno+"'></tr>");
                        
                       for(int i=1;i<=q;i++)
                       {
                       out.println("<tr><td colspan=2 align=center> <input type=text name=sr[] class=inputtxt></tr>");
                       }
                       %>
                       <tr><td colspan="2" align="center"> <input type="submit" name="update" value="Update" class="bttxt"></tr>
                       <%
                       }
                       %>
                       </form>
                   </table>
                       <%
                           try{
                           if(request.getParameter("update")!=null)
                           {
                           String mn=request.getParameter("modelno");
                            
                               String [] n=new String[100];
                               n=request.getParameterValues("sr[]");
                          
                               for(int i=0;i<n.length;i++)
                            {
                                
                                PreparedStatement ps=con.prepareStatement("insert into stock values(?,?,?)");
                                ps.setString(1, mn);
                                ps.setString(2,n[i]);
                                ps.setInt(3,0);
                                ps.executeUpdate();
                           }
                           con.close();
                           response.sendRedirect("stocks.jsp");
                           
                           }
                           }catch(Exception e){ out.println("er"+e);
                               
                           }
                           %>

    </body>
</html>