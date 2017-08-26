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
        <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">

            <!-- delete logic for brands-->

            <%
                if (request.getParameter("act") != null && request.getParameter("act").equals("d")) {
                    try {
                        int bid = Integer.parseInt(request.getParameter("bid"));
                        String bn = request.getParameter("bn");
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("delete from brand where brandid=?");
                        ps.setInt(1, bid);
                        ps.executeUpdate();
                        //        con.commit();
                        con.close();

                    } catch (SQLIntegrityConstraintViolationException se) {
                        System.out.println("This Product id already exist");
                    } catch (Exception e) {
                        out.println("error in connection " + e);
                    }
                }
            %>
            <Center><h1>Add /Edit/ Delete Product Type </h1></center>
            <form  action="brands.jsp" method="post" enctype="multipart/form-data">

                <table cellpadding="5" align="center" border="0" class="tbstyle">
                    <tr>
                        <td class="lbstyle">Brand id 
                        <td><input type="text" name="bid" class="inputtxt" value="<% if (request.getParameter("act") != null && request.getParameter("act").equals("e")) {
                                out.println(request.getParameter("bid"));
                            }  %>">			
                    </tr>
                    <tr>
                        <td class="lbstyle"> Brand Name  <td>  <input type="text" class="inputtxt" name="bn" value="<% if (request.getParameter("act") != null && request.getParameter("act").equals("e")) {
                                out.println(request.getParameter("bn"));
                            }  %>">

                    </tr>            
                    <tr>
                    <tr><td class="lbstyle"> Select Image <Td><input type="file" name="fl" class="inputtxt"></td>
                    </tr>
                    <tr>


                        <!--  edit logic for brands  -->
                        <% if (request.getParameter("act") != null && request.getParameter("act").equals("e")) {
                                out.println("<td> <input type=submit value=Update class=bttxt name=save>");
                            } else {
                                out.println(" <td> <input type=submit value=Save class=bttxt name=save>");
                            } %>
                        <td><input type="reset" class="bttxt"></td>

                    </tr>
                </table>
            </form>
            <%
                try {
                    String fileName = "";
                    String[] data = new String[3];
                    int cnt = 0;

                    File file;
                    int maxFileSize = 5000 * 1024;
                    int maxMemSize = 5000 * 1024;
                    ServletContext context = pageContext.getServletContext();
                    String filePath = context.getInitParameter("file-upload");
                    String contentType = request.getContentType();
                    if ((contentType.indexOf("multipart/form-data") >= 0)) {
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        // maximum size that will be stored in memory
                        factory.setSizeThreshold(maxMemSize);
                        // Location to save data that is larger than maxMemSize.
                        factory.setRepository(new File("c:\\temp"));
                        // Create a new file upload handler
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        // maximum file size to be uploaded.
                        upload.setSizeMax(maxFileSize);
                        try {
                            // Parse the request to get file items.
                            List fileItems = upload.parseRequest(request);

                            // Process the uploaded file items
                            Iterator i = fileItems.iterator();
                            while (i.hasNext()) {
                                FileItem fi = (FileItem) i.next();
                                if (fi.isFormField()) {
                                    String cName = fi.getFieldName();
                                    String vale = fi.getString();
                                    data[cnt++] = vale;
    //           out.println(vale);
                                }
                                if (!fi.isFormField()) {
                                    // Get the uploaded file parameters
                                    String fieldName = fi.getFieldName();
                                    fileName = fi.getName();
                                    boolean isInMemory = fi.isInMemory();
                                    long sizeInBytes = fi.getSize();
                                    // Write the file
                                    if (fileName.lastIndexOf("\\") >= 0) {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\")));
                                    } else {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\") + 1));
                                    }
                                    fi.write(file);
  //          out.println("Uploaded Filename: " + filePath +           fileName + "<br>");
                                }
                            }
//       out.println("</body>");
//       out.println("</html>");
                            //   }catch(Exception ex) {
//       System.out.println(ex);
//    }
//    
                            //else
                            //     out.println("<p>No file uploaded</p>"); 
                            //    }

                            //                     try {
                            int bid = Integer.parseInt(data[0]);
                            String bn = data[1];

                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                            if (data[2].equals("Save")) {
                                PreparedStatement ps = con.prepareStatement("insert into brand(brandid,brand_name,brandimage) values(?,?,?)");
                                ps.setInt(1, bid);
                                ps.setString(2, bn);
                                ps.setString(3, fileName);
                                ps.executeUpdate();
                            } else if (data[2].equals("Update")) {
//                                    out.println("updates in process"+fileName);
                                PreparedStatement ps = con.prepareStatement("update brand set brandid=?, brand_name=? ,brandimage=? where brandid=? or brand_name=?");
                                ps.setInt(1, bid);
                                ps.setString(2, bn);
                                ps.setString(3, fileName);
                                ps.setInt(4, bid);
                                ps.setString(5, bn);

                                ps.executeUpdate();
                            }

                            //        con.commit();
                            con.close();

                        } catch (SQLIntegrityConstraintViolationException se) {
                            System.out.println("This Brand id already exist");
                        } catch (Exception e) {
                            out.println("error in connection " + e);
                        }
                    }
                } catch (Exception e) {
//    out.println(e);
                }
            %>
            <table id="eddelmenu">
                <tr class="edth"><td>Brand ID <td> Brand Name<td>Logo<td>Action</tr>
                <!--    -->
                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
                        PreparedStatement ps = con.prepareStatement("select * from  brand");
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            out.println("<tr class=\"edt\"><td>" + rs.getInt(1));
                            out.println("<td>" + rs.getString("brand_name"));
                            out.println("<td><img src=..\\images\\" + rs.getString("brandimage") + " height=100 width=100>");

                            out.println("<td><a href=brands.jsp?act=e&bid=" + rs.getInt(1) + "&bn=" + rs.getString("brand_name") + ">Edit</a> /<a href=brands.jsp?act=d&bid=" + rs.getInt(1) + "&bn=" + rs.getString("brand_name") + "> Delete </tr>");
                        }
                        //        con.commit();
                        con.close();

                    } catch (SQLIntegrityConstraintViolationException se) {
                        System.out.println("This Brand id already exist");
                    } catch (Exception e) {
                        //        out.println("error in connection "+ e);
                    }

                %>

                </body>
                </html>