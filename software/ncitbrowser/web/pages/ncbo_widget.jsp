<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="gov.nih.nci.evs.browser.utils.*" %>
<%@ page import="gov.nih.nci.evs.browser.common.*" %>
<%@ page import="gov.nih.nci.evs.browser.properties.*" %>

<%
  String basePath = request.getContextPath();
  String dictionary = HTTPUtils.cleanXSS((String) request.getParameter("dictionary"));
  String code = HTTPUtils.cleanXSS((String) request.getParameter("code"));
  String url = DataUtils.getVisualizationWidgetURL(dictionary, code);

%>


<html>
<head></head>
<body>

<%
if (url == null) {
%>
<p class="textbodyred">Visualization not supported.</p>
<%     
} else {

//System.out.println(url);

%>
<iframe title="NCBO visualization widget" src="<%=url%>" width="550" height="550" frameborder="0">
</iframe>
<%
}
%>	
</body>
</html>

