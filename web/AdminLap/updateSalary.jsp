<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
        <script>
        function dvalueselect()
        {
            var p=(document.getElementById("dlist").value);
            document.getElementById("deptid").value=p;
        }
</script>
    <link rel=stylesheet href=style.css>
<body >
    
    <div>
        <%@include file="employee_links.jsp" %>
        
    </div>
    <%                      Class.forName("oracle.jdbc.driver.OracleDriver");
                       Connection  con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
  %>            

    <div style="margin-top: 5.0%;position: absolute;margin-left: 16%">
        
<!--delete logic-->
<% 
if(request.getParameter("act")!=null && request.getParameter("act").equals("d"))
{
    try
    {
        String payrollid=request.getParameter("payrollid");
        PreparedStatement ps=con.prepareStatement("delete from payroll where payrollid=?");
        ps.setString(1,payrollid);
        ps.executeUpdate();
//       con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This payroll id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    
}
%>
<Center><h1>Add /Edit/ Delete Salary </h1></center>
<form >

<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Payroll Id
        <td><input type="text" name="payid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("payid"));  %>">			
    </tr>
    
    <tr>
        <td class="lbstyle">Employee Id
        <td><input type="text" name="empid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("empid"));  %>">			
    </tr>
    
    
    <tr>
        <td class="lbstyle"> Date of Payment  <td>  <input type="text" class="inputtxt" name="paydate" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("paydate"));  %>">
            
    </tr>
    
      <tr>
        <td class="lbstyle"> Month  <td>  <input type="text" class="inputtxt" name="month" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("month"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Hours worked  <td>  <input type="text" class="inputtxt" name="hworked" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("hworked"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Gross Pay  <td>  <input type="text" class="inputtxt" name="grosspay" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("grosspay"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Deduction <td>  <input type="text" class="inputtxt" name="address1" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("deduction"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Net Pay <td>  <input type="text" class="inputtxt" name="email" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("netpay"));  %>">
            
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
        String payid=request.getParameter("payid");
        String empid=request.getParameter("empid");
        int dateofpay=Integer.parseInt(request.getParameter("dateofpay"));
        String month=request.getParameter("month");
        
        
    
         int hworked=Integer.parseInt(request.getParameter("hworked"));
         int deduction=Integer.parseInt(request.getParameter("deduction"));
        int netpay=Integer.parseInt(request.getParameter("netpay"));
         int grosspay=Integer.parseInt(request.getParameter("grosspay"));
        
        
        // stote value in database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("save").equals("Save"))
        {
        PreparedStatement ps=con.prepareStatement("insert into payroll(payrollid,empid,date_of_payment,month,hoursworked,grosspay,deduction,netpay) values(?,?,?,?,?,?,?,?)");
        ps.setString(1,payid);
        ps.setString(2,empid);
        
        ps.setInt(3,dateofpay);
        ps.setString(4,month);
        ps.setInt(5,hworked);
         ps.setInt(6,grosspay);
        ps.setInt(7,deduction);
        ps.setInt(8,netpay);
        
       
       
        ps.executeUpdate();
        }
        
        // update values in database
        else
        if(request.getParameter("save").equals("Update"))
        {
        PreparedStatement ps=con.prepareStatement("update payroll set date_of_payment=?,month=?,hoursworked=?,grosspay=?,deduction="
                + "?,netpay=?  where payrollid=?");
        
        ps.setString(1,payid);
        ps.setString(2,empid);
        
        ps.setInt(3,dateofpay);
        ps.setString(4,month);
        ps.setInt(5,hworked);
         ps.setInt(6,grosspay);
        ps.setInt(7,deduction);
        ps.setInt(8,netpay);
        
      
        
        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This payrollid id already exist");}
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
                        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  payroll");
                        ResultSet rs1 = ps.executeQuery();
                        ResultSetMetaData rsmd=rs1.getMetaData();
                        out.println("<tr class=\"edth\">");
                        out.println("<td>Action");
                        
                        for(int i=1;i<=rsmd.getColumnCount();i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                        out.println("</tr>");
        
                        PreparedStatement ps1=con.prepareStatement("select * from  payroll");
        ResultSet rs=ps1.executeQuery();
                            out.println("<tr class=\"edt\">");
    
                            
        while(rs.next())
        {
            out.println("<tr><td><a href=updateSalary.jsp?act=e&payrollid="+rs.getString(1)+ "&empid="+rs.getString(2)+"&date_of_payment="+rs.getInt(3)+"&month="+rs.getInt(4)+"&hoursworked="+rs.getInt(5)+"&grosspay="+rs.getInt(6)+"&deduction="+rs.getInt(7)+"&netpay="+rs.getInt(8)+">Edit</a> / <a href=addemployee.jsp?act=d&sid=" + rs.getString(1) +"> Delete </a>");
        
        for(int i=1;i<=16;i++)
             out.println("<td>"+rs.getString(i));
        }
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This employee  id already exist");}
    catch(Exception e)
    {
        out.println("error in connection fdg"+ e);
    }
    
 %>

    </body>
</html>