<%@page import="java.sql.Date"%>
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
            document.getElementById("dn").value=p;
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

    <div style="margin-top: 5.0%;position: absolute;margin-left: 10%">
        
<!--delete logic-->
<% 
if(request.getParameter("act")!=null && request.getParameter("act").equals("d"))
{
    try
    {
        String empid=request.getParameter("empid");
        PreparedStatement ps=con.prepareStatement("delete from employees where empid=?");
        ps.setString(1,empid);
        ps.executeUpdate();
//       con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This Employee id already exist");}
    catch(Exception e)
    {
        out.println("error in connection "+ e);
    }
    
}
%>
<Center><h1>Add /Edit/ Delete Employee </h1></center>
<form >

<table cellpadding="5" align="center" border="0" class="tbstyle">
    <tr>
        <td class="lbstyle">Employee Id
        <td><input type="text" name="empid" class="inputtxt" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("empid"));  %>">			
    </tr>
    
     <tr>
        <td class="lbstyle">Department Name
             <td> <select name="deptname" id="dlist"  class="inputtxt" onchange=dvalueselect()>
                        <option value='none'> </option>
                        <%
                            try{
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from departments order by deptid");
                        while(rs.next())
                        {
                         out.println("<option value='"+rs.getString(1)+"'>" + rs.getString(2));
                         
                        }
                            }catch(Exception e){}
                        %>
                   </select>
                 
	</tr>
        
    <tr>
        <td class="lbstyle"> Department Id  <td>  <input type="text" class="inputtxt" name="deptn" id="dn" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("deptid"));  %>">
            
    </tr>            


    <tr>
        <td class="lbstyle"> Job Title  <td>  <input type="text" class="inputtxt" name="jobtitle" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("jobtitle"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> First Name  <td>  <input type="text" class="inputtxt" name="first_name" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("first_name"));  %>">
            
    </tr>  
    
     <tr>
        <td class="lbstyle"> Last Name  <td>  <input type="text" class="inputtxt" name="last_name" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("last_name"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Birth Date  <td>  <input type="text" class="inputtxt" name="birthdate" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("birthdate"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Hire Date  <td>  <input type="text" class="inputtxt" name="hiredate" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("hiredate"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Home Contact Number  <td>  <input type="text" class="inputtxt" name="hcontactno" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("hcontactno"));  %>">
            
    </tr>
    
    <tr>
        <td class="lbstyle"> Office Contact Number  <td>  <input type="text" class="inputtxt" name="ocontactno" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("ocontactno"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Email  <td>  <input type="text" class="inputtxt" name="email" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("email"));  %>">
            
    </tr>
    
     <tr>
        <td class="lbstyle"> Address <td>  <input type="text" class="inputtxt" name="address1" value="<% if(request.getParameter("act")!=null && request.getParameter("act").equals("e")) out.println(request.getParameter("address"));  %>">
            
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
        String empid=request.getParameter("empid");
        String deptid=request.getParameter("deptn");
        String jobtitle=request.getParameter("jobtitle");
        String firstname=request.getParameter("first_name");
        String lastname=request.getParameter("last_name");
        String birthdate=request.getParameter("birthdate");
        String hiredate=request.getParameter("hiredate");
         int hcontactno=Integer.parseInt(request.getParameter("hcontactno"));
         int ocontactno=Integer.parseInt(request.getParameter("ocontactno"));
        String email=request.getParameter("email");
        String address=request.getParameter("address1");
        String city=request.getParameter("city");
        String state=request.getParameter("state");
        String postalcode=request.getParameter("postalcode");
        String country=request.getParameter("country");
        
        
        
        // stote value in database
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","SYSTEM","Password");
        if(request.getParameter("save").equals("Save"))
        {
        PreparedStatement ps=con.prepareStatement("insert into employees(empid,deptid,jobtitle,first_name,last_name,birthdate,hiredate,home_contact_no,office_contact_no,email,address,city,state,postalcode,country) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
        ps.setString(1,empid);
        ps.setString(2,deptid);
        ps.setString(3,jobtitle);
        ps.setString(4,firstname);
        ps.setString(5,lastname);
        ps.setString(6,(birthdate));
        ps.setString(7,(hiredate));
        ps.setInt(8,hcontactno);
        ps.setInt(9,ocontactno);
        ps.setString(10,email);
        ps.setString(11,address);
        ps.setString(12, city);
        ps.setString(13,state);
        ps.setString(14,postalcode);
        ps.setString(15,country);
       
       
        ps.executeUpdate();
        }
        
        // update values in database
        else
        if(request.getParameter("save").equals("Update"))
        {
        PreparedStatement ps=con.prepareStatement("update employees set deptid=?,jobtitle=?,first_name=?,last_name=?,birthdate=?,hiredate=?,address=?,city=?,state=?,postalcode=?,country=?,home_contact_no=?,office_contact_no=?,email=? where empid=?");
        
        ps.setString(1,deptid);
        ps.setString(2,jobtitle);
        ps.setString(3,firstname);
        ps.setString(4,lastname);
        ps.setString(5,(birthdate));
        ps.setString(6,(hiredate));
        ps.setString(7,address);
        ps.setString(8,city);
        ps.setString(9,state);
        ps.setString(10,postalcode);
        ps.setString(11,country);
        ps.setInt(12,hcontactno);
        ps.setInt(13,ocontactno);
         ps.setString(14,email);
        
        ps.setString(15,empid);
        ps.executeUpdate();
        }
            
//        con.commit();
        con.close();
                

        
    }
        catch(SQLIntegrityConstraintViolationException se)
        { System.out.println("This employee id already exist");}
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
                        PreparedStatement ps = con.prepareStatement("select * from  employees");
                        ResultSet rs1 = ps.executeQuery();
                        ResultSetMetaData rsmd=rs1.getMetaData();
                        out.println("<tr class=\"edth\">");
                        out.println("<td>Action");
                        
                        for(int i=1;i<=rsmd.getColumnCount();i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                        out.println("</tr>");
        
                        PreparedStatement ps1=con.prepareStatement("select * from  employees");
        ResultSet rs=ps1.executeQuery();
                            out.println("<tr class=\"edt\">");
    
                            
        while(rs.next())
        {
            out.println("<tr><td><a href=addemployee.jsp?act=e&empid="+rs.getString(1)+ "&deptid="+rs.getString(2)+"&jobtitle="+rs.getString(3).replace(" ","%20")+"&first_name="+rs.getString(4)+"&last_name="+rs.getString(5)+"&email="+rs.getString(15)+"&address="+rs.getString(7)+"&city="+rs.getString(8)+"&state="+rs.getString(14)+"&postalcode="+rs.getString(9)+"&country="+rs.getString(10)+"&birthdate="+rs.getString(6)+"&hiredate="+rs.getString(13)+"&hcontactno="+rs.getInt(11)+"&ocontactno="+rs.getInt(12)+"&address="+rs.getString("address")+">Edit</a> / <a href=addemployee.jsp?act=d&empid=" + rs.getString(1) +"> Delete </a>");
        
        for(int i=1;i<=rsmd.getColumnCount();i++)
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