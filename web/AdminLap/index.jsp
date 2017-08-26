<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<html>
    <link rel=stylesheet href=style.css>
    <body >
    <center>        <img src="../images/logo.gif"><br><br><br>

        <table class="tbstyle" align="center" style="width: 400px;padding:20px;border-radius: 20px" cellpadding="10">
        <form>
            <tr align="center"><td colspan="2"><h1>Admin Login</h1></tr>
            <tr align="center">    <td><input type="text" name="username" class="inputtxt" placeholder="User Name" required="User Name" style="text-align: center"></tr>
            <tr align="center"><td><input type="password" name="password" class="inputtxt" placeholder="Password" required="Password" style="text-align: center"></tr>
            <tr align="center"><td ><input type="submit" value="Login" name="login" class="bttxt" style="width:100px">
          <input type="reset" value="Clear" class="bttxt" style="width:100px"></tr>
        </form>
        </table>
<% 
if(request.getParameter("login")!=null)
{
   String un=request.getParameter("username");
   String pwd=request.getParameter("password");
           try{
           Class.forName("oracle.jdbc.driver.OracleDriver");
           Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");

                        PreparedStatement st=con.prepareStatement("select * from adminuser where username=? and password=?");
                        st.setString(1,un);
                        st.setString(2,pwd);
                        
                        ResultSet rs=st.executeQuery();
                        if(rs.next())
                        {
                            session.setAttribute("status", "active");
                            response.sendRedirect("menu.jsp");
                        }
           }
           catch(Exception e){out.println(e);}

}

    %>
    
</body>
</html>