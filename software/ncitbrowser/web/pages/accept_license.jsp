<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.util.Vector"%>
<%@ page import="org.LexGrid.concepts.Entity" %>
<%@ page import="gov.nih.nci.evs.browser.utils.DataUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:c="http://java.sun.com/jsp/jstl/core">
<head>
  <title>NCI Term Browser</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/styleSheet.css" />
  <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon" />
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/search.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/dropdown.js"></script>
</head>
<%
  JSPUtils.JSPHeaderInfoMore info = new JSPUtils.JSPHeaderInfoMore(request);
  String dictionary = info.dictionary;
  String version = info.version;
  if (info.version_deprecated != null)  //Note: This change will display the version deprecation
    version = info.version_deprecated;  //  message in the concept detail page.
  String display_name = info.display_name;
  String code = (String) request.getParameter("code");
  String licenseStmt = LicenseBean.resolveCodingSchemeCopyright(dictionary, null);

  String matchText_licensedPage = (String) request.getSession().getAttribute("matchText");
  if (dictionary != null) dictionary = dictionary.replaceAll("%20", " ");
%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<f:view>
  <!-- Begin Skip Top Navigation -->
    <a href="#evs-content" class="hideLink" accesskey="1" title="Skip repetitive navigation links">skip navigation links</A>
  <!-- End Skip Top Navigation -->
  <%@ include file="/pages/templates/header.jsp" %>
  <div class="center-page">
    <%@ include file="/pages/templates/sub-header.jsp" %>
    <!-- Main box -->
    <div id="main-area">
      <!-- Thesaurus, banner search area -->
      <div class="bannerarea">
        <div class="banner"><a href="<%=basePath%>/start.jsf"><img src="<%=basePath%>/images/evs_termsbrowser_logo.gif" width="383" height="117" border="0"/></a></div>
      </div>
      <!-- end Thesaurus, banner search area -->
      <!-- Quick links bar -->
      <%@ include file="/pages/templates/quickLink.jsp" %>
      <!-- end Quick links bar -->
      <!-- Page content -->
      <div class="pagecontent">
      	<a name="evs-content" id="evs-content"></a>
        <p>
          To access <b><%=display_name%></b>, please review and accept the copyright/license statement below:
        </p>
        <textarea cols="87" rows="15" readonly align="left"><%=licenseStmt%></textarea>
        <p>
          If and only if you agree to these terms and conditions, click the Accept button to proceed.
        </p>
          <h:form>
            <h:commandButton
              id="accept"
              value="accept"
              action="#{userSessionBean.acceptLicenseAction}"
              image="/images/accept.gif"
              alt="Accept">
            </h:commandButton>

            &nbsp;&nbsp;
            <a href="<%= request.getContextPath() %>/start.jsf">
              <img src="<%= request.getContextPath() %>/images/cancel.gif" border="0" alt="Cancel"/>
            </a>

            <input type="hidden" id="dictionary" name="dictionary" value="<%=dictionary%>" />
            <input type="hidden" id="version" name="version" value="<%=version%>" />
            <input type="hidden" id="code" name="code" value="<%=code%>" />
            <input type="hidden" id="matchText" name="code" value="<%=matchText_licensedPage%>" />

          </h:form>
        <%@ include file="/pages/templates/nciFooter.html" %>
      </div>
      <!-- end Page content -->
    </div>
    <div class="mainbox-bottom"><img src="<%=basePath%>/images/mainbox-bottom.gif" width="745" height="5" alt="Mainbox Bottom" /></div>
    <!-- end Main box -->
  </div>
</f:view>
</body>
</html>