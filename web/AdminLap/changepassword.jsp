<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<link rel=stylesheet href=style.css>

  <div style="height: 200px;position:absolute;">
    <%@include file="menu.jsp" %>
    </div>
         <div style="width: 100%;position:absolute;margin-top: 150;">

<body >
        <table class="tbstyle" align="center" style="width: 400px;padding:20px;border-radius: 20px" cellpadding="10">
            <form >
            <tr align="center"><td colspan="2"><h1>Change Password</h1></tr>
            <tr align="center"><td> Old Password <td> <input type="password" name="OldPassword" class="inputtxt"  style="text-align: center"></tr>
             <tr align="center"> <td> New Password  <td> <input type="text" name="Newpassword" class="inputtxt"   style="text-align: center"></tr>
            <tr align="center"><td> Confirm Password <td> <input type="password" name="ConfirmPassword" class="inputtxt"  style="text-align: center"></tr>
           <tr align="center"><td ><input type="submit" value="Change Password" name="Change" class="bttxt" style="width:180px">
          <td><input type="reset" value="Clear" class="bttxt" style="width:100px"></tr>
        </form>
        </table>

<%
    if(request.getParameter("Change")!=null)
    {
        String oldpass=request.getParameter("OldPassword");
        String newpass=request.getParameter("Newpassword");
        String confirmpass=request.getParameter("ConfirmPassword");
        if(newpass.equals(confirmpass))
        {
        
                    try {
                        
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("update adminuser set password=? where password=? and username=?");
                        ps.setString(1,newpass);
                        ps.setString(2,oldpass);
                        ps.setString(3,"tejashri");
int                        cnt=ps.executeUpdate();
                        if(cnt==1)
                        {
                            out.println("Change Password Successfully <a href=index.jsp>Login Here</a>");
                            session.removeAttribute("status");
                        }
                        else
                        {
                        out.println("Can't Change Password");
                        }
                            
                        }catch(Exception e){}
        }
        else
            out.println("<h2><font color=red>New Password and Confirm Password not a same </font></h2>");
        }     
%>
    </body>
</html>