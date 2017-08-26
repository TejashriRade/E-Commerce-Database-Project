<html>
    <link rel=stylesheet href=style.css>
    <body >
<% 
                            session.setAttribute("Userid", null);
                            session.removeAttribute("Userid");
                            
                            session.setAttribute("modelno", null);
                            session.removeAttribute("modelno");
                            session.removeAttribute("cart");
                            session.removeAttribute("qty");
                            session.removeAttribute("productid");
                            
                            response.sendRedirect("index.jsp");



    %>
    
</body>
</html>