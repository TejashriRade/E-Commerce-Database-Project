<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
<body >
    <div>
       
        <%@include file="menu.jsp" %>
    </div>
    <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">
<% 
if(request.getParameter("act")!=null && request.getParameter("act").equals("d"))
{
    try
    {
        String deptid=request.getParameter("deptid");
        String deptn=request.getParameter("deptn");
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        PreparedStatement ps=con.prepareStatement("delete from departments where deptid=?");
        ps.setString(1,deptid);
        ps.executeUpdate();
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This dept id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    
}
%>
<Center><h1>Add /Edit/ Delete Department </h1></center>
<form >

<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Department id 
        <td><input type="text" name="deptid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("deptid"));  %>">			
    </tr>
    <tr><td class="lbstyle"> Department Name  <td>  <input type="text" class="inputtxt" name="deptn" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("deptn"));%>
        " >
            
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
       String deptid=request.getParameter("deptid");
        String deptn=request.getParameter("deptn");
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("save").equals("Save"))
        {
        PreparedStatement ps=con.prepareStatement("insert into departments(deptid,dept_name) values(?,?)");
        ps.setString(1,deptid);
        ps.setString(2,deptn);
        ps.executeUpdate();
        }
        else
        if(request.getParameter("save").equals("Update"))
        {
        PreparedStatement ps=con.prepareStatement("update departments set deptid=?, dept_name=? where deptid=? or dept_name=?");
        ps.setString(1,deptid);
        ps.setString(2,deptn);
        ps.setString(3,deptid);
        ps.setString(4,deptn);
        
        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Department id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    }
    
 %>
<table id="eddelmenu">
    <tr class="edth"><td>Department ID <td> Department Name<td>Action</tr>
<%
    try
    {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        PreparedStatement ps=con.prepareStatement("select * from  departments");
        ResultSet rs=ps.executeQuery();
        while(rs.next())
        {
        out.println("<tr class=\"edt\"><td>"+rs.getString(1));
        out.println("<td>"+rs.getString("dept_name"));
        String s=rs.getString("dept_name").replace(" ","%20");
        
        out.println("<td><a href=departments.jsp?act=e&deptid="+rs.getString("deptid")+"&deptn="+s+">Edit</a> /<a href=departments.jsp?act=d&deptid="+rs.getString("deptid")+"&deptn="+rs.getString("dept_name")+"> Delete </tr>");
        
        }
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Department id already exist");}
    catch(Exception e)
    {
//        out.println("error in connection "+ e);
    }
    
 %>
</table>
    </body>
</html>