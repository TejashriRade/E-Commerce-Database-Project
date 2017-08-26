<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<html>
    <link rel=stylesheet href=style.css>
    <body >
        <div>
            <%@include file="product_links.jsp" %>

        </div>
        <div style="margin-top: 7.0%;position: absolute;margin-left: 18%">

            <!-- delete logic for brands-->

            <%
                if (request.getParameter("act") != null && request.getParameter("act").equals("d")) {
                    try {
                        String modelno = request.getParameter("mno");
                        out.println(modelno);
                       
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("delete from laptop_system_info where model_no=?");
                        ps.setString(1, modelno);
                        ps.executeUpdate();
                        con.commit();
                        con.close();
                        //response.sendRedirect("editlaptops.jsp");
                    } catch (SQLIntegrityConstraintViolationException se) {
                        System.out.println("This Product id already exist");
                    } catch (Exception e) {
                        out.println("error in connection " + e);
                    }
                }
            %>
            <Center><h1>Add /Edit/ Delete Product Type </h1></center>
            <table id="eddelmenu">
                <!--    -->
                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  laptop_system_info");
                        ResultSet rs = ps.executeQuery();
                        ResultSetMetaData rsmd=rs.getMetaData();
                        out.println("<tr class=\"edth\">");
                        out.println("<td>Action");
                        
                        for(int i=1;i<15;i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                            out.println("</tr>");
                        
                        while (rs.next()) {
                            out.println("<tr class=\"edt\">");
                            String s=rs.getString(1).replace(" ","%20");
                            out.println("<td><a href=updatelaptops.jsp?act=e&mno=" + s +  ">Edit</a> /<a href=editlaptops.jsp?act=d&mno=" + s + "> Delete ");

                            for(int i=1;i<15;i++)
                            {
                            out.println("<td>" + rs.getString(i));
//                            out.println("<td>" + rs.getString("brand_name"));
  //                          out.println("<td><img src=..\\images\\" + rs.getString("brandimage") + " height=100 width=100>");
                            }
                            out.println("<tr>");
                        }
                        //        con.commit();
                        con.close();

                    } catch (SQLIntegrityConstraintViolationException se) {
                        System.out.println("This Brand id already exist");
                    } catch (Exception e) {
                          out.println("error in connection "+ e);
                    }

                %>

                </body>
                </html>