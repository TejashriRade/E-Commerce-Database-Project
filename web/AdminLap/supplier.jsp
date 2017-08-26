<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
<body >
    
    <div>
        <%@include file="supplier_links.jsp" %>
        
    </div>
    
    <div style="margin-top: 7.0%;position: absolute;margin-left: 16%">
        
<!--delete logic-->
<% 
if(request.getParameter("act")!=null && request.getParameter("act").equals("d"))
{
    try
    {
        String sid=request.getParameter("sid");
             Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        PreparedStatement ps=con.prepareStatement("delete from suppliers where supplierid=?");
        ps.setString(1,sid);
        ps.executeUpdate();
//       con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Supplier id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    
}
%>
<Center><h1>Add /Edit/ Delete Supplier Type </h1></center>
<form >

<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Supplier id 
        <td><input type="text" name="sid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("sid"));  %>">			
    </tr>
    <tr>
        <td class="lbstyle"> Company Name  <td>  <input type="text" class="inputtxt" name="cn" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("cn"));  %>">
            
    </tr>  
    
     <tr>
        <td class="lbstyle"> Contact Name  <td>  <input type="text" class="inputtxt" name="contactname" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("contactname"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Contact Title  <td>  <input type="text" class="inputtxt" name="contacttitle" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("contacttitle"));  %>">
            
    </tr>

    <tr>
        <td class="lbstyle"> Contact Number  <td>  <input type="text" class="inputtxt" name="contactno" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("contactno"));  %>">
            
    </tr>
     <tr>
        <td class="lbstyle"> Email  <td>  <input type="text" class="inputtxt" name="email" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("email"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Address1  <td>  <input type="text" class="inputtxt" name="address1" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("address1"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Address2  <td>  <input type="text" class="inputtxt" name="address2" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("address2"));  %>">
            
    </tr>
     <tr>
        <td class="lbstyle"> City  <td>  <input type="text" class="inputtxt" name="city" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("city"));  %>">
            
    </tr>
     <tr>
        <td class="lbstyle"> State  <td>  <input type="text" class="inputtxt" name="state" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("state"));  %>">
            
    </tr>
     <tr>
        <td class="lbstyle"> Zip code  <td>  <input type="text" class="inputtxt" name="postalcode" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("postalcode"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Country  <td>  <input type="text" class="inputtxt" name="country" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("country"));  %>">
            
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


<!-- IF save and update button is pressed-->
<%
    if(request.getParameter("save")!=null)
    {
    try
    {
        
        String sid=request.getParameter("sid");
        String cn=request.getParameter("cn");
        String contactname=request.getParameter("contactname");
        String contacttitle=request.getParameter("contacttitle");
        String address1=request.getParameter("address1");
        String address2=request.getParameter("address2");
        String city=request.getParameter("city");
        String state=request.getParameter("state");
        String postalcode=request.getParameter("postalcode");
        String country=request.getParameter("country");
        long phoneno=Long.parseLong(request.getParameter("contactno"));
        String email=request.getParameter("email");
        
        // stote value in database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("save").equals("Save"))
        {
        PreparedStatement ps=con.prepareStatement("insert into suppliers(supplierid,company_name,contact_name,contact_title,address1,address2,city,state,postalcode,country,phone_no,email) values(?,?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1,sid);
        ps.setString(2,cn);
        ps.setString(3,contactname);
        ps.setString(4,contacttitle);
        ps.setString(5,address1);
        ps.setString(6,address2);
        ps.setString(7, city);
        ps.setString(8,state);
        ps.setString(9,postalcode);
        ps.setString(10,country);
        ps.setLong(11,phoneno);
        ps.setString(12,email);
        ps.executeUpdate();
        }
        
        // update values in database
        else
        if(request.getParameter("save").equals("Update"))
        {
        PreparedStatement ps=con.prepareStatement("update suppliers set company_name=?,contact_name=?,contact_title=?,address1=?,address2=?,city=?,state=?,postalcode=?,country=?,phone_no=?,email=? where supplierid=?");
        
        ps.setString(1,cn);
        ps.setString(2,contactname);
        ps.setString(3,contacttitle);
        ps.setString(4,address1);
        ps.setString(5,address2);
        ps.setString(6, city);
        ps.setString(7,state);
        ps.setString(8,postalcode);
        ps.setString(9,country);
        ps.setLong(10,phoneno);
        ps.setString(11,email);
        ps.setString(12,sid);
        
        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This supplier id already exist");}
    catch(Exception e)
    {
        out.println("error in connection 11 "+ e);
    }
    }
    
 %>
 
 <!--if edit button is pressed-->
<table id="eddelmenu">
    <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  suppliers");
                        ResultSet rs1 = ps.executeQuery();
                        ResultSetMetaData rsmd=rs1.getMetaData();
                        out.println("<tr class=\"edth\">");
                        out.println("<td>Action");
                        
                        for(int i=1;i<=rsmd.getColumnCount();i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                        out.println("</tr>");
        
                        PreparedStatement ps1=con.prepareStatement("select * from  suppliers");
        ResultSet rs=ps1.executeQuery();
                            out.println("<tr class=\"edt\">");
    
                            
        while(rs.next())
        {
            out.println("<tr><td><a href=supplier.jsp?act=e&sid="+rs.getString(1)+ "&cn="+rs.getString(2)+"&contactname="+rs.getString(3)+"&contacttitle="+rs.getString(4)+"&contactno="+rs.getLong(11)+"&email="+rs.getString(12)+"&address1="+rs.getString(5)+"&address2="+rs.getString(6)+"&city="+rs.getString(7)+"&state="+rs.getString(8)+"&postalcode="+rs.getString(9)+"&country="+rs.getString(10)+">Edit</a> / <a href=supplier.jsp?act=d&sid=" + rs.getString(1) +"> Delete </a>");
        
        for(int i=1;i<=12;i++)
             out.println("<td>"+rs.getString(i));
        }
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Supplier id already exist");}
    catch(Exception e)
    {
        out.println("error in connection fdg"+ e);
    }
    
 %>

    </body>
</html>