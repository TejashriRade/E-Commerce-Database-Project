<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
<body >
    <div>
        <%@include file="product_links.jsp" %>
        
    </div>
    <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">
<% 
if(request.getParameter("act")!=null && request.getParameter("act").equals("d"))
{
    try
    {
        int pid=Integer.parseInt(request.getParameter("pid"));
        String pn=request.getParameter("pn");
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        PreparedStatement ps=con.prepareStatement("delete from products where productid=?");
        ps.setInt(1,pid);
        ps.executeUpdate();
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Product id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    
}
%>
<Center><h1>Add /Edit/ Delete Product Type </h1></center>
<form >

<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Product id 
        <td><input type="text" name="pid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("pid"));  %>">			
    </tr>
    <tr>
        <td class="lbstyle"> Product Name  <td>  <input type="text" class="inputtxt" name="pn" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("pn"));  %>">
            
    </tr>            

        <tr>
            <% if(request.getParameter("act")!=null && request.getParameter("act").equals("e"))
            out.println("<td> <input type=submit value=Update class=bttxt name=save>");    
            
            else
            {
            out.println(" <td> <input type=submit value=Save class=bttxt name=save>");    
            } %>
            <td><input type="reset" class="bttxt"></td>

        </tr>
</table>
</form>
<%
    if(request.getParameter("save")!=null)
    {
    try
    {
        int pid=Integer.parseInt(request.getParameter("pid"));
        String pn=request.getParameter("pn");
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("save").equals("Save"))
        {
        PreparedStatement ps=con.prepareStatement("insert into products(productid,product_name) values(?,?)");
        ps.setInt(1,pid);
        ps.setString(2,pn);
        ps.executeUpdate();
        }
        else
        if(request.getParameter("save").equals("Update"))
        {
        PreparedStatement ps=con.prepareStatement("update products set productid=?, product_name=? where productid=? or product_name=?");
        ps.setInt(1,pid);
        ps.setString(2,pn);
        ps.setInt(3,Integer.parseInt(request.getParameter("pid")));
        ps.setString(4,pn);
        
        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Product id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    }
    
 %>
<table id="eddelmenu">
    <tr class="edth"><td>Product ID <td> Product Name<td>Action</tr>
<%
    try
    {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        PreparedStatement ps=con.prepareStatement("select * from  products");
        ResultSet rs=ps.executeQuery();
        while(rs.next())
        {
        out.println("<tr class=\"edt\"><td>"+rs.getInt(1));
        out.println("<td>"+rs.getString("product_name"));
        out.println("<td><a href=producttypes.jsp?act=e&pid="+rs.getInt(1)+"&pn="+rs.getString("product_name") +">Edit</a> /<a href=producttypes.jsp?act=d&pid="+rs.getInt(1)+"&pn="+rs.getString("product_name")+"> Delete </tr>");
        
        }
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Product id already exist");}
    catch(Exception e)
    {
//        out.println("error in connection "+ e);
    }
    
 %>

    </body>
</html>