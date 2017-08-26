<html>
    <link rel=stylesheet href=style.css>
    <body >
<% 
                            session.setAttribute("status", null);
                            session.removeAttribute("status");
                            response.sendRedirect("index.jsp");



    %>
    
</body>
</html>