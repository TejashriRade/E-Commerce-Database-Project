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
           <%@include file="employee_links.jsp" %>
       
              <div style="margin-top: 8.0%;position: absolute;margin-left: 10%">

            <table id="eddelmenu">
                <tr class="edth"><td>Emp ID <td> Dept Id <td>Job Title<td> First Name<td>Last Name<td>Birth Date<td>Address <td>City <td>Postal Code<td>Country <td>Home Contact No<td>Office Contact No<td>Hire Date<td>State<td>Email  </tr>
                <!--    -->
                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  employees");
                        ResultSet rs = ps.executeQuery();
                        ResultSetMetaData rsmd=rs.getMetaData();
                        
                          /*for(int i=1;i<13;i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                            out.println("</tr>");  */
                        
                            
                              while (rs.next()) {
                            out.println("<tr class=\"edt\">");
                            String s=rs.getString(1).replace(" ","%20");
                            out.println("<td><a href=viewemp.jsp?act=e&mno=" + s +  ">Edit</a> /<a href=viewemp.jsp?act=d&mno=" + s + ">  ");

                            
                             for(int i=1;i<16;i++)
                            {
                            out.println("<td>" + rs.getString(i));
//                            
                            }
                            out.println("<tr>");
                    
                           
                           

        
                        }
                        //        con.commit();
                        con.close();

                    } catch (SQLIntegrityConstraintViolationException se) {
                        System.out.println("This customer id already exist");
                    } catch (Exception e) {
                        //        out.println("error in connection "+ e);
                    }

                %>

                </body>
                </html>