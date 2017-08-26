<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title></title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <!--[if IE 7]>
                <link rel="stylesheet" href="css/ie7.css" type="text/css" />
        <![endif]-->
    </head>
    <body>
        <div class="page">
            <div class="header">
                <a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                    <%@include file="menus.jsp" %>
            </div>
            <!--                        select * from (select a.*,rownum rnum from(select * from stock order by srno) a where rownum<=10) where rnum>=4;-->
            <div class="body">
                <ul>
                    <%     ArrayList<String> modelcartv = null;
                        double Totalamt = 0, total;

                        int oid = 1, qq = 0;
                        double scharge;
                        String on = "", odate = "";
                        Connection con;
                        if (session.getAttribute("Userid") == null) {
                            response.sendRedirect("logout.jsp");
                        } else {
                            if (session.getAttribute("cart") != null) {
                                modelcartv = (ArrayList<String>) session.getAttribute("cart");
                            } else {
                                out.println("No Items in Cart..");
                            }
                    %>
                    <div style="background-color: white;width:900px;border-radius: 20px;padding:20px">
                        <form>
                            <table>
                                <tr><td>Order Number <td> <input type="text" name="orderno" readonly value="<%=request.getParameter("orderno")%>"><td>Order Id <Td> <input type="text" name="orderid" readonly value="<%=request.getParameter("orderno").substring(0, request.getParameter("orderno").indexOf("-"))%>"></tr>
                                <tr><td>Customer Name <td> <%=request.getParameter("first_name")%>  <%=request.getParameter("last_name")%><td>Customer Id <Td><input type="text" name="custid" readonly value="<%=session.getAttribute("Userid")%>"></tr>
                                <tr><td>Delivery Address<td> <input type="text" name="address" value="<%=request.getParameter("saddress1") + "," + request.getParameter("saddress2")%>"> <td>City <Td><input type="text" name="city" value="<%=request.getParameter("scity")%>"></tr>
                                <tr><td><td> <input type="text" name="state" value="<%=request.getParameter("sstate")%>"> - <input type="text" name="country" value="<%=request.getParameter("scountry")%>"> <td>Postal Code <Td><input type="text" name="postalcode" value="<%=request.getParameter("spostalcode")%>"></tr>

                                <tr><td>Total No of Items <td> <input type="text" name="totalitems" readonly value="<%=modelcartv.size()%>"> <td> Order Date & Time <Td> <input type="text" readonly name="orderdt" value="<%=request.getParameter("odate")%>"></tr>

                            </table>
                            <br><br>
                            <table>
                                <tr bgcolor="gray"> <td> Model No <Td> Brand <td> Product Type <td> Rate per unit <td> Qty <td> Amount </tr>

                                <%

                                        for (int i = 0; i < modelcartv.size(); i++) {
                                            String data = modelcartv.get(i);
                                            String mn = data.substring(0, data.indexOf(","));
                                            String q = data.substring(data.indexOf(",") + 1, data.lastIndexOf(","));
                                            String pt=data.substring(data.lastIndexOf(",")+1,data.length());
                                            try {
                                                PreparedStatement ps;
                                               con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                                                if(pt.equals("2"))
                                                {
                                                ps = con.prepareStatement("select laptop_system_info.*,products.product_name,brand.brand_name from  laptop_System_info,brand,products where (brand.brandid = laptop_system_info.brandid and products.productid = laptop_system_info.productid )and model_no=? order by model_no ");
                                                ps.setString(1, mn);
                                                }
                                                else
                                                {
                                                ps = con.prepareStatement("select laptop_accessories.*,products.product_name,brand.brand_name from  laptop_accessories,brand,products where (brand.brandid = laptop_accessories.brandid and products.productid = laptop_accessories.productid )and model_no=? order by model_no ");
                                                ps.setString(1, mn);
                                                }
                                                    
                                                ResultSet rs1 = ps.executeQuery();
                                                if (rs1.next()) {
                                                    total = rs1.getDouble("price") * Integer.parseInt(q);
                                                    qq += Integer.parseInt(q);
                                                    out.println("<tr><td><input type=text name=modelno size=15 readonly value='" + mn + "'><td><input type=text  size=15 name=brname readonly value=" + rs1.getString("brand_name") + "><td><input type=text  size=15 readonly name=producttype value=" + rs1.getString("product_name") + "><td><input type=text  size=15  readonly name=unitrate value=" + rs1.getString("price") + "><td><input type=text  size=15 readonly name=qty value=" + q + "><td><input type=text  size=15 name=total readonly value="+ total + "> </tr>");
                                                    Totalamt += total;

                                                }
                                            } catch (Exception e) {
                                            }
                                        }

                                    }//end else
                                %>   
                            </table>
                            <br><br>
                            <table border="0">

                                <tr><td>Total Quantity <td> <input type=text readonly name=totalqty value="<%=qq%>"></tr>
                                <tr><td>Total Amount <td> <input type=text readonly name=totalamount value="<%=Totalamt%>"></tr>

                                <tr><td>Discount       <td> <input type=text readonly name=discount value=<% double dis = 0;
                                        out.println(dis); %>>
                                <tr><td>Shipping Charges <td><input type=text readonly name=scharges value="<% if (Totalamt < 500) {
                                            scharge = 0;
                                        } else {
                                            scharge = Totalamt * 0.02;
                                        }
                                        out.println(scharge);%>"> <sup>*(if net amt less than $500 then shipping charges extra 2%)</sup></tr>
                                <tr><td>Net Amount to be Pay <td> <input type=text readonly  name=netamt value="<%=(Totalamt + scharge - dis)%>"></tr>
                                <tr><td align="center" colspan="5"> <br><input type=submit value="Confirm & Proceed to Payment"  name="cnt"> </tr>


                            </table>
                        </form>
                        <% 
                            
                     if(request.getParameter("cnt")!=null)
                            {
                                int custid=Integer.parseInt(request.getParameter("custid"));
                                int orderid=Integer.parseInt(request.getParameter("orderid"));
                                String orderno=request.getParameter("orderno");
                                String address1=request.getParameter("address");
                                String city=request.getParameter("city");
                                String state=request.getParameter("state");
                                Long postalcode=Long.parseLong(request.getParameter("postalcode"));
                                String orderdt=request.getParameter("orderdt");
                                String country=request.getParameter("country");
                                String tot_items=request.getParameter("totalitems");
                                String tot_qty=(request.getParameter("totalqty"));
                                String tot_amt=(request.getParameter("totalamount"));
                                String discount=request.getParameter("discount");
                                String excharges=request.getParameter("scharges");
                                String amt= request.getParameter("netamt");
                                        
                                        
                                       
                                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                              
                                    int sid=1;
                                    Statement st=con.createStatement();
                                    ResultSet rs5=st.executeQuery("Select max(status_id) from order_status");
                                    if(rs5.next())
                                    {
                                    sid=rs5.getInt(1)+1;
                                    }

                                PreparedStatement ps1 = con.prepareStatement("insert into orders (orderid,order_number,customerid,shipaddress,shipcity,shipstate,shippostalcode,shipcountry,order_date_time,total_items,total_qty,total_amt,discount,extra_charges,amt_pay,status_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");                                                        
                                     
                                ps1.setInt(1,orderid);
                                ps1.setString(2,orderno);
                                ps1.setInt(3,custid);
                                ps1.setString(4,address1);
                                ps1.setString(5,city);
                                ps1.setString(6,state);
                                ps1.setLong(7,postalcode);
                                ps1.setString(8,country);
                                ps1.setString(9,orderdt);
                                ps1.setString(10, tot_items);
                                ps1.setString(11, tot_qty);
                                ps1.setString(12, tot_amt);
                                ps1.setString(13, discount);
                                ps1.setString(14, excharges);
                                ps1.setString(15, amt);
                                ps1.setInt(16, sid);
                                ps1.executeUpdate();
                                     

                                        
                               String modno[]=request.getParameterValues("modelno");
                               String producttype[]=request.getParameterValues("producttype");
                               String rateperunit[]=request.getParameterValues("unitrate");
                               String qty[]=request.getParameterValues("qty");
                               String tamt[]=request.getParameterValues("total");
                                     ResultSet rs6;
                               for(int j=0;j<modno.length;j++)
                               {
                                String srnolist="";
                                String srno="";
                                Statement st1=con.createStatement();
                                if(producttype[j].equals("Laptops"))
                                     rs6=st1.executeQuery("Select srno from stock where order_id=0 and model_no='"+modno[j]+"'");
                                else
                                    rs6=st1.executeQuery("Select srno from stockacc where order_id=0 and model_no='"+modno[j]+"'");
                                    
                                for(int k=0;k<Integer.parseInt(qty[j]);k++)
                                {
                                if(rs6.next())
                                {
                                srno=rs6.getString(1);
                                srnolist=srnolist+","+srno;
                                
                                if(producttype[j].equals("Laptops"))
                                { PreparedStatement ps4 = con.prepareStatement("update stock set order_id=? where model_no=? and srno=? ");
                                    ps4.setInt(1,orderid);
                                    ps4.setString(2,modno[j]);
                                    ps4.setString(3,srno);
                                    ps4.executeUpdate();
                                }
                                else
                                {
                                    PreparedStatement ps4 = con.prepareStatement("update stockacc set order_id=? where model_no=? and srno=? ");
                                    ps4.setInt(1,orderid);
                                    ps4.setString(2,modno[j]);
                                    ps4.setString(3,srno);
                                    ps4.executeUpdate();
                                
                                }    
                                }
                                }
                                out.println(srnolist);
                                PreparedStatement ps2 = con.prepareStatement("insert into order_products values(?,?,?,?,?,?,?,?)");                                                        
                                ps2.setInt(1,orderid);
                                ps2.setString(2,modno[j]);
                                ps2.setString(3,producttype[j]);
                                ps2.setInt(4,Integer.parseInt(rateperunit[j]));
                                ps2.setInt(5,Integer.parseInt(qty[j]));
                                ps2.setString(6,tamt[j]);
                                ps2.setString(7,srnolist);
                                ps2.setInt(8,custid);
                                ps2.executeUpdate();
                                if(producttype[j].equals("Laptops"))
                                {
                                 PreparedStatement ps5=con.prepareStatement("update laptop_system_info set quantity=quantity-? where model_no=?");
                        ps5.setInt(1,Integer.parseInt(qty[j]));
                        ps5.setString(2,modno[j]);
                        ps5.executeUpdate();
                                }
                                else
                                {
                                PreparedStatement ps5=con.prepareStatement("update laptop_accessories set quantity=quantity-? where model_no=?");
                        ps5.setInt(1,Integer.parseInt(qty[j]));
                        ps5.setString(2,modno[j]);
                        ps5.executeUpdate();
                                }

                               
                               }

                                PreparedStatement ps3 = con.prepareStatement("insert into order_status values(?,?,?,?,?)");                                                        
                                
                                ps3.setInt(1,orderid);
                                ps3.setString(2,"ordered");
                                ps3.setString(3,"customer");
                                ps3.setString(4,orderdt);
                                ps3.setInt(5,sid);                                
                                ps3.executeUpdate();
                                
                                
                         con.close();
                                        
                         response.sendRedirect("paymentDetails.jsp");
                                        
                                        
                        }
                        %>
                    </div>
            </div>
            <div class="footer">
                <ul>

                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="about.jsp">About</a></li>
                    <li><a href="contactus.jsp">Contact Us</a></li>
                </ul>
                <p>&#169; Copyright &#169; 2016. The little Laptop shops all rights reserved</p>
                <div class="connect">
                    <a href="http://facebook.com/freewebsitetemplates" id="facebook">facebook</a>
                    <a href="http://twitter.com/fwtemplates" id="twitter">twitter</a>
                    <a href="http://www.youtube.com/fwtemplates" id="vimeo">youtube</a>
                </div>
            </div>
        </div>
    </body>
</html>  