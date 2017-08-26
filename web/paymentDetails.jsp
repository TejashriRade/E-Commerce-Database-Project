<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" id="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
      
      <script src="js/index.js"></script>
        <script src="js/prefixfree.min.js"></script>

    <title>Payment Detail</title>
    
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <title></title>
      <link rel="stylesheet" href="css/style.css" type="text/css" />
      <!--[if IE 7]>
              <link rel="stylesheet" href="css/ie7.css" type="text/css" />
      <![endif]-->
  </head>
    
    
        <style>
      
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  height: 100%;
}

body {
  font: 16px/1 'Open Sans', sans-serif;
  color: #550;
  background: #ddd;
}

.title {
  padding: 35px 0 40px;
  text-align: center;
}

.title span {
  display: block;
  margin: 0 0 15px;
  font-size: 30px;
}

.payment {
  width: 500px;
  margin: 0 auto;
  padding: 35px 0;
 <!-- border-top: 1px solid #acc; -->
 <!-- border-bottom: 1px solid #acc;   -->
}

[placeholder]::-webkit-input-placeholder {
  color: rgba(0, 0, 0, 0.2);
}

[placeholder]:hover::-webkit-input-placeholder {
  color: rgba(0, 0, 0, 0.15);
}

[placeholder]:focus::-webkit-input-placeholder {
  color: transparent;
}

[placeholder]::-moz-placeholder {
  color: rgba(0, 0, 0, 0.2);
}

[placeholder]:hover::-moz-placeholder {
  color: rgba(0, 0, 0, 0.15);
}

[placeholder]:focus::-moz-placeholder {
  color: transparent;
}

[placeholder]:-ms-input-placeholder {
  color: rgba(0, 0, 0, 0.3);
}

[placeholder]:hover:-ms-input-placeholder {
  color: rgba(0, 0, 0, 0.15);
}

[placeholder]:focus:-ms-input-placeholder {
  color: transparent;
}

button::-moz-focus-inner,
input::-moz-focus-inner {
  border: 0;
  padding: 0;
}

label, input, button {
  display: block;
  width: 200px;
  margin: 0 auto 10px;
}

label {
  font-size: 13px;
  font-weight: 600;
  color: #999;
}

input {
  padding: 10px 15px;
  font-size: 14px;
  color: inherit;
  border: 1px solid #aaa;
  outline: 0;
}

button {
  padding: 10px 15px;
  font-size: 14px;
  font-weight: 600;
  color: #fff;
  border: 0;
  border-bottom: 3px solid #37b;
  background: #48c;
}

input.invalid {
  border: 1px solid red;
}

.validation.failed:after {
  color: lightseagreen;
  content: 'Validation failed';
}

.validation.passed:after {
  color: lightgreen;
  content: 'Validation passed';
}

            
            
            
       
    </style>

    
      
    
  </head>
    
    
    <!--  pay now button function -->
    <script>
function mypay() {
    alert("Thank You for Payment...s");
    }
</script>
    
     <script>
function validateForm1() {
    var x = document.forms["myForm1"]["cardnumber"].value;
    var y = document.forms["myForm1"]["expires"].value;
    var z = document.forms["myForm1"]["cvc"].value;
    if (x === null || x === "") {
        alert("Card Number must be filled out");
        return false;
    }
    if (y === null || y === "") {
        alert("Expire date must be filled out");
        return false;
    }
     if (z === null || z === "") {
        alert(" CVC must be filled out");
        return false;
    }
    mypay();
}
</script>
    

  <body>
      
      
      <div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
                               <%@include file="menus.jsp" %>
	                        
                         </div>
        
</div>

<div class="title">
  <span>Payment Details</span>
 
</div>
<div class="payment">
     <% session.setAttribute("Userid", null);
                            session.removeAttribute("Userid");
                            
                            session.setAttribute("modelno", null);
                            session.removeAttribute("modelno");
                            session.removeAttribute("cart");
                            session.removeAttribute("qty");
                            session.removeAttribute("productid");
        %>               
    <br><br>
  <form novalidate autocomplete="on"  id="myForm1" onsubmit="return validateForm1()" method="post" action="index.jsp">
      
      
      <fieldset>
    
    <label>Card number:</label>
    <input type="text" name="cardnumber" class="cc-number" pattern="\d*" x-autocompletetype="cc-number" placeholder="????-????-????-????" required />

    <label>Expires:</label>
    <input type="text" name="expires" class="cc-exp" pattern="\d*" x-autocompletetype="cc-exp" placeholder="MM / YYYY" required maxlength="9" />

    <label>CVC:</label>
    <input type="text" name="cvc" class="cc-cvc" pattern="\d*" x-autocompletetype="cc-csc" placeholder="123" required maxlength="4" autocomplete="off" />

    <label class="validation"></label>

    <button type="submit" >PayNow</button>
   </fieldset>
  </form>

</div>
    
        

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
      
  </body>
</html>
