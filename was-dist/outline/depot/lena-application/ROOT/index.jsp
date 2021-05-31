<%--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<%@ page session="false" %>
<%!
/**
 * 해당 서버가 JavaEE를 지원하는 lena-ee인지 여부
 * @return
 */
private boolean hasEnterpriseFeature(){
 ClassLoader classloader = Thread.currentThread().getContextClassLoader();
 try {
  classloader.loadClass("argo.enterprise.catalina.ArgoEEListener");
  return true;
 } catch (ClassNotFoundException e) {
  return false;
 }
}
%>
<%
if ("lena-manager".equals(System.getProperty("lena.name"))) {
	response.sendRedirect("/lena");
}
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
request.setAttribute("year", sdf.format(new java.util.Date()));
request.setAttribute("tomcatUrl", "http://tomcat.apache.org/");
String serverType = "Standard Edition";

if(hasEnterpriseFeature()){
	serverType = "Enterprise Edition";
}
%>
<!DOCTYPE HTML>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" href="images/lena_logo.png" type="image/vnd.microsoft.icon">
	<title>LENA Application Server</title>
	<link type="text/css" rel="stylesheet" href="index.css">
</head>
<body>
	<div id="container">

		<!-- Body -->
		<div id="content">
    		<div id="intro">
				<h2></h2>
				<p>Congratulations! You have successfully setup and started LENA Application Server.  You are ready to go!</p>
			</div>

			<div class="bodyrule"><hr></div>
			
			<div>
				<p>This is the default LENA Application Server index page, which indicates a new server instance was installed, and application is not yet deployed. It is located on the local filesystem at
				<span class="code">@ServerRoot@/webapps/ROOT/index.jsp</span>
				where <span class="code">@ServerRoot@/</span> is the root of the application server instance directory.</p>
				<p>Server Install Information:</p>
				<ul>
					<li>Server ID : <%= System.getProperty("lena.name") %></li>
					<li>Service Port : <%= System.getProperty("port.http") %></li>
					<li>JvmRoute : <%= System.getProperty("jvmRoute") %></li>
				</ul>
			</div>
		</div>

		<div class="clearfix"></div>
		<div id="versions">
			LENA Web Application Server Open Edition
		</div>

	</div>

</body></html>
