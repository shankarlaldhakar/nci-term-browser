<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="org.LexGrid.concepts.Entity" %>
<%@ page import="gov.nih.nci.evs.browser.bean.*" %>
<%@ page import="gov.nih.nci.evs.browser.utils.*" %>
<%@ page import="gov.nih.nci.evs.browser.properties.*" %>
<%@ page import="gov.nih.nci.evs.browser.utils.*" %>
<%@ page import="javax.faces.context.FacesContext" %>
<%@ page import="org.LexGrid.LexBIG.DataModel.Core.ResolvedConceptReference" %>
<%@ page import="org.apache.log4j.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:c="http://java.sun.com/jsp/jstl/core">
<head>
  <title>NCI Thesaurus</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/styleSheet.css" />
  <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon" />
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/search.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/dropdown.js"></script>
</head>
<body>
  <script type="text/javascript"
    src="<%=request.getContextPath()%>/js/wz_tooltip.js"></script>
  <script type="text/javascript"
    src="<%=request.getContextPath()%>/js/tip_centerwindow.js"></script>
  <script type="text/javascript"
    src="<%=request.getContextPath()%>/js/tip_followscroll.js"></script>


  <%!
    private static Logger _logger = Utils.getJspLogger("value_set_search_results.jsp");
  %>
  <f:view>
    <!-- Begin Skip Top Navigation -->
      <a href="#evs-content" class="hideLink" accesskey="1" title="Skip repetitive navigation links">skip navigation links</A>
    <!-- End Skip Top Navigation -->  
    <%@ include file="/pages/templates/header.jsp" %>
    <div class="center-page">
      <%@ include file="/pages/templates/sub-header.jsp" %>
      <!-- Main box -->
      <div id="main-area">
        <%@ include file="/pages/templates/content-header-valueset.jsp" %>
        
<%

String valueSetSearch_requestContextPath = request.getContextPath();

System.out.println("valueSetSearch_requestContextPath: " + valueSetSearch_requestContextPath);


String message = (String) request.getSession().getAttribute("message");     
String vsd_uri = (String) request.getParameter("uri"); 
Vector vsd_vec = null;

%>
        <div class="pagecontent">
          <a name="evs-content" id="evs-content"></a>
          <%@ include file="/pages/templates/navigationTabs.jsp"%>
          <div class="tabTableContentContainer">
          
          <table>
            <tr>
<%           
if (vsd_uri != null && vsd_uri.compareTo("null") != 0) { 

    String vsd_metadata = DataUtils.getValueSetDefinitionMetadata(DataUtils.findValueSetDefinitionByURI(vsd_uri));
    vsd_vec = new Vector();
    vsd_vec.add(vsd_metadata);
%>
     
            <td class="texttitle-blue">Value Set:&nbsp;<%=vsd_uri%></td>
<%            
} else {
    vsd_vec = (Vector) request.getSession().getAttribute("matched_vsds");
%>
            <td class="texttitle-blue">Matched Value Sets</td>
<%
}
%>
            
            </tr>

            <% if (message != null) { %>
        <tr class="textbodyred"><td>
      <p class="textbodyred">&nbsp;<%=message%></p>
        </td></tr>
            <% } else { %>

            <tr class="textbody"><td>

 <h:form id="valueSetSearchResultsForm" styleClass="search-form">            
 
 <%
 if (vsd_uri != null) {
 %>
 
    <input type="hidden" name="valueset" value="<%=vsd_uri%>">&nbsp;</input>
    
<%
 }
 %>
 
 
              <table class="dataTable" summary="" cellpadding="3" cellspacing="0" border="0" width="100%">

		<th class="dataTableHeader" scope="col" align="left">&nbsp;</th>
              
                <th class="dataTableHeader" scope="col" align="left">URI</th>
                <th class="dataTableHeader" scope="col" align="left">Description</th>
                <th class="dataTableHeader" scope="col" align="left">Concept Domain</th>
                <th class="dataTableHeader" scope="col" align="left">Sources</th>


<%
if (vsd_vec != null) {
            for (int i=0; i<vsd_vec.size(); i++) {
            
		    String vsd_str = (String) vsd_vec.elementAt(i);
		    Vector u = DataUtils.parseData(vsd_str);
		    String uri = (String) u.elementAt(0);
		    String label = (String) u.elementAt(1);
		    String cd = (String) u.elementAt(2);
		    String sources = (String) u.elementAt(3);

		    if (i % 2 == 0) {
		    %>
		      <tr class="dataRowDark">
		    <%
			} else {
		    %>
		      <tr class="dataRowLight">
		    <%
			}
		    %>    

		<td>
<%		
if (vsd_vec.size() == 1) {
%>
		<input type=radio name="valueset" value="<%=uri%>" checked>&nbsp;</input>
<%
} else {
%>
		<input type=radio name="valueset" value="<%=uri%>">&nbsp;</input>
<%		
}
%>
		     
		</td>
					
		      <td class="dataCellText">
			 <%=uri%>
		      </td>
		      <td class="dataCellText">
			 <%=label%>
		      </td>
		      <td class="dataCellText">
			 <%=cd%>
		      </td>
		      <td class="dataCellText">
			 <%=sources%>
		      </td>  

		      </tr>
              
              
             <%
                }
             }
             %>                 
                  
              </table>

                  <tr><td>
                    <h:commandButton id="resolve" value="resolve" action="#{valueSetBean.resolveValueSetAction}"
                      onclick="javascript:cursor_wait();"
                      image="#{valueSetSearch_requestContextPath}/images/resolve.gif"
                      alt="Resolve"
                      tabindex="2">
                    </h:commandButton>
&nbsp;&nbsp;

                    <h:commandButton id="export" value="export" action="#{valueSetBean.exportToXMLAction}"
                      onclick="javascript:cursor_wait();"
                      image="#{valueSetSearch_requestContextPath}/images/export.gif"
                      alt="Export to LexGridXML"
                      tabindex="3">
                    </h:commandButton>
                  
                  </td></tr>
              
              <input type="hidden" name="referer" id="referer" value="<%=HTTPUtils.getRefererParmEncode(request)%>">
</h:form>
            
          </td></tr>
          
          
 <% } %>
          
          
        </table>
        </div> <!-- end tabTableContentContainer -->
        
        <%@ include file="/pages/templates/nciFooter.jsp" %>
      </div>
      <!-- end Page content -->
    </div>
    <div class="mainbox-bottom"><img src="<%=basePath%>/images/mainbox-bottom.gif" width="745" height="5" alt="Mainbox Bottom" /></div>
    <!-- end Main box -->
  </div>
</f:view>
</body>
</html>