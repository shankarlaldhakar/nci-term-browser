<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page import="gov.nih.nci.evs.browser.utils.DataUtils" %>
<%
  String ncim_url_link = new DataUtils().getNCImURL();
%>
<table border="0" width="700px">
  <tr>
    <td>
    <div class="texttitle-blue">Welcome</div>
    </td>
    <td>
    <div class="texttitle-blue-rightJust">Version: <%=voc_version%></div>
    </td>
  </tr>
</table>
<hr />
<table border="0">
  <tr>
    <td class="textbody" width="407px" align="left" valign="top"><%=voc_description%> <br>
    <br>
    </td>
    <td valign="top" width="308px">
    <table border="0" width="100%">
      <tr valign="top">
        <td width="10px"></td>
        <td><a href="http://evs.nci.nih.gov/" target="_blank"
          alt="EVS"> <img src="<%=basePath%>/images/EVSTile.gif"
        width="77" height="38px" alt="EVS" border="0"/> </a></td>
        <td width="3px"></td>
        <td class="textbody" valign="top"><a
          href="http://evs.nci.nih.gov/" target="_blank" alt="EVS">
        NCI Enterprise Vocabulary Services</a>: Terminology resources and
        services for NCI and the biomedical community.</td>
      </tr>
      <tr valign="top">
        <td width="10px"></td>
        <td><a href="<%=ncim_url_link%>" target="_blank"
        alt="NCIm"> <img src="<%=basePath%>/images/NCImTile.gif"
        width="77" height="38px" alt="NCIm" border="0"/> </a></td>
        <td width="3px"></td>
        <td class="textbody" valign="top"><a href="<%=ncim_url_link%>"
        target="_blank" alt="NCIm"> NCI Metathesaurus</a>: Comprehensive
        database of 4,600,000 terms from 70 terminologies.</td>
      </tr>
      <tr valign="top">
        <td width="10px"></td>
        <td><a href="<%=request.getContextPath()%>/start.jsf"
        alt="NCI Term Browser"> <img src="<%=basePath%>/images/EVSTermsBrowserTile.gif"
        width="77" height="38px" alt="Bio Portal" border="0"/> </a></td>
        <td width="3px"></td>
        <td class="textbody" valign="top"><a href="<%=request.getContextPath()%>/start.jsf"
        alt="NCI Term Browser"> NCI Term Browser</a>: NCI and other
        terminologies in an integrated ontology environment.</td>
      </tr>
      <tr valign="top">
        <td width="10px"></td>
        <td><a
          href="http://www.cancer.gov/cancertopics/terminologyresources/"
          target="_blank" alt="NCI Terminology Resources"> <img
          src="<%=basePath%>/images/Cancer_govTile.gif" alt="NCI
        Terminology Resources" border="0"/> </a></td>
        <td width="3px"></td>
        <td class="textbody" valign="top"><a
          href="http://www.cancer.gov/cancertopics/terminologyresources/"
          target="_blank" alt="NCI Terminology Resources"> NCI
        Terminology Resources</a>: More information on NCI dictionaries and
        resources.</td>
      </tr>
    </table>
    </td>
  </tr>
</table>