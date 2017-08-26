<html>
    <link rel=stylesheet href=style.css>
    <body >
  <div style="height: 200px;position:absolute;">
    <%@include file="menu.jsp" %>
    </div>
  <div style="width: 30%;position:absolute;margin-top: 100">
  
        <ol>
    <li class="leftmenu">Laptop 
        <ol>
            <li class="leftmenu"><a href="addlaptops.jsp"> Add</a></li>
        <li class="leftmenu"><a href="editlaptops.jsp"> Edit/Delete</a></li>
        
        </ol>
        
       
    <li class="leftmenu">Accessories 
        <ol>
            <li class="leftmenu"><a href="addaccessories.jsp"> Add</a></li>
        <li class="leftmenu"><a href="editaccessories.jsp"> Edit/Delete</a></li>
        
        </ol>
        
        <!-- laptop stocks-->
    <li class="leftmenu">Stock</li>
    <ol>
        <li class="leftmenu">Laptop Stock
    <ol>
        <li class="leftmenu"><a href="stocks.jsp"> Add a New Stock</a>
        <li  class="leftmenu"><a href="viewstocks.jsp"> View Stock as per model no</a>
        <li  class="leftmenu"><a href="viewstocksall.jsp"> View Stock </a>
    </ol>
        
            
        <!-- accessories stocks-->
           
        <li class="leftmenu">Accessories Stock
            <ol>
            <li class="leftmenu"><a href="stocksA.jsp"> Add a New Stock</a>
        <li  class="leftmenu"><a href="viewstocksA.jsp"> View Stock as per model no</a>
        <li  class="leftmenu"><a href="viewstocksallA.jsp"> View Stock </a>
        
    </ol>
    <li class="leftmenu"><a href=producttypes.jsp>Product Type</a></li>

    <li class="leftmenu"><a href=brands.jsp>Brand</a></li>
        </ol>
  </div>
  </body>
</html>