<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>The Little Laptop Shop</title>
		<link rel="stylesheet" href="style.css" type="text/css" />
		
	</head>
	<body>
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                                <%@include file="menus.jsp" %>
                        </div>
			<div class="body">
				<div id="featured">
				</div>
				<ul class="blog">
					<li>
						<div>
                                                    <a href="laptop.jsp?cat=Business"><img src="images/business-1.jpg" alt="" height="200" width="250"/></a>
                                                    <p><h3>Business</h3></p>
							<a href="laptop.jsp?cat=Business">Click to read more</a>
						</div>
					</li>
					<li>
						<div>
							<a href="laptop.jsp?cat=Gaming"><img src="images/gaming.jpg" alt="" height="200" width="250"/></a>
							<p><h3>Gaming</h3></p>
							<a href="laptop.jsp?cat=Gaming">Click to read more</a>
						</div>
					</li>
					<li>
						<div>
							<a href="laptop.jsp?cat=Traditional"><img src="images/traditional.jpg" alt="" height="200" width="250"/></a>
							<p><h3>Traditional</h3></p>
							<a href="laptop.jsp?cat=Traditional">Click to read more</a>
						</div>
					</li>
				</ul>
			</div>
			<div class="footer">
				<ul>
					
					<li><a href="index.jsp">Home</a></li>
					<li><a href="about.jsp">About</a></li>
					<li><a href="contactus.jsp">Contact Us</a></li>
				</ul>
				<p>&#169; Copyright &#169; 2016. The little Laptop shop all rights reserved</p>
				<div class="connect">
					<a href="http://facebook.com/freewebsitetemplates" id="facebook">facebook</a>
					<a href="http://twitter.com/fwtemplates" id="twitter">twitter</a>
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">vimeo</a>
				</div>
			</div>
		</div>
	</body>
</html>  