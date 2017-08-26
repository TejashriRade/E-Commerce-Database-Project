<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<html>
    <script>
        function pvalueselect()
        {
            var p=(document.getElementById("plist").value);
            document.getElementById("pn").value=p;
        }
        function bvalueselect()
        {
            var p=(document.getElementById("blist").value);
            document.getElementById("bn").value=p;
        }
 
    </script>
    <link rel=stylesheet href=style.css>
<body >
    <div>
        <%! Connection con; %>
        <%@include file="product_links.jsp" %>
<%                      Class.forName("oracle.jdbc.driver.OracleDriver");
                         con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "Password");
  %>            
    </div>
        <div style="margin-top: 7.0%;position: absolute;margin-left: 32%">
<Center><h1>Add New Accessories </h1></center>
<form method="post" enctype="multipart/form-data">

<table cellpadding="5" align="center" border="0" class="tbstyle">
<tr>
    <td class="lbstyle">Model No <td> <input type="text" name="modelnumber" class="inputtxt">
</tr>

 
    
        <td class="lbstyle">Product Name
        <td> <select name="productid" id="plist"  class="inputtxt" onchange=pvalueselect()>
                        <option value='none'> </option>
                        <%
                            try{
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from products order by productid");
                        while(rs.next())
                        {
                         out.println("<option value="+rs.getInt(1)+">" + rs.getString(2));
                         
                        }
                            }catch(Exception e){}
                        %>
                   </select>
				
    </tr>
    <tr>
        <td class="lbstyle"> Product Id   <td>  <input type="text" name="productname" class="inputtxt" id="pn">

            </tr>
            
            <tr>
        <td class="lbstyle"> Item Name  <td>  <input type="text" name="itemname" class="inputtxt" id="pn">

                          
            </tr>
           
   <tr>
                        <td class="lbstyle">Brand id 
                        <td><input type="text" id="bn" name="bid" class="inputtxt" value="<% if (request.getParameter("act") != null && request.getParameter("act").equals("e")) {
                                out.println(request.getParameter("bid"));
                            }  %>">			
                    </tr>
    
            <tr>
                <td class="lbstyle"> Brand Name      <td>  <select name="brandname" id="blist" class="inputtxt" onchange="bvalueselect()">
                        <option value='none'> </option>
                        <%
                            try{
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from brand");
                        while(rs.next())
                        {
                         out.println("<option value="+rs.getInt(1)+">" + rs.getString(2));
                         
                        }
                            }catch(Exception e){}
                        %>
                         
                   </select>
            </tr>			             

            <tr>  <td class="lbstyle"> Price    <td><input type="text" name="price" class="inputtxt" required="$" placeholder="$"></tr>

        <tr>
            <td class="lbstyle"> Warranty    <td><input type="text" name="warranty" class="inputtxt"></tr
        
        
        
        <tr>
            <td class="lbstyle"> Quantity   <td><input type="text" name="warranty" class="inputtxt"></tr>

       
            
             <tr>			   
                <td class="lbstyle">Image      <td> <input type="file" name="Picture" class="inputtxt">

</tr>
    <tr>
            <td class="lbstyle">Other description   <td> <textarea rows=4 cols=20 class="inputtxtarea" name="descr"></textarea> 
        </tr>
           

        <tr>
                <td class="lbstyle"> Supplier id      <td>  <select name="supid" id="slist" class="inputtxt" onchange="svalueselect()">
                        <option value='none'> </option>
                        <%
                            try{
                        Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select * from suppliers");
                        while(rs.next())
                        {
                         out.println("<option value="+rs.getString(1)+">" + rs.getString(1));
                        }
                        }catch(Exception e){}
                        %>
                         
                   </select>
            </tr>	

        <tr>
            <td> <input type=submit value="Save" name="save" class="bttxt">
            <td><input type="reset" class="bttxt"></td>
</table>
</form>
      <%
                try {
                    String fileName = "";
                    String[] data = new String[20];
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
//              out.println("<br>"+(cnt-1) +": "+vale);
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
                                    File fname=new File("hh");
                                    file.renameTo(fname);
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
                            String modelno = data[0];
                           int pid=Integer.parseInt(data[2]);
                          
                            String itemname= data[3];
                            double price=Double.parseDouble(data[6]);
                            String warranty= data[7];
                            
                            int quantity= Integer.parseInt(data[8]);
                            String other= data[9];
                           int bid=Integer.parseInt(data[4]);
                           String sid=data[10];
                          

                            if (data[11].equals("Save")) {
                                PreparedStatement ps = con.prepareStatement("insert into laptop_accessories (model_no,productid,item_name,price,warrenty,quantity,other_description,images,"
                                        + "brandid,supplierid) values(?,?,?,?,?,?,?,?,?,?)");
                                ps.setString(1, modelno);
                                ps.setInt(2, pid);
                                
                                ps.setString(3, itemname);
                                ps.setDouble(4, price);
                                ps.setString(5, warranty);
                                
                                ps.setInt(6, quantity);
                                  ps.setString(7, other);
                                    ps.setString(8,fileName);
                                    ps.setInt(9, bid);
                                     ps.setString(10, sid);
                                    
                                    
                                ps.executeUpdate();
                            } 
                            //        con.commit();
                            con.close();

                        } catch (SQLIntegrityConstraintViolationException se) {
                            System.out.println("This Model No already exist");
                        } catch (Exception e) {
                            out.println("error in connection jhk" + e);
                        }
                    }
                } catch (Exception e) {
//    out.println(e);
                }
            %>
      
</body>
</html>