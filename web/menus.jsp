<%-- 
    Document   : menus.jsp
    Created on : Jun 30, 2016, 5:40:41 AM
    Author     : radet
--%>

<!DOCTYPE html>
				<ul>
					<li class="selected"><a href="index.jsp">Home</a></li>
					<li><a href="laptop.jsp">Laptop</a></li>
					<li><a href="accessories.jsp">Accessories</a></li>
					<li><a href="addtocart.jsp">Cart</a></li>
                                        <% 
                                            if(session.getAttribute("Userid")!=null)
                                            {
                                                out.println("<li><a href=orderstatus.jsp>Order Status</a></li>");

                                                out.println("<li><a href=logout.jsp>Log out</a></li>");
                                            
                                            }
                                            else
                                                out.println("<li><a href=customerLogin.jsp>Log in</a></li>");
                                            
                                        %>
                                            
                                </ul>
