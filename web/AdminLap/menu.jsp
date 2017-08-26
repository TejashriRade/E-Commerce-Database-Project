<html>
    <link rel=stylesheet href=style.css>
<body >
    <img src="../images/logo.gif" style="float: left;padding-left: 50px;padding-right: 50px">
    <% if(session.getAttribute("status")!=null)
        {
%>
<div style="width:1400px">
    <h2 style="background-color: white;width:800px;margin-left: 420px;text-align: center"> Admin Panel</h2>
<ul style="margin-top: 35px">
    
    <li class="menu"><a href="product_links.jsp"> Products</a></li>
    <li class="menu"><a href="customers_links.jsp">Customers</a></li>
    <li class="menu"><a href="employee_links.jsp">Employee</a></li>
    <li class="menu"><a href="departments.jsp">Department</a></li>
    <li class="menu"><a href="supplier_links.jsp">Suppliers</a></li>
    <li class="menu"><a href="order_links.jsp">Orders</a></li>
    <li class="menu"><a href="changepassword.jsp">Change Password</a></li>
    <li class="menu"><a href="logout.jsp">Log out</a>  </li>

    </ul>
<% }
else
{// out.println("You must Login<a href=index.jsp>Here</a>");
response.sendRedirect("index.jsp");
}
%>

</div>
<br><br>
</body>
</html>
