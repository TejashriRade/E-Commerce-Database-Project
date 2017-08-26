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
           <%@include file="customers_links.jsp" %>
          </div>
        <div style="margin-top: 7.0%;position: absolute;margin-left: 10%">

         
          
            <table id="eddelmenu">
                <tr class="edth"><td>Customer ID <td> First Name<td>Last Name<td>Address1<td>Address2 <td>City <td>State <td>Country <td>Contact number <td> Email <td>Postal Code  </tr>
                <!--    -->
                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  customers order by customerid");
                        ResultSet rs = ps.executeQuery();
                        ResultSetMetaData rsmd=rs.getMetaData();
                        
                          /*for(int i=1;i<13;i++)
                           out.println("<td>"+rsmd.getColumnName(i));
                            out.println("</tr>");  */
                        
                            
                              while (rs.next()) {
                            out.println("<tr class=\"edt\">");

                            
                             for(int i=1;i<=rsmd.getColumnCount();i++)
                            {
                                if(i!=11)
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