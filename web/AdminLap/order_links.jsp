<html>
    <link rel=stylesheet href=style.css>
    <body >
  <div style="height: 200px;position:absolute;">
    <%@include file="menu.jsp" %>
    </div>
  <div style="width: 30%;position:absolute;margin-top: 100">
      <ol>
      
    <li class="leftmenu">View Orders
        <ul >
            <li> <a href="viewordersall.jsp?ostatus=ordered">New Orders</a></li>
            <br><br><li> <a href="viewordersall.jsp?ostatus=Shipped">Shipped</a></li>
            <br><Br><li> <a href="viewordersall.jsp?ostatus=Delivered">Delivered</a></li>

        </ul>
    </li>
    <li class="leftmenu"><a href="status.jsp">Order Status</a></li>
    

        </ol>
  </div>
  </body>
</html>